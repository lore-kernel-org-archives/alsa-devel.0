From: Juhana Sadeharju <kouhia@nic.funet.fi>
Subject: emu10k1 polishing?
Date: Tue, 10 Feb 2004 16:02:24 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <S32420AbUBJOCY/20040210140224Z+25221@nic.funet.fi>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello.

A couple of question on emu10k1 driver (e.g., in SB Live):

1. Sample rate conversion

What exactly happens when I record at sample rate 44100 Hz?
Does emu10k1 chip run at sample rate 44100 Hz as well?
(It is claimed that emu10k1 runs only at rate 48000 Hz.)

If emu10k1 runs at 48000 Hz, at what rate A/D converter runs?
If emu10k1 runs at 48000 Hz and Alsa at rate 44100 Hz, where the
sample rate conversion happens?

The emu10k1 doc has a figure that could indicate SRC happens
separately on the chip and is not done by emu10k1. But is that
really so?

2. Alsamixer shows obscure names

Alsamixer shows that emu10k1 uses confusing names.
How about changing them?

   Bad names               Proposed good names
   ---------------------------------------------------
   Line LiveDrive          Line2/Mic2 LiveDrive
   Line LiveDrive Capture  Line2/Mic2 LiveDrive Capture
   Line2 LiveDrive 1       Aux2 LiveDrive
   Line2 LiveDrive         Aux2 LiveDrive Capture

Regards,
Juhana


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
