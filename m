From: Allan Klinbail <allank@labyrinth.net.au>
Subject: error with current CVS and beta 12
Date: 17 Apr 2002 17:59:06 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a9jam5$mau$2@main.gmane.org>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm having troubles with the ALSA under Mandrake 8.2 using a patched
version of the 2.4.17 kernel 

When I try to load ALSA I get the message below (and below that my
modules.conf file)  .. the driver has been "sucessfully" installed but
not the drivers for the soundcards..  


Starting sound driver: snd-card-ens1371
/lib/modules/2.4.17/misc/snd-ac97-codec.o: unresolved symbol
snd_ctl_new1_R2a7520ab
/lib/modules/2.4.17/misc/snd-ac97-codec.o: unresolved symbol
snd_device_new_R1bb76a3b
/lib/modules/2.4.17/misc/snd-ac97-codec.o: unresolved symbol
snd_info_free_entry
_Rcb6863b9
/lib/modules/2.4.17/misc/snd-ac97-codec.o: unresolved symbol
snd_ctl_add_R3da954
52
/lib/modules/2.4.17/misc/snd-ac97-codec.o: unresolved symbol
snd_info_register_R
e396d0a7
/lib/modules/2.4.17/misc/snd-ac97-codec.o: unresolved symbol
snd_info_unregister
_R9268d7e5
/lib/modules/2.4.17/misc/snd-ac97-codec.o: unresolved symbol
snd_info_create_car
d_entry_R66de5b23
/lib/modules/2.4.17/misc/snd-ac97-codec.o: unresolved symbol
snd_component_add_R
1f374301
modprobe: insmod /lib/modules/2.4.17/misc/snd-ac97-codec.o failed
modprobe: insmod snd-card-ens1371 failed
done
Starting sound driver: snd-card-ice1712
/lib/modules/2.4.17/misc/snd-i2c.o: unre
solved symbol snd_device_new_R1bb76a3b
/lib/modules/2.4.17/misc/snd-i2c.o: unresolved symbol
snd_device_free_R75a7747a
modprobe: insmod /lib/modules/2.4.17/misc/snd-i2c.o failed
modprobe: insmod snd-card-ice1712 failed
done

and from modules.conf (yes I know it's messy) 


 alias char-major-116 snd
options snd snd_major=116 snd_cards_limit=4
alias snd-card-0 snd-card-ens1371
alias snd-card-1 snd-card-ice1712
# alias snd-card-1 snd-card-ymfpci
# alias snd-card-3 snd-card-mtpav
options snd-card-ens1371 snd_index=0 snd_id="Vibra128"
options snd-card-ice1712 snd_index=1 snd_id="Delta66"
options snd-card-virmidi snd_index=2
# options snd-card-ymfpci snd_index=1 snd_id="YMFPCI" snd_mpu_irq=9
options snd-card-mtpav snd_index=3 snd_id="MTPAV"
# OSS/Free setup
 alias char-major-14 soundcore
 alias sound-slot-0 snd-card-0
 alias sound-service-0-0 snd-mixer-oss
 alias sound-service-0-1 snd-seq-oss
 alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
