From: "Eloy A. Paris" <peloy@chapus.net>
Subject: Occasional metallic sound when recording (cs46xx)
Date: Wed, 22 Oct 2003 12:22:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031022162219.GA29956@chapus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,

I am trying to troubleshoot a very annoying problem I have with a Santa
Cruz Turtle Beach (cs46xx). Sometimes, when recording, the recorded
sound is very metallic. If when I get the metallic sound I run alsamixer
and toggle the capture facility of the ADC on and off, sound is fixed
and back to normal.

This problem happens randomly but is very annoying, specially if I
program my PVR (MythTV) to automatically record a show - the show can
get recorded with metallic sound, which makes it very hard to understand
during playback.

This is not MythTV-specific since I have been able to reproduce the
problem using other applications, like the Gnome sound recorder. It is
unrelated to full-duplex operation since when recording a show MythTV
doesn't open /dev/dsp for writing.

I really have no idea about how to troubleshoot this. I don't think
the problem is hardware, but is driver-related instead.

Any suggestions? Are there any debug switches I can enable to get more
information about the problem? I can recompile the drivers and try
anything. I really want to see this fixed, so if anyone has any ideas
to try just let me know.

Thanks,

Eloy.-


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
