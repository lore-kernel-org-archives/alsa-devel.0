From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MIDI getting killed by Jack?
Date: Thu, 11 Sep 2003 10:18:39 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309111007270.28640-100000@studcom.urz.uni-halle.de>
References: <NDBBLGIKBJENLAMOLFHGCEOKDCAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <NDBBLGIKBJENLAMOLFHGCEOKDCAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Mark Knecht wrote:
> Hi. Does anyone else experience very slow responses from Alsa-Devel? I sent
> this email this morning at 9:16AM this morning and it just arrived back here
> and at my home account at 1:30PM. Most other reflectors I'm on normally have
> round trip times of just a minute or two. Alsa-devel is always so slow,
> usually taking hours.

The "Received" headers of your mails show the following arrival times:

                               first mail                   second mail
ladisch.de                     10 Sep 2003 20:23:30 -0000   10 Sep 2003 20:47:18 -0000
sc8-sf-list2.sourceforge.net   10 Sep 2003 12:56:20 -0700   10 Sep 2003 13:28:43 -0700
sc8-sf-list1.sourceforge.net   10 Sep 2003 09:16:28 -0700   10 Sep 2003 13:13:40 -0700
sc8-sf-mx1.sourceforge.net     10 Sep 2003 09:16:27 -0700   10 Sep 2003 13:13:39 -0700
vivaldi.controlnet.com         10 Sep 2003 09:48:12 -0700   10 Sep 2003 13:45:27 -0700

This translates to the following mail processing durations:

sc8-sf-list2.sourceforge.net   0:27:10   0:18:35
sc8-sf-list1.sourceforge.net   3:39:52   0:15:03
sc8-sf-mx1.sourceforge.net     0:00:01   0:00:01
vivaldi.controlnet.com        -0:41:45  -0:31:48

If we assume that all clocks are set correctly, we can conclude:

1) SourceForge's list servers are overloaded at times.

2) Your ISP (controlnet.com) has a time machine.  :-)

> At lunch today I rewired my MIDI input from the keyboard controller to use
> the MidiSport input instead of the HDSP 9652 input. In this configuration,
> with only about 15 minutes of testing, I had no problems. I will do more
> testing this evening, but possibly this data says it's an HDSP 9652 MIDI
> problem, or the HDSP 9652 MIDI combined with Jack-type audio, and not
> specifically 'Alsa MIDI'.

When an interrupt for MIDI input occurs, the hdsp driver disables all
further MIDI interrupts until the current input data has been read. I
don't know why it does this, but you may try to remove/disable lines
3181, 3182, 3188, and 3189 in hdsp.c.


HTH
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
