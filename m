From: Thorsten Haas <thorsten.haas@gmx.de>
Subject: Re: Re: USB recording - repetitive peaks
Date: Fri, 5 Jul 2002 11:06:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207051106.06718.thorsten.haas@gmx.de>
References: <3D208C5C.36649172@ladisch.de> <3D255A1F.6090505@boosthardware.com> <200207051038.36780.thorsten.haas@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200207051038.36780.thorsten.haas@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I like to use two soundcards in my system.

I have an usb quattro and a trident compatible card. I read the manual at  
http://www.boosthardware.com/LAU/guide/ and configured modules.conf:#

------------------------- snip --------------------------------------
### NEW ALSA 0.9 from CVS 2002-07-05

##       General
# ALSA portion
  alias char-major-116 snd
# OSS/Free portion
  alias char-major-14 soundcore

##      Native Devices: ALSA portion
# quattro usb
  alias snd-card-0 snd-usb-audio
  options snd-usb-audio snd_index=0 snd_id="Q4"
# sis onboard (trident)
  alias snd-card-1 snd-card-trident
  options snd-card-trident snd_index=1 snd_id="SiS"

##      Native Devices: OSS/Free portion
# OSS Free Portion - Card 1 - quattro usb
  alias sound-slot-0 snd-card-0
  alias sound-service-0-0 snd-mixer-oss
  alias sound-service-0-1 snd-seq-oss
  alias sound-service-0-3 snd-pcm-oss
  alias sound-service-0-8 snd-seq-oss
  alias sound-service-0-12 snd-pcm-oss
# OSS Free Portion - Card 2 - Trident
  alias sound-slot-1 snd-card-1
  alias sound-service-1-0 snd-mixer-oss
  alias sound-service-1-3 snd-pcm-oss
  alias sound-service-1-12 snd-pcm-oss
------------------------- snap --------------------------------------

After that i ran depmod -a and tried

linda:~ # modprobe snd-card-trident
/lib/modules/2.4.10-4GB/misc/snd-rawmidi.o: unresolved symbol 
snd_control_unregister_ioctl
/lib/modules/2.4.10-4GB/misc/snd-rawmidi.o: unresolved symbol 
snd_switch_remove
/lib/modules/2.4.10-4GB/misc/snd-rawmidi.o: unresolved symbol snd_switch_free
/lib/modules/2.4.10-4GB/misc/snd-rawmidi.o: unresolved symbol snd_switch_add
/lib/modules/2.4.10-4GB/misc/snd-rawmidi.o: unresolved symbol 
snd_switch_prepare
/lib/modules/2.4.10-4GB/misc/snd-rawmidi.o: unresolved symbol 
snd_info_create_entry
/lib/modules/2.4.10-4GB/misc/snd-rawmidi.o: unresolved symbol 
snd_control_register_ioctl
/lib/modules/2.4.10-4GB/misc/snd-rawmidi.o: unresolved symbol snd_switch_new
/lib/modules/2.4.10-4GB/misc/snd-rawmidi.o: unresolved symbol 
snd_switch_free_one
/lib/modules/2.4.10-4GB/misc/snd-rawmidi.o: insmod 
/lib/modules/2.4.10-4GB/misc/snd-rawmidi.o failed
/lib/modules/2.4.10-4GB/misc/snd-rawmidi.o: insmod snd-card-trident failed

Can someone please give me ahint what I did wrong here?

Thorsten

PS: SORRY for the length.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
