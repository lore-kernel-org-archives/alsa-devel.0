From: "Edward Wildgoose" <Ed@Wildgooses.com>
Subject: Digi96 Full Duplex problem with 16bit samples
Date: Tue, 22 Apr 2003 16:30:14 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <02d301c308e4$120d8ef0$cb40a8c0@FRiskMan.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have a new Digi96/8 PAD card (very impressed with the sound quality),
however, I am trying to use it with MythTV to record and playback TV.
Either analogue recording or playback work fine, but any attempt to do
simultaneous analogue record AND playback is failing.

I have tested with aplay + arecord and the card does full duplex analogue
without a problem.  The only difference with MythTv seems to be that it uses
OSS emulation via the /dev/dsp device (this is this OSS isn't it?).  To try
and simulate this I tried the following:

gentoo linux-2.4.20 # sox -t ossdsp -r 44100 -w -c 2 /dev/dsp -t ossdsp -r
44100 -w -c 2 /dev/dsp

Which gives the error:
sox: Unable to set the sample size to 16

If however, I remove the "-w" flag from the above then everything works OK.
It appears that full duplex works in 8 bit mode, but not 16 bit mode?

Can anyone confirm or deny this, and is there a workaround to get full
duplex (other than coding up a proper ALSA layer for MythTv)? I am using
alsa 0.92 and I have also tried 0.90rc6 (and it's on gentoo if this makes a
difference).

Any help would be appreciated,

Thanks



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
