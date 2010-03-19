From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Are ALSA io plugins implemented as threads or does
 ALSA use fork() ?
Date: Fri, 19 Mar 2010 15:44:57 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003191530230.3925@eeebox2.perex-int.cz>
References: <4BA3882B.4030809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FA2A2413F
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 15:44:58 +0100 (CET)
In-Reply-To: <4BA3882B.4030809@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Mar 2010, Stefan Schoenleitner wrote:

> Hello,
>
> from what I have learned so far ALSA io plugins are implemented as
> shared libraries with their entry point defined with the
> SND_PCM_PLUGIN_DEFINE_FUNC() macro.
>
> However, each plugin instance can only work for either the
> SND_PCM_STREAM_PLAYBACK or SND_PCM_STREAM_CAPTURE stream.
> Hence this is why io plugins supporting playback and capture usually set
> up their callback functions depending on what type of stream is used.
>
> For example in the pulseaudio io plugin, this is done with:
>
> pcm->io.callback = stream == SND_PCM_STREAM_PLAYBACK ?
>     &pulse_playback_callback : &pulse_capture_callback;
>
>
>
>
> * If such a plugin is used for capture AND playback at the same time, it
> seems that two instances of the plugin need to be running, right ?
>
> * Are these instances running as separate processes (i.e. fork()) or are
> they implemented as threads ? How is this implemented internally in the
> ALSA code ?

No forks or threads. Both instances will run in one process with the 
audio application. The plugin code must take core how many pcm instances 
are active and send the appropriate communication file descriptors to 
application for select/poll I/O multiplexing.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
