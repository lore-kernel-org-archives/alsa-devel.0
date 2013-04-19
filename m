Return-Path: <alsa-devel-bounces@alsa-project.org>
Date: Fri, 19 Apr 2013 11:57:53 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <20130418212352.GA4454@richardiv.omgwallhack.org>
Message-ID: <Pine.LNX.4.44L0.1304191132130.21363-100000@netrider.rowland.org>
MIME-Version: 1.0
Subject: Re: [alsa-devel] BUG: USB audio discontinuities with 'UHCI:
 implement new semantics for URB_ISO_ASAP'
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tova-dev@tovacompany.com, linux-usb@vger.kernel.org, alsa-devel@vger.kernel.org
List-ID: <alsa-devel@alsa-project.org>

On Thu, 18 Apr 2013, Joe Rayhawk wrote:

> On Thu, Apr 18, 2013 at 12:42:00PM -0400, Alan Stern wrote:
> > On Wed, 17 Apr 2013, Joe Rayhawk wrote:
> > > Small buffer/period sizes on usb audio playback though UHCI works fine on v3.7 but causes audio discontinuities/delays on v3.8 and v3.9-rc7.
> >
> > Can you provide a usbmon trace showing the problems?  And maybe also a 
> > similar trace made under a 3.7 kernel, where the problem doesn't occur?
> 
> root@richardiv:~# uname -a; cat /sys/kernel/debug/usb/usbmon/6u & perl -e 'print pack "H*", "00FF" x 2048' | aplay --period-size=48 -r 44100 -f S16_LE -c2 -D hw:1,0; kill %1
> Linux richardiv 3.7-trunk-amd64 #1 SMP Debian 3.7.1-1~experimental.1 x86_64 GNU/Linux
> [1] 4407
> Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo

I don't know exactly what that "--period-size=48" parameter is supposed
to accomplish.  The man page talks about time between interrupts, but
this doesn't seem to be related at all to what the usbmon trace shows.  
In this test, the audio driver ended up using two 1-ms buffers.

> ffff8801549cc780 288953559 S Zo:6:007:1 -115:1:0 1 -18:0:176 176 = 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> ffff8801549cca80 288953569 S Zo:6:007:1 -115:1:0 1 -18:0:176 176 = 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000

Here the pipeline is started by writing two buffers of zeros.

> ffff8801549cc780 288964489 C Zo:6:007:1 0:1:217621:0 1 0:0:176 176 >
> ffff8801549cc780 288964505 S Zo:6:007:1 -115:1:217621 1 -18:0:176 176 = 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
> ffff8801549cca80 288965508 C Zo:6:007:1 0:1:217622:0 1 0:0:176 176 >
> ffff8801549cca80 288965527 S Zo:6:007:1 -115:1:217622 1 -18:0:176 176 = 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff

In the remainder, each time a buffer completes, a new one is
submitted.  This implies a latency of less than 1 ms.  Evidently that
works okay on your system, but it won't work everywhere.

> ffff8801549cc780 288966486 C Zo:6:007:1 0:1:217623:0 1 0:0:176 176 >
> ffff8801549cc780 288966503 S Zo:6:007:1 -115:1:217623 1 -18:0:176 176 = 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
> ffff8801549cca80 288967488 C Zo:6:007:1 0:1:217624:0 1 0:0:176 176 >
> ffff8801549cca80 288967507 S Zo:6:007:1 -115:1:217624 1 -18:0:176 176 = 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
> ffff8801549cc780 288968508 C Zo:6:007:1 0:1:217625:0 1 0:0:176 176 >
> ffff8801549cc780 288968523 S Zo:6:007:1 -115:1:217625 1 -18:0:176 176 = 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
> ffff8801549cca80 288969485 C Zo:6:007:1 0:1:217626:0 1 0:0:176 176 >
> ffff8801549cca80 288969499 S Zo:6:007:1 -115:1:217626 1 -18:0:176 176 = 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
> ffff8801549cc780 288970507 C Zo:6:007:1 0:1:217627:0 1 0:0:176 176 >
> ffff8801549cc780 288970520 S Zo:6:007:1 -115:1:217627 1 -18:0:176 176 = 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
> ffff8801549cca80 288971487 C Zo:6:007:1 0:1:217628:0 1 0:0:176 176 >
...

I won't include the whole log.  It's worth noticing that the URB
completion lines (the lines with "C") show no -EXDEV (-18) errors, and
the frame numbers increase sequentially (217623, 217624, 217625,
...).  This is consistent with the sound being produced correctly.

> root@richardiv:~# # Generated only opening and closing clicks
> 
> root@richardiv:~# uname -a; cat /sys/kernel/debug/usb/usbmon/4u & perl -e 'print pack "H*", "00FF" x 2048' | aplay --period-size=48 -r 44100 -f S16_LE -c2 -D hw:1,0; kill %1
> Linux richardiv 3.8-trunk-amd64 #1 SMP Debian 3.8-1~experimental.1 x86_64 GNU/Linux

> ffff880143c80d80 3864232940 C Zo:4:002:1 0:1:1057125:0 1 0:0:176 176 >
> ffff880143c80d80 3864232956 S Zo:4:002:1 -115:1:1057125 1 -18:0:176 176 = 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
> ffff880143c80180 3864233934 C Zo:4:002:1 0:1:1057126:0 1 0:0:176 176 >
> ffff880143c80180 3864233955 S Zo:4:002:1 -115:1:1057126 1 -18:0:176 176 = 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
> ffff880143c80d80 3864235913 C Zo:4:002:1 0:1:1057128:0 1 0:0:176 176 >
> ffff880143c80d80 3864235932 S Zo:4:002:1 -115:1:1057128 1 -18:0:176 176 = 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
> ffff880143c80180 3864236910 C Zo:4:002:1 0:1:1057129:0 1 0:0:176 176 >
> ffff880143c80180 3864236927 S Zo:4:002:1 -115:1:1057129 1 -18:0:176 176 = 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
> ffff880143c80d80 3864238939 C Zo:4:002:1 0:1:1057131:0 1 0:0:176 176 >
...

This trace shows that the frame numbers do not increase sequentially:
1057125, 1057126, 1057128, 1057129, 1053131, ...  This is because the
new driver is a little more conservative than the old driver,
requiring latencies to be larger than 1 ms.  You can see this 
explicitly in one of the new lines added by the commit you found:

+		next = uhci->frame_number + 2;

That 2 is the minimum latency, in frames (one frame per ms).

Anyway, the solution is simple: The audio driver needs either to submit
buffers that are at least 2 ms long, or to use more than two buffers
(or both).  What the appropriate command parameters for aplay should
be, I can't tell you.

> Should I capture enumeration and setup, too?

No need.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
