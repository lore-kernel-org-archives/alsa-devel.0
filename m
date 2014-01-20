From: Axel Braun <axel.braun@gmx.de>
Subject: Re: Thinkpad T520 (Low Volume)
Date: Mon, 20 Jan 2014 13:56:32 +0100
Message-ID: <1850988.oa86JCBIJg@t520.axxite.internal>
References: <CAN8ccib14G8pyLuMTi2BS6_hW0StBxEEu4EcUv2HKG==BQ27NQ@mail.gmail.com>
 <3997344.dLRXQbcGtH@t520.axxite.internal>
 <CAN8cciZTWd5zJDfBjqkaTRWfimirq+iqiaEHZpJKt8biY2poSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3585523923057250457=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DF3D92615FC
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2014 13:56:34 +0100 (CET)
Received: from t520.axxite.internal ([193.96.98.225]) by mail.gmx.com
 (mrgmx003) with ESMTPSA (Nemesis) id 0MBWTO-1WDVsS1Cb8-00AXOt for
 <alsa-devel@alsa-project.org>; Mon, 20 Jan 2014 13:56:34 +0100
In-Reply-To: <CAN8cciZTWd5zJDfBjqkaTRWfimirq+iqiaEHZpJKt8biY2poSQ@mail.gmail.com>
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


--===============3585523923057250457==
Content-Type: multipart/signed; boundary="nextPart2369244.GXvars31kJ"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart2369244.GXvars31kJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Montag, 20. Januar 2014, 09:27:57 schrieb Raymond Yau:
> > > > same problem on a ThinkPad T520, sound volume is way
> > > > too low - watching movie via loudspeakers is fairly impossible.
> > > > Any hint you could give me?
> > > > post the output of alsa-info.sh , there is a bug in alsa-driver which
> > > > treat
> > > > dock headphone and headphone to support surround 4.0
> > > > you get low volume because Amp Out vals are 0x3d instead of 0x4a but
> > > > speaker volumes are at 100% (0dB)
> > 
> > Can I influence that from the running system, e.g. by
> > echo 0x4d > ....
> 
> refer to user manual, it seem that both headset and headphone are supported
> but you cannot use conventional mic  with this combo audio jack
> 
> are you using headset or headphone ?

I'm using a headset from a smartphone - it is the same 3,5mm jack

> do headset mic work or not ?

works fine

> try hda_analyzer to change the volume slider of those nodes 0x10 and 0x11

maybe I'm on the wrong track...but do I have to apply the diff code to the 
alsa source code and then rebuild the package?

> > ?
> > 
> > > Simple mixer control 'Speaker',0
> > > 
> > >   Capabilities: pvolume pswitch
> > >   Playback channels: Front Left - Front Right
> > >   Limits: Playback 0 - 74
> > >   Mono:
> > >   Front Left: Playback 74 [100%] [0.00dB] [on]
> > >   Front Right: Playback 74 [100%] [0.00dB] [on]
> > > 
> > > Node 0x10 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
> > > 
> > >   Control: name="Speaker Playback Volume", index=0, device=0
> > >   
> > >     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
> > >   
> > >   Control: name="Speaker Playback Switch", index=0, device=0
> > >   
> > >     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
> > >   
> > >   Device: name="CX20590 Analog", type="Audio", device=0
> > >   Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
> > >   Amp-Out vals:  [0x3d 0x3d]
> > > 
> > > if you don't have docking station ,  the workaround is to remove those
> > 
> > pin
> > 
> > > fix of node 0x1a and 0x1c
> > 
> > I dont have a docking station - but I have no clue what I should do
> > here...
> 
> the easy way is to use model=nofixup since your bios does not have dock
> headphone and dock mic pins default but this also remove mic mute led

model=nofixup ad parameter for the module snd_hda_intel ?

> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pc
> i/hda/patch_conexant.c?id=2fd3f170e5ba04acc60ee94b2c76ee166727c734
> 
> 
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pc
> i/hda/patch_conexant.c?id=d70f363222ef373c2037412f09a600357cfa1c7a
> 
> just remove dock mic and dock hp from cxt_pincfg_lenovo_tp410
> 
> /* ThinkPad 410/420/510/520, X201 & co with cxt5066 */
> static const struct cxt_pincfg cxt_pincfg_lenovo_tp410[] = {
>  { 0x19, 0x042110ff }, /* HP (seq# overridden) */
> - { 0x1a, 0x21a190f0 }, /* dock-mic */
> - { 0x1c, 0x212140ff }, /* dock-HP */
>  {}
> };
> 
> 
> there are dock stations which only has combo jack for the dock headset and
> some have dock mic and dock headphone jacks
> 
> 
> as some notebooks have dual headphone jacks , should those headphone pin
> put in multi out with mic jack retasked to support 5.1


--nextPart2369244.GXvars31kJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlLdHQAACgkQG9b1OutI7yKCugCeLlpXZZLVLLqJpQV+YUyUB4lo
leEAn2riB8+baiswoMcIYHpsrrdr0QKr
=J1Oo
-----END PGP SIGNATURE-----

--nextPart2369244.GXvars31kJ--


--===============3585523923057250457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3585523923057250457==--
