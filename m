From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Is there any queston when using ALSA in arm platform?
Date: Fri, 3 Dec 2004 08:18:40 +0100
Message-ID: <200412030718.iB37IaIP006319@www4.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
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
To: sudong@tcl.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

AFAIK AC97 API is not dependant on bus type.=20

This is code from emu10k1 driver, it initializes ac97 struct:

ac97_template_t ac97;
static ac97_bus_ops_t ops =3D {
=09.write =3D snd_emu10k1_ac97_write,
=09.read =3D snd_emu10k1_ac97_read,
};

if ((err =3D snd_ac97_bus(emu->card, 0, &ops, NULL, &pbus)) < 0)
=09return err;
=09=09
memset(&ac97, 0, sizeof(ac97));
ac97.private_data =3D emu;
ac97.private_free =3D snd_emu10k1_mixer_free_ac97;
if ((err =3D snd_ac97_mixer(pbus, &ac97, &emu->ac97)) < 0)
=09return err;=20


.write =3D snd_emu10k1_ac97_write,
.read =3D snd_emu10k1_ac97_read,

These 2 functions are responsible to transfer control data to/from
ac97. You should implement it for your chip.

Peter Zubaj=0A____________________________________=0Ahttp://www.pobox.sk/ -=
 najvacsi slovensky freemail=0A=0A=0A


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
