From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-lib] Query regarding
 snd_config_update_free_global() and threads etc.
Date: Mon, 23 Aug 2010 17:13:15 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008231710320.10278@eeebox2.perex-int.cz>
References: <i4tflh$8c4$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 0605D2413A
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 17:13:16 +0200 (CEST)
In-Reply-To: <i4tflh$8c4$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 23 Aug 2010, Colin Guthrie wrote:

> Hi there,
>
> I've got a (hopefully quick) query about snd_config_update_free_global()
> and it's general thread safetyness.
>
>
> I'm currently going insane on this bug:
> https://bugs.kde.org/show_bug.cgi?id=232068
> which revolves around a bug manifested in snd_pcm_close() (or rather
> snd_pcm_ioplug_close()) when dealing with the ALSA->PulseAudio plugin.
>
>> From what I can gather, this problem is related to a KDE module that is
> loaded into the library in question which does some alsa probing and
> ultimately calls snd_config_update_free_global() several times. The
> library itself then goes on to use GStreamer to do actual audio output.
> The crash then manifests itself prior to any sound actually being output.
>
> I can reliably reproduce the machine on two machines (I don't have many
> at my disposal), but cannot reproduce on a third. The two I can
> reproduce it on are two and four core intel duo's. The one I cannot
> reproduce on is an older, single core machine. I am leaning towards some
> kind of thread safety issue.
>
>
> In searching for similar problems, I found several references to similar
> crashes attributed to snd_dlobj_cache_cleanup() perhaps not being thread
> safe.

I tried to work on snd_dlobj_cache issues. Please, could you test this 
patch?

http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=91c9c8f1b85e69b4bdc94a777d2767c4906c3f47

 					Thanks,
 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
