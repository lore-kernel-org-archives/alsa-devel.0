From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: asoundrc parse error (bug)
Date: Thu, 9 May 2002 09:26:57 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0205090856280.544-100000@pnote.perex-int.cz>
References: <200205090119.g491JtS22138@op.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA21867
	for <alsa-devel@alsa-project.org>; Thu, 9 May 2002 09:27:21 +0200
In-Reply-To: <200205090119.g491JtS22138@op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 8 May 2002, Paul Davis wrote:

> i mentioned a month or two ago that the parsing of asoundrc didn't
> handle things that were apparently integers unless they were
> quoted. abramo claimed this was fixed, and indeed it is in top level
> constructs. but here's one:
> 
> pcm.9652 {
> 	type hw
> 	card 2
> }
> 
> pcm.st {
>        type plug
>        slave.pcm 9652
>        ttable.0.24 1
>        ttable.1.25 1
> }       
> 
> this will fail unless you put the "9652" for the slave.pcm definition
> in quotes. the error is:
> 
> ALSA lib pcm.c:1621:(snd_pcm_open_conf) Invalid type for PCM definition (id: pcm, value: 9652)
> arecord: main:447: audio open error: Invalid argument

It's ok, slave.pcm should be a string (as defined in asoundrc.txt or 
alsa-lib reference guide).

> 
> further, this:
> 
> pcm.spdif {
>        type plug
>        slave.pcm "9652"
>        ttable.0.24 1
>        ttable.1.25 1
> }       
> 
> will fail like this:
> 
> ALSA lib conf.c:1131:(parse_def) spdif is not a compound
> ALSA lib conf.c:1520:(snd_config_load1) _toplevel_:16:11:Invalid argument
> ALSA lib conf.c:2616:(snd_config_hook_load) /home/pbd/.asoundrc may be old or corrupted: consider to remove or fix it
> ALSA lib conf.c:2463:(snd_config_hooks_call) function snd_config_hook_load returned error: Invalid argument
> ALSA lib conf.c:2859:(snd_config_update_r) hooks failed, removing configuration
> aplay: pcm_list:248: snd_config_update: Invalid argument
> pbd[555]>aplay -L
> ALSA lib conf.c:1131:(parse_def) spdif is not a compound
> ALSA lib conf.c:1520:(snd_config_load1) _toplevel_:16:11:Invalid argument
> ALSA lib conf.c:2616:(snd_config_hook_load) /home/pbd/.asoundrc may be old or corrupted: consider to remove or fix it
> ALSA lib conf.c:2463:(snd_config_hooks_call) function snd_config_hook_load returned error: Invalid argument
> ALSA lib conf.c:2859:(snd_config_update_r) hooks failed, removing configuration
> aplay: pcm_list:248: snd_config_update: Invalid argument
> 
> simply changing "spdif" to "st" will fix that error. it seems that
> "spdif" is recognized as a keyword, or something like that.

We have already defined pcm.spdif in global configuration file 
/usr/share/alsa/alsa.conf. If you want to override the defaults you should 
use 'pcm.!spdif { }' (override old configuration node).

Anyway, it would be better to add support for RME cards to standard 
configuration files. I've created initial ones, could you verify them?
They are placed in /usr/share/alsa/cards/ directory - RME9636.conf and 
RME9652.conf files (sources are in alsa-lib/src/conf). The S/PDIF output 
should work as 'plug:spdif' or  simply 'spdif' when no conversion is 
necessary.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
