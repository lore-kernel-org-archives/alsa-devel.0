From: Michael Papet <mpapet@yahoo.com>
Subject: STB TV PCI FM
Date: Tue, 13 May 2008 20:09:39 -0700 (PDT)
Message-ID: <20080514030939.93283.qmail@web62006.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web62006.mail.re1.yahoo.com (web62006.mail.re1.yahoo.com
	[69.147.74.229]) by alsa0.perex.cz (Postfix) with SMTP id B0A8C1037F8
	for <alsa-devel@alsa-project.org>;
	Wed, 14 May 2008 05:09:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
List-Id: alsa-devel@alsa-project.org

6000704 2.6.24
To: alsa-devel@alsa-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <934014.92322.qm@web62006.mail.re1.yahoo.com>

Hi,

I'm trying to finish installing an old STB TV PCI FM
6000704 tv capture card working and there's no sound.

I'm on Debian Lenny/Testing kernel version 2.6.24. 
The card itself does not detect or load snd-bt87x when
booting.  I force it to load with the load_all
kernel option when I modprobe.  It doesn't seem to use
msp3400 in any way.  
In theory,/proc/asound/card1/pcm0c is the stereo
capture, but I can't figure out how to make it capture
in stereo.  I can set
the digital_rate as needed if that will get stereo
going.   I've tried 36000 and 44100 with no success,
but it could be because .asoundrc isn't right.

Check http://pastebin.ca/1017578 for alsa-info.sh
output.

Any advice, or perhaps an .asoundrc would be great.

Best regards,

Michael

modprobe -v snd-bt87x dmesg>> "unknown card
0x878-0x10b4:0x2636
please mail id, board name, and, if it works, the
correct digital_rate option to
<alsa-devel@alsa-project.org>
bt87x0: Using board 0, analog, digital (rate 32000 Hz"
