From: "Jeremy Garff" <jer@jers.net>
Subject: hda/patch_sigmatel.c patch for a Dell Insprion B120
Date: Wed, 15 Mar 2006 18:32:42 -0700 (MST)
Message-ID: <40165.10.10.240.50.1142472762.squirrel@www.jers.net>
Reply-To: jer@jers.net
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: matt@embeddedalley.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The following is a patch that I made to support the headphone jack on a
Dell Insprion B120 laptop.

It appears that the codec chip is a STAC9200 (0x83847690), but has suppor=
t
for headphones using the front channel which aren't present in the 1.10
branch.  The patch simply adds headphone support (using the front channel=
)
to the existing stac9200 code and hooks the insert/remove event to the
proper function.

I don't know if this change is appropriate for other boards/cards out
there, but I thought I would pass it along.

Please let me know if you need further information.  Many thanks for the
driver work!!

Jeremy Garff

--- alsa-driver-1.0.10/sound/pci/hda/patch_sigmatel.c    2005-09-09
07:21:47.000000000 -0600
+++ alsa-driver-1.0.10.new/sound/pci/hda/patch_sigmatel.c   2006-03-15
16:54:01.000000000 -0700
@@ -769,6 +769,9 @@
        if ((err =3D stac92xx_auto_create_analog_input_ctls(codec,
&spec->autocfg)) < 0)
                return err;

+       if ((err =3D stac92xx_auto_create_hp_ctls(codec, &spec->autocfg))=
 < 0)
+               return err;
+
        if (spec->autocfg.dig_out_pin) {
                spec->multiout.dig_out_nid =3D 0x05;
                stac92xx_auto_set_pinctl(codec, spec->autocfg.dig_out_pin=
,
AC_PINCTL_OUT_EN);
@@ -778,6 +781,8 @@
                stac92xx_auto_set_pinctl(codec, spec->autocfg.dig_in_pin,
AC_PINCTL_IN_EN);
        }

+       stac92xx_auto_init_hp_out(codec);
+
        if (spec->kctl_alloc)
                spec->mixers[spec->num_mixers++] =3D spec->kctl_alloc;





-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
that extends applications into web and mobile media. Attend the live webc=
ast
and join the prime developer group breaking into this new coding territor=
y!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
