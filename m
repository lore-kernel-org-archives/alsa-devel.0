From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: my first usb-midi experiment ends with segmentation
 fault
Date: Tue, 30 Jul 2002 18:38:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D46C107.2E108CEB@ladisch.de>
References: <20020728213924.GA522@tuba.home> <3D469011.855453A7@ladisch.de>
 <200207301708.07066.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: martin-langer@gmx.de
List-Id: alsa-devel@alsa-project.org

Pedro Lopez-Cabanillas wrote:
>=20
> El Mar 30 Jul 2002 15:09, Clemens Ladisch escribi=F3:
> > -             if (port < 0)
> > +             if (port < 0) {
> > +                     snd_printk(KERN_ERR "cannot create port (er=
ror code %d)\n", err);
> >                       return port;
>=20
> I think that you mean:
>                         snd_printk(KERN_ERR "cannot create port (er=
ror code %d)\n", port);
>=20
> Right? :)

Yes, thank you.

Here again the same patch, now correct. (I hope :-)


Index: usb/usbmidi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
RCS file: /cvsroot/alsa/alsa-driver/usb/usbmidi.c,v
retrieving revision 1.4
diff -u -r1.4 usbmidi.c
--- usb/usbmidi.c=095 Jul 2002 13:39:28 -0000=091.4
+++ usb/usbmidi.c=0930 Jul 2002 16:33:28 -0000
@@ -834,8 +834,10 @@
 =09=09port =3D snd_seq_event_port_attach(umidi->seq_client,
 =09=09=09=09=09=09 &port_callback,
 =09=09=09=09=09=09 cap, type, port_name);
-=09=09if (port < 0)
+=09=09if (port < 0) {
+=09=09=09snd_printk(KERN_ERR "cannot create port (error code %d)\n",=
 port);
 =09=09=09return port;
+=09=09}
 =09=09if (in)
 =09=09=09umidi->endpoints[ep].in->ports[c].seq_port =3D port;
=20
@@ -1084,6 +1086,8 @@
 =09usb_ms_endpoint_descriptor_t* ms_ep;
 =09int i, epidx;
=20
+=09memset(device_info, 0, sizeof(*device_info));
+
 =09if (usb_device->descriptor.iManufacturer =3D=3D 0 ||
 =09    usb_string(usb_device, usb_device->descriptor.iManufacturer,
 =09=09       device_info->vendor, sizeof(device_info->vendor)) < 0)
@@ -1180,12 +1184,15 @@
 {
 =09usbmidi_device_info_t device_info;
 =09snd_card_t* card =3D NULL;
+=09int err;
=20
 =09if (snd_usbmidi_get_device_info(device, ifnum, device_id,
 =09=09=09=09=09&device_info) =3D=3D 0) {
 =09=09printk(KERN_INFO "snd-usb-midi: detected %s %s\n",
 =09=09       device_info.vendor, device_info.product);
-=09=09snd_usbmidi_card_create(device, &device_info, &card);
+=09=09err =3D snd_usbmidi_card_create(device, &device_info, &card);
+=09=09if (err < 0)
+=09=09=09snd_printk(KERN_ERR "cannot create card (error code %d)\n",=
 err);
 =09}
 =09return card;
 }



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
