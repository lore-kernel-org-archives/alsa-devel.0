From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC PATCH 0/4] better support for bursty DMA
	usages
Date: Wed, 22 Jul 2015 22:44:50 +0800
Message-ID: <CAN8ccibqTEjm5LQw5JKnSyL-1z6FJvb60C8EMnu6cV1p=FAzKw@mail.gmail.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <CAN8cciaoV=GqnLmukZvHGz+YjSu85nGcHzrhACAkOeH0692VhA@mail.gmail.com>
 <55A6380E.4060605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 2406E260563
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 16:44:52 +0200 (CEST)
Received: by oigd21 with SMTP id d21so102752179oig.1
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 07:44:51 -0700 (PDT)
In-Reply-To: <55A6380E.4060605@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

>>>
>>> TODO:
>>> 1. fixes and alsa-lib updates (compile-tested only for now)
>>
>>
>>
http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/src/modules/alsa/alsa-sink.c?id=cb55b00ccd25d965b1222e74375aee05427a449b
>>
>> Do you need a new api snd_pcm_hw_params_can_rewind() for the application
to
>> know pcm device does not support rewind ?
>
> Yes, we do need that.
>
> Please see my LAC 2015 paper: http://lac.linuxaudio.org/2015/papers/10.pdf

What kind of driver or plugin will have this flag  ?

snd-aloop,

ioplug : pulse and  jack

Are those usb-audio configure as usb-passthrough inside vm still rewindable
?

How about multi plug when one of the slaves  has this flag ?

file plugin depend on whether slave device support rewind or not
