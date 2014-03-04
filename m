From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: SNDRV_PCM_INFO_BATCH
Date: Tue, 04 Mar 2014 15:50:04 +0100
Message-ID: <5315E81C.2010704@ladisch.de>
References: <5315E118.7060809@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 1B54B265774
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 15:50:06 +0100 (CET)
In-Reply-To: <5315E118.7060809@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> So, PulseAudio removed timer scheduling for drivers with
> SNDRV_PCM_INFO_BATCH, and released 5.0. Meanwhile, USB drivers still
> have SNDRV_PCM_INFO_BATCH, so this leads to performance regressions for
> USB sound cards.
>
> The question remains - what does SNDRV_PCM_INFO_BATCH really mean?

For your purposes, it means that the pointer accuracy is likely to be
worse than that of other sound cards.

There should be a mechanism to report the actual granularity.


Regards,
Clemens
