From: p z oooo <pzad@pobox.sk>
Subject: VIA 8233A
Date: Mon, 10 Feb 2003 07:21:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302100621.HAA13634@www1.pobox.sk>
Reply-To: p z oooo <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
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

Hi,

There is bug in via82xx.c. VIA8233A is wrongly detected as VIA8233=20
and then not working.

in function snd_via82xx_probe is this=20

case TYPE_CARD_VIA8233:
=09=09chip_type =3D TYPE_VIA8233;
=09=09sprintf(card->shortname, "VIA 823x rev%d", revision);
=09=09for (i =3D 0; i < ARRAY_SIZE(via823x_cards); i++) {
=09=09=09if (revision =3D=3D via823x_cards[i].revision) {
=09=09=09=09chip_type =3D via823x_cards[i].type;
=09=09=09=09strcpy(card->shortname, via823x_cards
[i].name);
=09=09=09=09break;
=09=09=09}
=09=09}
=09=09if (chip_type =3D=3D VIA_REV_8233A)
=09=09=09strcpy(card->driver, "VIA8233A");
=09=09else
=09=09=09strcpy(card->driver, "VIA8233");
=09=09break;
=09default:
=09=09snd_printk(KERN_ERR "invalid card type %d\n",=20
card_type);
=09=09err =3D -EINVAL;
=09=09goto __error;
=09}
=09=09
=09if ((err =3D snd_via82xx_create(card, pci, chip_type, revision,=20
ac97_clock[dev], &chip)) < 0)
=09=09goto __error;

=09if ((err =3D snd_via82xx_mixer_new(chip)) < 0)
=09=09goto __error;

=09if (chip_type =3D=3D TYPE_VIA686) {
=09=09if ((err =3D snd_via686_pcm_new(chip)) < 0 ||
=09=09    (err =3D snd_via686_init_misc(chip, dev)) < 0)
=09=09=09goto __error;
=09} else {
=09=09if (chip_type =3D=3D VIA_REV_8233A) {
=09=09=09if ((err =3D snd_via8233a_pcm_new(chip)) < 0)
=09=09=09=09goto __error;
=09=09} else {
=09=09=09if ((err =3D snd_via8233_pcm_new(chip)) < 0)
=09=09=09=09goto __error;
=09=09}
=09=09if ((err =3D snd_via8233_init_misc(chip, dev)) < 0)
=09=09=09goto __error;
=09}=20

But chip_type is compared to VIA_REV_8233A, but must be comparet to=20
TYPE_VIA8233A.

When I changed VIA_REV_8233A to TYPE_VIA8233A my onboard soundcard=20
(VIA8233A + ALC650) works (2 channel, 4 cannel).

5.1 has problem - swaped channels. (LF, RF, Center - OK, LS - Woofer,=20
RS - LS, Woofer - RS.


Peter Zubaj

=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REKLA=
MA =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0AVyrazne zlavy pocitacov a prislusenstva=0ATos=
hiba Pocket PC e740 v cench u? od 24.300,- Sk bez DPH=0ANavstivte nas na ad=
rese http://www.somi.sk/akcie.php=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=0A=0A


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
