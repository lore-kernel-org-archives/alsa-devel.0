From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Sat, 13 Sep 2014 17:15:38 +0800
Message-ID: <CAN8cciZBrMQ64QK-QMbSw0RgkY+b+eGek_v1rs7Gm79Ti+UHVA@mail.gmail.com>
References: <540C76E0.9050808@gmail.com>
 <CAN8cciZcnJ4sM37-nCiYa4F98O5=jcQpXD+ApKip1d4T+-6m9g@mail.gmail.com>
 <CAA+gEbbd9+9u1k9E9M7eYP3kUc77PPOeGAzZxTOemS_M6ZJAbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f47.google.com (mail-qg0-f47.google.com
 [209.85.192.47])
 by alsa0.perex.cz (Postfix) with ESMTP id A937E266267
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 11:15:39 +0200 (CEST)
Received: by mail-qg0-f47.google.com with SMTP id i50so1827475qgf.20
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 02:15:38 -0700 (PDT)
In-Reply-To: <CAA+gEbbd9+9u1k9E9M7eYP3kUc77PPOeGAzZxTOemS_M6ZJAbQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "A. C. Censi" <accensi@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "Alexander E. Patrakov" <patrakov@gmail.com>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

>
> > However the granularity of the emulated hda sound card inside any VM
depend on the vm and the backend audio system and sound card
>
> Obviously it is a "virtual granularity".
>

Seem emulate dma transfer

http://git.kernel.org/cgit/virt/kvm/qemu-kvm.git/plain/hw/intel-hda.c

But not all backend can provide same granularity

http://git.kernel.org/cgit/virt/kvm/qemu-kvm.git/tree/audio
