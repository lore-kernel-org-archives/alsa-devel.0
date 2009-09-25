From: remrot@gmail.com
Subject: Re: Mic stops working after installation (ALC861)
Date: Fri, 25 Sep 2009 13:04:10 +0200
Message-ID: <36bf0bad0909250404s4f15215by59c9105d3966a58@mail.gmail.com>
References: <36bf0bad0909240629s271b7736o19f317bad60f7547@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0003255558d26b3b2a047464e86f
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id BDD951037F1
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 13:04:12 +0200 (CEST)
Received: by bwz25 with SMTP id 25so2705158bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2009 04:04:12 -0700 (PDT)
In-Reply-To: <36bf0bad0909240629s271b7736o19f317bad60f7547@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0003255558d26b3b2a047464e86f
Content-Type: text/plain; charset=ISO-8859-1

I've done some more tests and collected a lot of data. And I found a
workaround for the problem: adding "position_fix=1" reactivates the mic! Now
I have sound and a working mic! However, there are some downsides:

First of all, the recording quality is much lower than within the live
session. I need to set the volume of the capture device to max to be able to
recognize my own voice, but that introduces a lot of noise to the recorded
stream. Within a live session, the recorded stream is much louder, it is
usable even with the capture device almost muted! I totally don't understand
how this can happen...

Secondly, I still consider it a bug when something works within the live
system and stops working after installation! This is kind of a
"sound-lottery" and would easily become a show-stopper for less experienced
users. To find the reason for the bug, I collected data from different
settings and compared them, without a result. However, I'm not an ALSA
developer, so I decided to attach all collected information hoping that it
will be helpful. These are the files inside the archive:

alsa-info-live.txt : information collected from the alsa-info script within
the live session (everything worked perfectly)
alsa-info-installed.txt : info collected after installation, with no
additional options (nothing worked, 1 out of 10 times the sound worked)
alsa-info-probe.txt : dito, but with 'probe_mask=8' (sound works, mic is
dead)
alsa-info-pos.txt : dito, but with  'position_fix=1' (sound and mic work,
but low quality)

I don't know for how long I'll have access to this machine, but as long as I
do, I can carry out additional tests and collect more data if necc.

Cheers

JK

2009/9/24 <remrot@gmail.com>

> /* Sorry for posting this to the devel list, but the problem seems to be
> trickier than I first thought *
> *  and I don't have much time left to fix it (not my machine)! Thanks...
>                                     */
>
> Hi!
>
>  I've got a very strange problem with a ALC861 soundchip on a friend's
> Toshiba A100-507 Laptop. Sound output and input work perfectly within a live
> session using the Ubuntu Jaunty and Karmic (Alpha6) CDs but immediately
> stops working after installing the system. Currently I've installed the
> latest Karmic containing kernel 2.6.31 and ALSA 1.0.20. I've attached the
> output of the alsa-info script as well as the output of 'pacmd list' for
> both systems (live and installed).
>
>  Right after the installation the sound stopped working and I couldn't
> record anything. Alsamixer showed only output devices, no capture devices at
> all (everything has been correct within the live session). In 'dmesg' I
> found the following error messages:
>
> [  279.924019] hda-intel: azx_get_response timeout, switching to polling
> mode: last cmd=0x301f000a
> [  280.928019] hda_intel: azx_get_response timeout, switching to single_cmd
> mode: last cmd=0x301f000a
>
> After doing some research I found this guide (thx Mr. Iwai):
>
> http://www.kernel.org/pub/linux/kernel/people/tiwai/docs/HD-Audio.html#_codec_probing_problem
>
> And indeed, adding 'probe_mask=8' fixed the sound output and brought back
> the capture devices (remember that they were there within the live session
> without that option). I've also tried the 'model=toshiba' option (combined
> with
> 'probe_mask' and standalone) but that didn't help at all (no capture
> devices and no sound).
>
> The current situation:
>
>  I've already posted to the PulseAudio mailing ist and got some help from
> Mr. Colin Guthrie but we haven't found a solution (everything seems OK
> regarding PA). I still can't record anything within the installed system. I
> tried audacity, alsarec and the gnome-sound-recorder without luck. When
> recording in audacity, the timeline cursor doesn't move, it only flickers.
> In gnome-recorder, recording stops right after it has started and the
> application hangs on exit. PA's volume meter doesn't show anything either,
> it is empty. I compared the configurations on both systems but I see no
> differences that are not related to the 'probe_mask' option... I really
> believe that there is a solution because everything works in a live session.
> Can anybody help me with this?
>
> Regards
>
> JK

--0003255558d26b3b2a047464e86f
Content-Type: application/x-gzip; name="alsa_info.tar.gz"
Content-Disposition: attachment; filename="alsa_info.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g00tmvin1

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
--0003255558d26b3b2a047464e86f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0003255558d26b3b2a047464e86f--
