From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: period_time in slave definition
Date: Mon, 28 Feb 2011 14:15:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102281412520.7877@eeebox2.perex-int.cz>
References: <4D6B943E.4060302@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B008103824
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 14:15:05 +0100 (CET)
In-Reply-To: <4D6B943E.4060302@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 28 Feb 2011, Pavel Hofman wrote:

> Hi,
>
> According to
> http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html , my
> .asoundrc contains:
>
> pcm.test {
>        type plug
>        slave {
>                pcm "hw:0"
>                format "unchanged"
>                channels "unchanged"
>                rate "unchanged"
>                period_size 1024
>                buffer_size 4096
>        }
> }
>
>
> While pcm, format, channels, and rate are accepted, the period and
> buffer fields are refused:
>
> ALSA lib pcm.c:6811:(snd_pcm_slave_conf) Unknown field period_time

It's correct, pcm:plug does not support buffer modifiers. Look to 
"Automatic conversion plugin".

> I checked the source code and the keywords seem to be ok
>
> pcm.c:
> static const char *const names[SND_PCM_HW_PARAM_LAST_INTERVAL + 1] = {
> 	[SND_PCM_HW_PARAM_FORMAT] = "format",
> 	[SND_PCM_HW_PARAM_CHANNELS] = "channels",
> 	[SND_PCM_HW_PARAM_RATE] = "rate",
> 	[SND_PCM_HW_PARAM_PERIOD_TIME] = "period_time",
> 	[SND_PCM_HW_PARAM_PERIOD_SIZE] = "period_size",
> 	[SND_PCM_HW_PARAM_BUFFER_TIME] = "buffer_time",
> 	[SND_PCM_HW_PARAM_BUFFER_SIZE] = "buffer_size",
> 	[SND_PCM_HW_PARAM_PERIODS] = "periods"
> };

It's just a table to translate all possibilites between index and name. 
The plug plugins allow only this:

 	err = snd_pcm_slave_conf(root, slave, &sconf, 3,
 				 SND_PCM_HW_PARAM_FORMAT, SCONF_UNCHANGED, &sformat,
 				 SND_PCM_HW_PARAM_CHANNELS, SCONF_UNCHANGED, &schannels,
 				 SND_PCM_HW_PARAM_RATE, SCONF_UNCHANGED, &srate);

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
