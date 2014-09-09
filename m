From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Master Plan on rewinding
Date: Tue, 09 Sep 2014 10:43:06 +0200
Message-ID: <540EBD9A.9000009@ladisch.de>
References: <540C76E0.9050808@gmail.com> <540CC53B.7080204@ladisch.de>
 <540D5B46.3020904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id DB59926262A
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 10:43:08 +0200 (CEST)
In-Reply-To: <540D5B46.3020904@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Alexander E. Patrakov wrote:
> |---------|---------P----h----p---------|-a-------|---------|
>
> So, what should alsa-lib return for snd_pcm_avail() and snd_pcm_rewind()?
> The driver only knows that "P" is already used, can infer that "p" isn't
> used yet, and knows nothing about samples in the middle.

Indeed.  However, the DMA pointer moves asynchronously, so it is possible
that it has already moved beyond p when snd_pcm_rewindable() returns.
For the samples between P and p, the risk is larger than for those after
p, but p is not a boundary where the risk abruptly decreases.

It would make sense to report the pointer update granularity, but not
to adjust the return value of snd_pcm_avail/rewindable().


Regards,
Clemens
