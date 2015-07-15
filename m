From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [RFC PATCH 0/4] better support for bursty DMA
	usages
Date: Wed, 15 Jul 2015 15:38:06 +0500
Message-ID: <55A6380E.4060605@gmail.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <CAN8cciaoV=GqnLmukZvHGz+YjSu85nGcHzrhACAkOeH0692VhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
 [209.85.215.49])
 by alsa0.perex.cz (Postfix) with ESMTP id A33E12659D7
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 12:34:02 +0200 (CEST)
Received: by lagw2 with SMTP id w2so21914562lag.3
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 03:34:02 -0700 (PDT)
In-Reply-To: <CAN8cciaoV=GqnLmukZvHGz+YjSu85nGcHzrhACAkOeH0692VhA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

15.07.2015 15:14, Raymond Yau wrote:
>> TODO:
>> 1. fixes and alsa-lib updates (compile-tested only for now)
>
> http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/src/modules/alsa/alsa-sink.c?id=cb55b00ccd25d965b1222e74375aee05427a449b
>
> Do you need a new api snd_pcm_hw_params_can_rewind() for the application to
> know pcm device does not support rewind ?
Yes, we do need that.

Please see my LAC 2015 paper: http://lac.linuxaudio.org/2015/papers/10.pdf

-- 
Alexander E. Patrakov
