From: Allan Klinbail <allank@labyrinth.net.au>
Subject: intel8x0 no midi
Date: 03 Feb 2003 13:34:04 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1044239650.30428.14.camel@littlewolf2.littlewolf>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Hi 

I've recently purchased a new machine with a built in  soundcard as part
of the SiS 645DX chipset (motherboard is Gigabyte GA-8ST667). 

I've had success getting audio to work using the intel8x0 modules. 

However I can't seem to get the midi port to work. It is enabled in BIOS
and here are my modules options from modules.conf

# ALSA portion -SiS onboard sound card
alias char-major-116 snd
alias snd-card-0 snd-intel8x0
options snd-intel8x0 mpu_port="1" ac97_clock="0"

I'm sure the problem does lie in this setup.. 

If anyone has midi working on an intel8x0 card of any kind please let me
know. 

cheers

Allan Klinbail  






-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
