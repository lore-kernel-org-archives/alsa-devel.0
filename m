From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC PATCH 0/4] better support for bursty DMA
	usages
Date: Wed, 15 Jul 2015 18:14:17 +0800
Message-ID: <CAN8cciaoV=GqnLmukZvHGz+YjSu85nGcHzrhACAkOeH0692VhA@mail.gmail.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
 [209.85.218.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BC0F265838
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 12:14:18 +0200 (CEST)
Received: by oiab3 with SMTP id b3so25064420oia.1
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 03:14:17 -0700 (PDT)
In-Reply-To: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> Set of patches to fix issues with hw_ptr fuzziness [1] and increased
buffering
>  w/ DSPs
>
> 1. disable rewinds to allow for new HDaudio SPIB DMA functionality (fetch
up to
> the application pointer, rewinds not supported)
> 2. report max in-flight bytes to avoid problems with stale data (late
wake-ups,
> rewinds)
>
> [1]
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093646.html
>
> TODO:
> 1. fixes and alsa-lib updates (compile-tested only for now)

http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/src/modules/alsa/alsa-sink.c?id=cb55b00ccd25d965b1222e74375aee05427a449b

Do you need a new api snd_pcm_hw_params_can_rewind() for the application to
know pcm device does not support rewind ?
