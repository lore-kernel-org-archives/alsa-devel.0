From: "Eric" <milou@skybear.net>
Subject: (no subject)
Date: Wed, 16 Mar 2005 13:38:33 +0100 (CET)
Message-ID: <1612.132.168.64.149.1110976713.squirrel@132.168.64.149>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I want to use a 9860 laptop provided with realtek ALC880 azalia sound
system. I have also a PATA hard disk on a FastTrack 378 newly supported b=
y
the linux kernel (don't know if it is important or not for my alsa
problem).
I installed an ubuntu distrib (development branch). So I have kernel 2.6.=
10.
I installed alsa-1.0.8 from an alsa-source package on a 2.6.10 kernel fro=
m
hoary, recompiled, and installed. So now I have snd-azx.
When I modprobe snd-azx, it loads, but it complains about
"azx_get_response timeout" a lot of time, then complains about "no AFG
node found" for snd_hda_codecs. And finally the sound card is not
recognized.
cat /proc/asound/cards -> no sound card.

I found this piece of code from a patch from last alsa code patch
(alsa-bk-2005-03-11.patch). It seems the problems comes from that pieces
of code ...

+/* receive a response */
+static unsigned int azx_get_response(struct hda_codec *codec)
+{
+ azx_t *chip =3D codec->bus->private_data;
+ int timeout =3D 50;
+
+ while (chip->rirb.cmds) {
+ if (! --timeout) {
+ snd_printk(KERN_ERR "azx_get_response timeout\n");
+ chip->rirb.rp =3D azx_readb(chip, RIRBWP);
+ chip->rirb.cmds =3D 0;
+ return -1;
+ }
+ msleep(1);
+ }
+ return chip->rirb.res; /* the last value */
+}

and

/* FIXME: support for multiple AFGs? */
+	codec->afg =3D look_for_afg_node(codec);
+	if (! codec->afg) {
+		snd_printk(KERN_ERR "hda_codec: no AFG node found\n");
+		snd_hda_codec_free(codec);
+		return -ENODEV;
+      }

I cannot get it work. Is it a bug ? Did I miss something ???

milou


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
