From: Kristof Pelckmans <Kristof.Pelckmans@antwerpen.be>
Subject: Re: dsnoop, dshare and dmix plugins
Date: Mon, 24 Mar 2003 10:09:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048496974.3e7ecb4ec270e@albert.homedns.org>
References: <Pine.LNX.4.44.0303191801460.1351-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from yoda.planetinternet.be (anvers-smtp.planetinternet.be [195.95.30.152])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA05297
	for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2003 10:10:21 +0100
In-Reply-To: <Pine.LNX.4.44.0303191801460.1351-100000@pnote.perex-int.cz>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

I tried to use the dmix plugin, as mentioned :
> pcm.dmix_analog {
>         type dmix
>         ipc_key 5678293
>         ipc_key_add_uid yes
>         slave {
>                 pcm "hw:0,0"
>         }
>         bindings {
>                 0 0
>                 1 1
>         }
> }

When I do
aplay -D dmix_analog tv.wav 
Playing WAVE 'tv.wav' : Signed 32 bit Little Endian, Rate 48000 Hz, Stereo
aplay: set_params:810: Channels count non available

The wav-file was recorded from my M-Audio Delta 410 card. Could this still be a problem with the driver ?

So next I tried to do
aplay -D plug:dmix_analog tv.wav 
Playing WAVE 'tv.wav' : Signed 32 bit Little Endian, Rate 48000 Hz, Stereo

Which plays some garbled sound, nothing that resembles what I recorded

The strange thing is that the dshare plugings work (no distorted sound), as long as I specify the 'plug' plugin :
aplay -D plug:dshare_right tv.wav

I'm confused about this behaviour, since I thought the memory mapping for dmix and dshare would be relatively similar.

One last question : can you combine dmix and dshare ?

Thanks for any comments !

Kristof

> pcm.dshare_left {
>         type dshare
>         ipc_key 6678293
>         ipc_key_add_uid yes
>         slave {
>                 pcm "hw:0,0"
>         }
>         bindings {
>                 0 0
>         }
> }
> 
> pcm.dshare_right {
>         type dshare
>         ipc_key 6678293
>         ipc_key_add_uid yes
>         slave {
>                 pcm "hw:0,0"
>         }
>         bindings {
>                 0 1
>         }
> }


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
