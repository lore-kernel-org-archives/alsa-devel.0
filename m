From: Allan Klinbail <allank@labyrinth.net.au>
Subject: intel 8x0 MIDI
Date: 23 Jun 2003 23:02:52 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1056373372.15797.5.camel@littlewolf2.littlewolf>
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
To: Alsa-user <alsa-user@alsa-project.org>
Cc: Alsa-dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi All

In trying to test MMC response on various software I have discovered  my
SiS 645 DX, doesn't seem to see MIDI. 

The manual for the motherboard says it should, and the modules.conf
configuration does show that the intel8x0 midi port does exist,
(specifically MusE recognises it as MIDI port, also teste with ardour
for MMC response) 

However this device does not see any MIDI input, including MMC.

Has anyone had this successfully working either with a SiS 645DX
motherboard, or simply a soundcard with this chip? Alternatively, is
there something wrong with my configuration? (I have checked the BIOS
and confirmed it is using 330 as the address for the mpu port. 


cheers

Allan Klinbail 



# ALSA portion - SiS onboard sound card
alias char-major-116 snd
alias snd-card-0 snd-intel8x0
options snd-intel8x0 mpu_port="0x330" ac97_clock="0"
 
 
# OSS/Free portion
alias char-major-14 soundcore
alias sound-slot-0 snd-0
 
# card 1
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss


-- 
Allan Klinbail <allank@labyrinth.net.au>



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
