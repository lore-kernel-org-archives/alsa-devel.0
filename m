From: Andrei Boros <andrei@srr.ro>
Subject: snd-opti92x-ad1848
Date: Wed, 15 Oct 2003 13:07:22 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F8D1C5A.4A1FDD11@srr.ro>
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

 Attempting again at opti92x-ad1848 build from cvs tree taken today :

compilation goes well (all components of alsa).

./configure --with-isapnp=yes --with-sequencer=yes --with-oss=yes
--with-debug=detect --with-cards=cs46xx,opti92x-ad1848
make
make install
depmod -a
(depmod returns no unresolved symbols)

gate:~# modprobe snd-opti92x-ad1848
/lib/modules/2.2.24/misc/snd-hwdep.o: unresolved symbol
snd_register_oss_device_Rddc5e1d2
/lib/modules/2.2.24/misc/snd-hwdep.o: unresolved symbol
snd_info_register_Rfccceac3
/lib/modules/2.2.24/misc/snd-hwdep.o: unresolved symbol
snd_unregister_oss_device_Rab87d9aa
/lib/modules/2.2.24/misc/snd-hwdep.o: unresolved symbol
snd_info_create_module_entry_Rd13be217
/lib/modules/2.2.24/misc/snd-hwdep.o: unresolved symbol
snd_ctl_register_ioctl_Rf18647ae
/lib/modules/2.2.24/misc/snd-hwdep.o: unresolved symbol
snd_ctl_unregister_ioctl_R7ca01faa
/lib/modules/2.2.24/misc/snd-hwdep.o: unresolved symbol
snd_unregister_device_R15d14211
/lib/modules/2.2.24/misc/snd-hwdep.o: unresolved symbol
snd_device_new_R4b610fa9
/lib/modules/2.2.24/misc/snd-hwdep.o: unresolved symbol
snd_register_device_Rb4cb86ab
/lib/modules/2.2.24/misc/snd-hwdep.o: unresolved symbol
snd_info_unregister_Reeb79eb0
/lib/modules/2.2.24/misc/snd-hwdep.o: unresolved symbol
snd_card_file_remove_Rcf50c6bd
/lib/modules/2.2.24/misc/snd-hwdep.o: unresolved symbol
snd_card_file_add_Rbb7360e0
/lib/modules/2.2.24/misc/snd-hwdep.o: unresolved symbol
snd_info_free_entry_R1e9a962a
snd: Device or resource busy
snd-timer: Device or resource busy
snd-mpu401-uart: No such file or directory

File snd-mpu401-uart.o exists

>From the modules loaded, I see there is a snd-ac97-codec, but it makes
no sense, since the Opti924 is an old ISA card where ac97 didn't even
exist...



-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
