From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dsnoop, dshare and dmix plugins
Date: Mon, 24 Mar 2003 11:17:28 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303241115360.6755-100000@pnote.perex-int.cz>
References: <1048496974.3e7ecb4ec270e@albert.homedns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA06685
	for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2003 11:17:24 +0100
In-Reply-To: <1048496974.3e7ecb4ec270e@albert.homedns.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kristof Pelckmans <Kristof.Pelckmans@antwerpen.be>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Mar 2003, Kristof Pelckmans wrote:

> Hi all,
> 
> I tried to use the dmix plugin, as mentioned :
> > pcm.dmix_analog {
> >         type dmix
> >         ipc_key 5678293
> >         ipc_key_add_uid yes
> >         slave {
> >                 pcm "hw:0,0"
> >         }
> >         bindings {
> >                 0 0
> >                 1 1
> >         }
> > }
> 
> When I do
> aplay -D dmix_analog tv.wav 
> Playing WAVE 'tv.wav' : Signed 32 bit Little Endian, Rate 48000 Hz, Stereo
> aplay: set_params:810: Channels count non available
> 
> The wav-file was recorded from my M-Audio Delta 410 card. Could this still be a problem with the driver ?

Can I see the output from 'aplay -v -D plug:dmix_analog tv.wav'?

> So next I tried to do
> aplay -D plug:dmix_analog tv.wav
> Playing WAVE 'tv.wav' : Signed 32 bit Little Endian, Rate 48000 Hz, Stereo
>
> Which plays some garbled sound, nothing that resembles what I recorded

The 32-bit mixing code is not debugged. Please, could you try to change
one line in pcm_dmix.c (alsa-lib/src/pcm/pcm_dmix.c) from
'#ifdef __i386__' to '#ifdef __i386XX__' and recompile library?
We'll see then if it's a problem with the i386 assembler code.

> The strange thing is that the dshare plugings work (no distorted sound),
> as long as I specify the 'plug' plugin : aplay -D plug:dshare_right
> tv.wav
>
> I'm confused about this behaviour, since I thought the memory mapping
> for dmix and dshare would be relatively similar.
>
> One last question : can you combine dmix and dshare ?

Nope. If you use only one application for specific channels (dmix plugin)
then you'll get same results as dshare. The only difference is that dshare
transfers are a bit more optimized (it does only copy not sum of samples).
Perhaps we can optimize dmix in this way later.

                                                Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
