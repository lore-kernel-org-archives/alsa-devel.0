From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How does ALSALIB commuciates with low level
	kernel	API
Date: Wed, 15 Jun 2016 09:00:01 +0200
Message-ID: <aaf09bd5-826e-e895-b99e-822f9f03b0ec@ladisch.de>
References: <CAHkWnPYuUgrARoMDHjg-0vSKVfz7x6tfh9cpzoEHzvEs+cvUKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B7B5C2608EA
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 09:00:03 +0200 (CEST)
In-Reply-To: <CAHkWnPYuUgrARoMDHjg-0vSKVfz7x6tfh9cpzoEHzvEs+cvUKA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chemsi Mehdi <chmsmehdi@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Chemsi Mehdi wrote:
> I want to underatnd how ALSA userspace API calls kernel space code ?
> for example when I call  snd_pcm_open() which code is called in kernel
> sound code ?

The generic PCM code in alsa-lib/src/pcm/pcm.c calls some plugin.
The "hw" plugin (in pcm_hw.c) handles communication with the kernel.

The kernel code is in sound/core/.

> and how the link is made ? via IOCTL/write ?

Yes.


Regards,
Clemens
