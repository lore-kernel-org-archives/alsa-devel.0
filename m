From: James Gardiner <renidragsemaj@yahoo.com>
Subject: (no subject)
Date: Fri, 29 May 2009 18:23:57 -0700 (PDT)
Message-ID: <426355.50702.qm@web54501.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web54501.mail.re2.yahoo.com (web54501.mail.re2.yahoo.com
	[206.190.49.151])
	by alsa0.perex.cz (Postfix) with SMTP id 8A65A1037ED
	for <alsa-devel@alsa-project.org>;
	Sat, 30 May 2009 03:23:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi, someone recently submitted changes to the patch_sigmatel.c codec source=
. Whatever was done is breaking my patch for the HP dv4-1222nr laptop. I al=
so strongly suspect that other code in the stac92hd71bxx function has been =
affected. There is no autodetect, there is no option for modprobe that will=
 load that codec currently, to the best of my knowledge. I've tracked the d=
ifference to snapshot 20090529. Before that, I can get it to work, there an=
d after refuses to work properly.

Also, there was a recent change to the stac92xx_hp_check_power_status funct=
ion: While the change looks good for its intended purpose of localizing boa=
rd changes to the switch/case statements in the stac92hd71bxx function, the=
 implementor reversed the if/then selector:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (snd_hda_codec_amp_read(co=
dec, nid, 0, HDA_OUTPUT, 0) &
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 HDA_AMP_MUTE)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spec-=
>gpio_data &=3D ~spec->gpio_led; /* white */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spec-=
>gpio_data |=3D spec->gpio_led; /* orange */

it should be:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (snd_hda_codec_amp_read(co=
dec, nid, 0, HDA_OUTPUT, 0) &
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 HDA_AMP_MUTE)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spec-=
>gpio_data |=3D spec->gpio_led; /* white */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spec-=
>gpio_data &=3D ~spec->gpio_led; /* orange */

The current implementation does not work-in fact sound is completely muted =
100% of the time.

I'll attempt to track down the 1st problem I mentioned, but I don't know if=
 only patch_sigmatel.c was affected, or even the source of the problem.

Thanks,
James Gardiner





      =
