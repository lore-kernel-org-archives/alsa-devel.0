From: Gorka Olaizola <gorka@escomposlinux.org>
Subject: Re: Channels jumping with snd_intel8x0, nforce2 and 5.1 output
Date: Thu, 8 Jan 2004 23:24:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040108222431.GA16232@helvete.escomposlinux.org>
References: <20040104175552.GA16063@helvete.escomposlinux.org> <s5hk74631z0.wl@alsa2.suse.de> <20040105175916.GA22830@helvete.escomposlinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from helvete.escomposlinux.org (167.Red-213-96-129.pooles.rima-tde.net [213.96.129.167])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA26222
	for <alsa-devel@alsa-project.org>; Thu, 8 Jan 2004 23:25:38 +0100
Received: from helvete.escomposlinux.org (conn.helvete.escomposlinux.org [192.168.1.3])
	by helvete.escomposlinux.org (Postfix) with SMTP id A9E6D8803D
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2004 23:29:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20040105175916.GA22830@helvete.escomposlinux.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I think i've found something interesting.

I downloaded de nvaudio driver from Nvidia's site and read the source a bit.
I found this function:

void __start_dac(struct Nvaudio_state *state)
{
    int i =3D0;
    unsigned int i_glob_cnt =3D 0;
    struct Nvaudio_card *card =3D state->card;
    struct dmabuf *dmabuf =3D &state->dmabuffer;

    if (dmabuf->count > 0 && state->ready && !state->enable &&
        (state->trigger & PCM_ENABLE_OUTPUT)) {

----------------------------------------------------------------------
        /* Reset the Global Cnt back to Stereo 16ch and set the format=20
           This is needed to keep the 6 channel data in alignment ,
           to start from Front Left always */
        i_glob_cnt =3D inl(card->iobase + GLOB_CNT);
        outl((i_glob_cnt & 0xcfffff),card->iobase + GLOB_CNT);
        mdelay(50);
        outl(i_glob_cnt,card->iobase + GLOB_CNT);
----------------------------------------------------------------------
        /* Reset the leftover datainfo*/
        for(i=3D0; i < 5 ; i++)
            AnalogLeftovers[i] =3D 0;
        AnalogLeftoverCount =3D 0;

        state->enable =3D DAC_RUNNING;

        /* Interrupt Enable, LVI Enable, DMA Enable*/
        outb((0x10|0x04|0x01), state->card->iobase + PO_CR);

#ifdef NV_DEBUG_PLAY
        printk("Starting DAC \n");
#endif
    }
}

I translated the part that I thought interesting to the function
"snd_intel8x0_setup_multi_channels" in the file intel8x0.c of Alsa (Line
923)

I have added this to the function

	case DEVICE_NFORCE:
		cnt =3D igetdword(chip, ICHREG(GLOB_CNT));
		cnt &=3D ~ICH_PCM_246_MASK;
		if (chip->multi4 && channels =3D=3D 4)
			cnt |=3D ICH_PCM_4;
		else if (chip->multi6 && channels =3D=3D 6)
			cnt |=3D ICH_PCM_6;
		iputdword(chip, ICHREG(GLOB_CNT), (cnt & 0xcfffff));
		mdelay(50);
		iputdword(chip, ICHREG(GLOB_CNT), cnt);
		break;

Now speaker_test works well for me and the sound is coming from the right
speaker all the time. But there are some problems.
With mplayer in oss emulation the sound is very choppy and with
alsa9:surround51 there are constant cracks and pops.
If I play a DVD with xine with alsa:surround51 the sound seems correct and I
don't hear cracks. Maybe mplayer has some problems with alsa 1.0.x

I hope it's useful.

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE//difAJWwPWWa2yoRAjc3AJ4qCbum2ERZK7M3Z7Mi7pXFWS/IogCfUo1o
0zobAd8uWtFnkGJSIDTKd2I=
=K1FG
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
