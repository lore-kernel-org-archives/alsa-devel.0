From: Jaakko =?iso-8859-15?q?Pr=E4tt=E4l=E4?=
	<Jaakko.Prattala@Helsinki.FI>
Subject: snd-hdsp unresolved symbol and an alsa build error
Date: Sat, 12 Apr 2003 01:18:45 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304120118.45101.Jaakko.Prattala@Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

kernel 2.4.20, pcmcia support as module, alsa cvs from friday evening
=2E/configure --with-cards=3Dvirmidi,hdsp,usb-audio,via82xx --with-sequen=
cer=3Dyes
--with-isapnp=3Dno

/sbin/modprobe snd-hdsp
/lib/modules/2.4.20/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved symbo=
l=20
snd_hwdep_new_R42732707

This build error comes everytime I leave out --with-isapnp=3Dno :

pnp.c:130: redefinition of `pnp_request_card_device_Rfcc1b9a4'
pnp.h:203: `pnp_request_card_device_Rfcc1b9a4' previously defined here
pnp.c:143: redefinition of `pnp_release_card_device_R57adc334'
pnp.h:204: `pnp_release_card_device_R57adc334' previously defined here
pnp.c:150: redefinition of `pnp_register_card_driver_Rcbd2bd96'
pnp.h:205: `pnp_register_card_driver_Rcbd2bd96' previously defined here
pnp.c:199: redefinition of `pnp_unregister_card_driver_Re6bf830a'
pnp.h:206: `pnp_unregister_card_driver_Re6bf830a' previously defined here
pnp.c:218: redefinition of `pnp_register_driver_Rc6d14622'
pnp.h:207: `pnp_register_driver_Rc6d14622' previously defined here
pnp.c:249: redefinition of `pnp_unregister_driver_Re83d02dc'
pnp.h:208: `pnp_unregister_driver_Re83d02dc' previously defined here
pnp.c:267: redefinition of `pnp_init_resource_table_R16084899'
pnp.h:209: `pnp_init_resource_table_R16084899' previously defined here
pnp.c:297: redefinition of `pnp_manual_config_dev_Rad6619ba'
pnp.h:210: `pnp_manual_config_dev_Rad6619ba' previously defined here
pnp.c:328: redefinition of `pnp_activate_dev_R85f47f33'
pnp.h:211: `pnp_activate_dev_R85f47f33' previously defined here
pnp.h:203: warning: `pnp_request_card_device_Rfcc1b9a4' defined but not u=
sed
pnp.h:204: warning: `pnp_release_card_device_R57adc334' defined but not u=
sed
pnp.h:205: warning: `pnp_register_card_driver_Rcbd2bd96' defined but not =
used
pnp.h:206: warning: `pnp_unregister_card_driver_Re6bf830a' defined but no=
t=20
used
pnp.h:207: warning: `pnp_register_driver_Rc6d14622' defined but not used
pnp.h:208: warning: `pnp_unregister_driver_Re83d02dc' defined but not use=
d
pnp.h:209: warning: `pnp_init_resource_table_R16084899' defined but not u=
sed
pnp.h:210: warning: `pnp_manual_config_dev_Rad6619ba' defined but not use=
d
pnp.h:211: warning: `pnp_activate_dev_R85f47f33' defined but not used

--=20
Jaakko Pr=E4tt=E4l=E4
Jaakko.Prattala@Helsinki.FI


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
