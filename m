From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Softvol controls
Date: Sat, 22 Dec 2007 23:48:30 +0100
Message-ID: <20071222224830.GC13486@tango.0pointer.de>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5htznfhmhy.wl%tiwai@suse.de>
	<20071129232859.GA18138@tango.0pointer.de>
	<s5h8x4gf6rt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 265F52448B
	for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2007 23:48:31 +0100 (CET)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 30.11.07 09:59, Takashi Iwai (tiwai@suse.de) wrote:

> > > Check snd_ctl_elem_info_is_user().  All softvol controls are
> > > implemented as user elements.
> > 
> > Hmm, how am I supposed to get the snd_ctl_elem_info_t from a
> > snd_mixer_elem_t or snd_mixer_selem_id_t?
> 
> No, there is no API to get the id mapping.
> And I guess we can't do it because there is no 1:1 mapping between
> ctl_elem and mixer_selem.  It's N:1.

May I simply suggest some kind of enumeration API? If it's 1:1 or N:1
doesn't really matter. Either you have a simple _get() function or a
set of enumeration functions. Only a tiny bit more complicated...

> > I figure there is no useful documentation or even example how this is
> > supposed to work? Hmm, is there any real documentation available which
> > describes the relation of ctl, hctl, mixer and smixer at all? For the
> > uninitated the whols structure looks overly complex and redundant.
> 
> Yes, it's overly complex.  The mixer abstracion is what I'd really
> love to clean up, maybe better to write from scratch.
> 
> I guess PA could use ctl API better than mixer API because it requires
> only certain elements like Master or PCM.  You can simply take
> "Master Playback Control" with MIXER iface for master volume and
> "Master Playback Switch" for master mute switch.  Of course, you'll
> take care of number of channels or value range, but it's also same for
> mixer API, too.

Oh my! the lack of useful documentation or examples for using the ctl
interface is a real issue. It takes up so much time for me to make
sense of your APIs by guessing and trying to understand what you were
thinking when you designed it, guys! :-(

/me gumbly studies the ALSA sources a bit more.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
