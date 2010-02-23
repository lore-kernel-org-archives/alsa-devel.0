From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Tue, 23 Feb 2010 23:20:04 +0100
Message-ID: <20100223222004.GA5313@tango.0pointer.de>
References: <4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218023742.GC23637@tango.0pointer.de>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
	<4f3252891002190257u608073c3l48f2251d8a6458ee@mail.gmail.com>
	<20100219151328.GC25873@tango.0pointer.de>
	<4f3252891002201949k48e0208fw40590803ac1a8192@mail.gmail.com>
	<20100221193933.GA31800@tango.0pointer.de>
	<4f3252891002222047g33ecdb74qce6a997ea5792c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 1ABCD1037EE
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 23:20:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4f3252891002222047g33ecdb74qce6a997ea5792c0@mail.gmail.com>
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

On Tue, 23.02.10 12:47, Raymond Yau (superquad.vortex2@gmail.com) wrote:

> > > The most common onboard audio is HDA so this is not any exceptional cases
> > >
> > > Those HDA multi streaming  feature are most users wanted in desktop
> > > enviornment, are pulseaudio really designed for deskop or just only for
> > > notebook and mobile ?
> > >
> > > The front panel green/pink jack can be used by one application while the
> > > rear panel audio jacks can be used to another application for surround or
> > > mic for karaoke
> >
> > I am not entirely convinced that this is really a common case.

Uh, I wanted to say "use case" here...

> Do any PA developer has a desktop computer  with HDA audio ?

I certainly do. But the fact that this is not the most common use case
and the ALSA API is not really up to the task yet to query the full
routing table I am not sure supporting parallel and independant
streaming support for heapdphones and speakers should be a priority for PA.

> if ( snd_pcm_info_get_subdevices_count(pcm_info) > 1 ) && (
> snd_pcm_info_get_subdevices_count(pcm_info) < 8 ))
> 
> snd_mixer_selem_id_set_index(sid, snd_pcm_info_get_subdevice(pcm_info));

Are you suggesting that on all drivers the the index part of a
snd_mixer_selem_id_t directly relates to the subdevice id of a PCM
stream on the same card? Is that true? Jaroslav, Clemens, Takashi, can
you say something about that?

(tbh I find that very unlikely, given that the device index would not be
encoded then)

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
