From: Axel Braun <axel.braun@gmx.de>
Subject: Re: Thinkpad T520 (Low Volume)
Date: Sat, 18 Jan 2014 17:44:10 +0100
Message-ID: <3997344.dLRXQbcGtH@t520.axxite.internal>
References: <CAN8ccib14G8pyLuMTi2BS6_hW0StBxEEu4EcUv2HKG==BQ27NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5489148650041399404=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CA2A92619D8
 for <alsa-devel@alsa-project.org>; Sat, 18 Jan 2014 17:44:16 +0100 (CET)
Received: from t520.axxite.internal ([88.77.52.101]) by mail.gmx.com
 (mrgmx003) with ESMTPSA (Nemesis) id 0MYP57-1Vrgp23gzR-00V4vs for
 <alsa-devel@alsa-project.org>; Sat, 18 Jan 2014 17:44:14 +0100
In-Reply-To: <CAN8ccib14G8pyLuMTi2BS6_hW0StBxEEu4EcUv2HKG==BQ27NQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: tiwai@suse.de, danny@danysek.cz, ALSA Development Mailing List <alsa-devel@alsa-project.org>, jens.taprogge@taprogge.org
List-Id: alsa-devel@alsa-project.org


--===============5489148650041399404==
Content-Type: multipart/signed; boundary="nextPart2929358.bW8mZd7BP6"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart2929358.bW8mZd7BP6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello Raymond,

Am Samstag, 18. Januar 2014, 09:46:22 schrieb Raymond Yau:
> > 2014/1/16 Axel Braun <axel.braun@gmx.de>
> > 
> > same problem on a ThinkPad T520, sound volume is way
> > too low - watching movie via loudspeakers is fairly impossible.
> > Any hint you could give me?
> > 
> > post the output of alsa-info.sh , there is a bug in alsa-driver which
> 
> treat
> 
> > dock headphone and headphone to support surround 4.0
> 
> you get low volume because Amp Out vals are 0x3d instead of 0x4a but
> speaker volumes are at 100% (0dB)

Can I influence that from the running system, e.g. by 
echo 0x4d > .... 
?

> Simple mixer control 'Speaker',0
>   Capabilities: pvolume pswitch
>   Playback channels: Front Left - Front Right
>   Limits: Playback 0 - 74
>   Mono:
>   Front Left: Playback 74 [100%] [0.00dB] [on]
>   Front Right: Playback 74 [100%] [0.00dB] [on]
> 
> Node 0x10 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
>   Control: name="Speaker Playback Volume", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Control: name="Speaker Playback Switch", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Device: name="CX20590 Analog", type="Audio", device=0
>   Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
>   Amp-Out vals:  [0x3d 0x3d]
> 
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=ca20
> 1c096269ee2d40037fea96a59fd0695888c4
> 
> thinkpad t520 was supported with CXT5066_AUTO which use
> cxt5066_update_speaker which check port a and port d
> 
> Do this mean thinkpad don't support surround 4.0 by dock headphone and
> headphone ?
> 
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pc
> i/hda/patch_conexant.c?id=d70f363222ef373c2037412f09a600357cfa1c7a
> 
> ALSA: hda/conexant - Set up the missing docking-station pins
> 
> [    9.956636] ALSA hda_auto_parser.c:393 autoconfig: line_outs=1
> (0x1f/0x0/0x0/0x0/0x0) type:speaker
> [    9.956639] ALSA hda_auto_parser.c:397    speaker_outs=0
> (0x0/0x0/0x0/0x0/0x0)
> [    9.956641] ALSA hda_auto_parser.c:401    hp_outs=2
> (0x1c/0x19/0x0/0x0/0x0)
> [    9.956643] ALSA hda_auto_parser.c:402    mono: mono_out=0x0
> [    9.956644] ALSA hda_auto_parser.c:406    inputs:
> [    9.956646] ALSA hda_auto_parser.c:410      Mic=0x1b
> [    9.956647] ALSA hda_auto_parser.c:410      Internal Mic=0x23
> [    9.956649] ALSA hda_auto_parser.c:410      Dock Mic=0x1a
> 
> the driver select this as best config
> 
> ==> Best config: lo_type=1, wired=1, mio=1
> multi_outs = 1f/0/0/0 : 10/0/0/0 (type SP)
>   out path: depth=2 :10:1f
> hp_outs = 19/1c/0/0 : 11/11/0/0
>   hp  path: depth=2 :11:19
>   hp  path: depth=2 :11:1c
> 
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pc
> i/hda/hda_generic.c?id=a07a949be6eb1c9aab06adaadce72dbd27b7d9cb
> 
> ALSA: hda - Fix multi-io channel mode management
> 
> this patch change the the channel_count from 2 to 4 since there are two
> headphone
> 
> + if (cfg->line_out_type != AUTO_PIN_HP_OUT)
> + spec->const_channel_count = max(spec->const_channel_count,
> + cfg->hp_outs * 2);
> 
> 
> 
> if you don't have docking station ,  the workaround is to remove those pin
> fix of node 0x1a and 0x1c

I dont have a docking station - but I have no clue what I should do here....

Thanks
Axel

--nextPart2929358.bW8mZd7BP6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlLar1oACgkQG9b1OutI7yJ7+ACcCpoF53VYy1wRTkpHEUQBfZLD
chUAmgIcbDL9LQAiirw0UPax1tKVgUOj
=Gcb9
-----END PGP SIGNATURE-----

--nextPart2929358.bW8mZd7BP6--


--===============5489148650041399404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5489148650041399404==--
