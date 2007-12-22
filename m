From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Softvol controls
Date: Sat, 22 Dec 2007 23:54:53 +0100
Message-ID: <20071222225453.GD13486@tango.0pointer.de>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5htznfhmhy.wl%tiwai@suse.de>
	<20071129232859.GA18138@tango.0pointer.de>
	<s5h8x4gf6rt.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0712041627310.7670@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 81861244AC
	for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2007 23:54:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0712041627310.7670@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 04.12.07 16:42, Jaroslav Kysela (perex@perex.cz) wrote:

> > No, there is no API to get the id mapping.
> > And I guess we can't do it because there is no 1:1 mapping between
> > ctl_elem and mixer_selem.  It's N:1.
> 
> I don't think that application should know about this mapping.
> 
> I think that we have to provide API giving a mixer control element for 
> opened PCM handle, otherwise applications might use hacks like 
> suggested snd_ctl_elem_info_is_user() checks.

Wouldn't it be possible to just provide a snd_mixer_elem_is_user()
function? Would be fine to solve my task, too...

> > > I figure there is no useful documentation or even example how this is
> > > supposed to work? Hmm, is there any real documentation available which
> > > describes the relation of ctl, hctl, mixer and smixer at all? For the
> > > uninitated the whols structure looks overly complex and redundant.
> > 
> > Yes, it's overly complex.  The mixer abstracion is what I'd really
> > love to clean up, maybe better to write from scratch.
> 
> I think that we might remove only 'mixer' and simplify initalization from 
> the user side, but each time I tried to think about an optimal mixer 
> interface, I ended with the current 'simple mixer API'.

Quite frankly, the whole structure of ctl, hctl, mixer and smixer is
one of the weakest points in the ALSA API. While it might make sense
to have these internally, I belive that exposing them all in the API was a
bad idea. (But actually, I only understand ALSA in parts, so maybe I
just am blind)
 
> > I guess PA could use ctl API better than mixer API because it requires
> > only certain elements like Master or PCM.  You can simply take
> > "Master Playback Control" with MIXER iface for master volume and
> > "Master Playback Switch" for master mute switch.  Of course, you'll
> > take care of number of channels or value range, but it's also same for
> > mixer API, too.
> 
> I don't agree here. The simple mixer layer should be used, because it 
> covers at least some abstraction. In my recent changes, we have 
> possibility to use python for fast prototyping of simple mixer backends 
> (see alsa-lib/modules/mixer/simple/python directory how fast with minimal 
> code can be backend implemented). Unfortunately, main problem will be
> probably the work to cover all cards.

So, what does this mean for me? As long as I have some way to detect
whether a mixer element is software-only I am happy. 

Should I now be following yours, or Takashi's advice? Should I wait
for a new interface to be added to the ALSA API?

Thanks,

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
