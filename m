From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: alsa09 sound for portable computers
Date: Thu, 04 Apr 2002 21:55:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CACBDD6.3060705@superbug.demon.co.uk>
Reply-To: James@superbug.demon.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from finch-post-12.mail.demon.net (finch-post-12.mail.demon.net [194.217.242.41])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA22066
	for <alsa-devel@alsa-project.org>; Thu, 4 Apr 2002 22:56:43 +0200
Received: from superbug.demon.co.uk ([158.152.58.16])
	by finch-post-12.mail.demon.net with esmtp (Exim 3.35 #1)
	id 16tEHg-000HNs-0C
	for alsa-devel@alsa-project.org; Thu, 04 Apr 2002 20:56:41 +0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello

I have just managed to get alsa09 sound to work on my portable after a 
lot of difficulty with neither alsa or oss modules loading.
I would like to suggest that we start adding an alsa09 howto for 
Portable PC users.
It would have: -
Name of PC,  sample modules.conf line to use.

My old portable is a Toshiba Satellite 4010CDT which is NOT plug and 
play sound.
See my config here: -

################ ALSA START
## ALSA native device support
alias char-major-116 snd

options snd snd_major=116 snd_cards_limit=1
## This is the driver setting
alias snd-card-0 snd-opl3sa2
options snd-opl3sa2 snd_isapnp=0 snd_port=0x538 snd_wss_port=0x530 snd_sb_port=0x220 snd_fm_port=0x388 snd_midi_port=0x330 snd_irq=5 snd_dma1=1 snd_dma2=0
post-install snd-opl3sa2 (amixer master 100 unmute; amixer pcm 100 unmute)

## OSS/Lite setup
alias char-major-14 snd-pcm-oss
alias sound-slot-0 snd-card-0
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-12 snd-pcm-oss
############### ALSA END

Maybe it could be possible for a config script to automatically find out 
the make and model of the PC and set up the sound card automatically.
I know each Portable PC manufacture has a way to determing what sort of 
PC the software is installed on, because I have a Dell PC which came 
with Windows 2000, but the Windows2000 install comes back with a message 
saying "This is not a Dell PC" so it will not install.

This sort of special work would only have to be done for non-plug and 
play hardware.

Cheers
James
