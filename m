From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Thu, 11 Sep 2014 11:49:22 +0800
Message-ID: <CAN8cciZcnJ4sM37-nCiYa4F98O5=jcQpXD+ApKip1d4T+-6m9g@mail.gmail.com>
References: <540C76E0.9050808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f44.google.com (mail-qg0-f44.google.com
 [209.85.192.44])
 by alsa0.perex.cz (Postfix) with ESMTP id A7C6D265613
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 05:49:23 +0200 (CEST)
Received: by mail-qg0-f44.google.com with SMTP id f51so8130903qge.17
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 20:49:22 -0700 (PDT)
In-Reply-To: <540C76E0.9050808@gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

>
> On my desktop PC, on snd-hda-intel with analog outputs for S16LE stereo,
the granularity is 32 bytes (= 8 samples), and I get the pointer
granularity of 64 bytes (=16 samples) over HDMI. The minimum period size is
32 samples in both cases.

Do you mean hda-Intel does not support arbritray period size when you say
the granularity is 32 bytes ?

However the granularity of the emulated hda sound card inside any VM depend
on the vm and the backend audio system and sound card
