From: Andrei Boros <andrei@srr.ro>
Subject: Opti92x-ad1848 won't take Opti924 card
Date: Mon, 22 Sep 2003 12:00:32 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F6EBA30.28AC216F@srr.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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


 Updated cvs tree 30min ago. Compiled the driver. Installed the driver.
 System is kernel-2.2.24, glibc-2.1.3
 configure ran with --with-debug=detect

 gate:~# modprobe snd-opti92x-ad1848
/lib/modules/2.2.24/misc/snd-opti92x-ad1848.o: unresolved symbol
isapnp_resource_change_R09b965af
snd: Device or resource busy

Though depmod -a returns no errors about unresolved symbols.

Then manually inserting modprobe snd-isapnp will log the following 
Sep 22 12:00:25 gate kernel: isapnp: Card 'OPTi Audio 16'
Sep 22 12:00:25 gate kernel: isapnp: 1 Plug & Play card detected total

Then again modprobe snd-opti92x-ad1848, same error, and logs the
following : 

Sep 22 12:01:22 gate kernel: no OPTi 82C92x soundcard found

in /etc/modules.conf I have the following, based on online documentation
:

###########################################################################
#
# ALSA modules
# ALSA portion
alias char-major-116            snd
options snd                     cards_limit=2
#options snd-isapnp                    
isapnp_reserve_irq=8,9,10,11,12,13,14,15
alias snd-card-0                snd-cs46xx
alias snd-card-1                snd-opti92x-ad1848

# Sound module options here
options snd-cs46xx              mmap_valid=1 index=0 id="Fortissimo-II"
enable=1
options snd-opti-92x-ad1848     index=1 isapnp=1 id="Opti924" port=0x220
irq=5 dma1=0 fm_port=0x38

# OSS/Free portion
alias char-major-14             soundcore
alias sound-slot-0              snd-card-0
alias sound-slot-1              snd-card-1

# card #1
alias sound-service-0-0         snd-mixer-oss
alias sound-service-0-1         snd-seq-oss
alias sound-service-0-3         snd-pcm-oss
alias sound-service-0-8         snd-seq-oss
alias sound-service-0-12        snd-pcm-oss

# card #2
alias sound-service-1-0         snd-mixer-oss
alias sound-service-1-3         snd-pcm-oss
alias sound-service-1-12        snd-pcm-oss




-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
