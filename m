From: Paul Davis <pbd@op.net>
Subject: asoundrc parse error (bug)
Date: Wed, 8 May 2002 21:19:55 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205090119.g491JtS22138@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA17836
	for <alsa-devel@alsa-project.org>; Thu, 9 May 2002 03:19:10 +0200
Received: from op.net (maxtnt04-110.phlpa.fast.net [209.92.96.110])
	by post2.fast.net (8.11.2/8.9.3) with ESMTP id g491J1v06463
	for <alsa-devel@alsa-project.org>; Wed, 8 May 2002 21:19:05 -0400 (EDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

i mentioned a month or two ago that the parsing of asoundrc didn't
handle things that were apparently integers unless they were
quoted. abramo claimed this was fixed, and indeed it is in top level
constructs. but here's one:

pcm.9652 {
	type hw
	card 2
}

pcm.st {
       type plug
       slave.pcm 9652
       ttable.0.24 1
       ttable.1.25 1
}       

this will fail unless you put the "9652" for the slave.pcm definition
in quotes. the error is:

ALSA lib pcm.c:1621:(snd_pcm_open_conf) Invalid type for PCM definition (id: pcm, value: 9652)
arecord: main:447: audio open error: Invalid argument

further, this:

pcm.spdif {
       type plug
       slave.pcm "9652"
       ttable.0.24 1
       ttable.1.25 1
}       

will fail like this:

ALSA lib conf.c:1131:(parse_def) spdif is not a compound
ALSA lib conf.c:1520:(snd_config_load1) _toplevel_:16:11:Invalid argument
ALSA lib conf.c:2616:(snd_config_hook_load) /home/pbd/.asoundrc may be old or corrupted: consider to remove or fix it
ALSA lib conf.c:2463:(snd_config_hooks_call) function snd_config_hook_load returned error: Invalid argument
ALSA lib conf.c:2859:(snd_config_update_r) hooks failed, removing configuration
aplay: pcm_list:248: snd_config_update: Invalid argument
pbd[555]>aplay -L
ALSA lib conf.c:1131:(parse_def) spdif is not a compound
ALSA lib conf.c:1520:(snd_config_load1) _toplevel_:16:11:Invalid argument
ALSA lib conf.c:2616:(snd_config_hook_load) /home/pbd/.asoundrc may be old or corrupted: consider to remove or fix it
ALSA lib conf.c:2463:(snd_config_hooks_call) function snd_config_hook_load returned error: Invalid argument
ALSA lib conf.c:2859:(snd_config_update_r) hooks failed, removing configuration
aplay: pcm_list:248: snd_config_update: Invalid argument

simply changing "spdif" to "st" will fix that error. it seems that
"spdif" is recognized as a keyword, or something like that.

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
