From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Softvol controls
Date: Tue, 4 Dec 2007 16:42:55 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0712041627310.7670@tm8103.perex-int.cz>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5htznfhmhy.wl%tiwai@suse.de>
	<20071129232859.GA18138@tango.0pointer.de>
	<s5h8x4gf6rt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A1A1D24433
	for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2007 16:42:56 +0100 (CET)
In-Reply-To: <s5h8x4gf6rt.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 30 Nov 2007, Takashi Iwai wrote:

> At Fri, 30 Nov 2007 00:28:59 +0100,
> Lennart Poettering wrote:
> > 
> > On Wed, 21.11.07 12:22, Takashi Iwai (tiwai@suse.de) wrote:
> > 
> > > >    Now, is there a way I can detect for a mixer element if it is
> > > >    "real" or if it is implemented only for the "plughw" PCM? As it
> > > >    seems the "hw:0" mixer device does contain "virtual" tracks, isn't that a
> > > >    bit strange? Shouldn't the virtual mixer tracks be available only
> > > >    in a mixer device "plughw:0"? That at least would be symmetric to
> > > >    the PCM case, wouldn't it?
> > > 
> > > Check snd_ctl_elem_info_is_user().  All softvol controls are
> > > implemented as user elements.
> > 
> > Hmm, how am I supposed to get the snd_ctl_elem_info_t from a
> > snd_mixer_elem_t or snd_mixer_selem_id_t?
> 
> No, there is no API to get the id mapping.
> And I guess we can't do it because there is no 1:1 mapping between
> ctl_elem and mixer_selem.  It's N:1.

I don't think that application should know about this mapping.

I think that we have to provide API giving a mixer control element for 
opened PCM handle, otherwise applications might use hacks like 
suggested snd_ctl_elem_info_is_user() checks.

> > I figure there is no useful documentation or even example how this is
> > supposed to work? Hmm, is there any real documentation available which
> > describes the relation of ctl, hctl, mixer and smixer at all? For the
> > uninitated the whols structure looks overly complex and redundant.
> 
> Yes, it's overly complex.  The mixer abstracion is what I'd really
> love to clean up, maybe better to write from scratch.

I think that we might remove only 'mixer' and simplify initalization from 
the user side, but each time I tried to think about an optimal mixer 
interface, I ended with the current 'simple mixer API'.

> I guess PA could use ctl API better than mixer API because it requires
> only certain elements like Master or PCM.  You can simply take
> "Master Playback Control" with MIXER iface for master volume and
> "Master Playback Switch" for master mute switch.  Of course, you'll
> take care of number of channels or value range, but it's also same for
> mixer API, too.

I don't agree here. The simple mixer layer should be used, because it 
covers at least some abstraction. In my recent changes, we have 
possibility to use python for fast prototyping of simple mixer backends 
(see alsa-lib/modules/mixer/simple/python directory how fast with minimal 
code can be backend implemented). Unfortunately, main problem will be
probably the work to cover all cards.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
