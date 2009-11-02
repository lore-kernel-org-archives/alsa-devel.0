From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] alsa-lib: snd_device_name_hint misbehaving
Date: Mon, 2 Nov 2009 07:21:51 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0911020718220.5500@eeebox2.perex-int.cz>
References: <1257128586.16837.29.camel@dark-knight>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A68811037F1
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 07:21:51 +0100 (CET)
In-Reply-To: <1257128586.16837.29.camel@dark-knight>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Lindgren <john.lindgren@tds.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 1 Nov 2009, John Lindgren wrote:

> * Remove erroneous snd_config_delete calls that cause later calls to
> snd_pcm_open to fail.

It does not look good. Have you checked with valgrind if there are no 
memory leaks?

> * Don't list card-independent PCM devices ("null" or PulseAudio, for
> example) more than once even if multiple sound cards are installed.
>
> * Add "ctl" to the list of device types that snd_device_name_hint can
> search for.
>
> * Cache the path to libasound.so within snd_dlopen rather than looking
> it up with dladdr every call.

Please, split your changes to single patches. Thanks.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
