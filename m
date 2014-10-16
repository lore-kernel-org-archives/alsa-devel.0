From: Anatol Pomazau <anatol@google.com>
Subject: Re: [PATCH] ASoC: tegra: Add platform driver for
	rt5677 audio codec
Date: Thu, 16 Oct 2014 01:59:58 -0700
Message-ID: <CALj_zD4-8TWKvX9vebTM5j__o3NgjjfPO+7ZvjPUzFX3dO10sA@mail.gmail.com>
References: <1413407742-19112-1-git-send-email-anatol.pomozov@gmail.com>
 <20141016073846.GA724@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 by alsa0.perex.cz (Postfix) with ESMTP id DA96E2614A0
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 10:59:59 +0200 (CEST)
Received: by mail-oi0-f44.google.com with SMTP id x69so2350368oia.31
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 01:59:58 -0700 (PDT)
In-Reply-To: <20141016073846.GA724@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, lars@metafoo.de, Stephen Warren <swarren@nvidia.com>, Anatol Pomozov <anatol.pomozov@gmail.com>, Bard Liao <bardliao@realtek.com>, Laurent Dahan <ldahan@nvidia.com>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Thu, Oct 16, 2014 at 12:38 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Oct 15, 2014 at 02:15:42PM -0700, Anatol Pomozov wrote:
>
>> +Required properties:
>> +- nvidia,speaker-codec: The phandle of the board specific speaker amplifier.
>> +  This binding assumes that AIF2 on the audio CODEC is connected to this
>> +  amplifier.
>
> To repeat my comment on the previous version:
>
> | This isn't as generic as all that, it relies on the specific speaker
> | driver.  I'd suggest either just saying it's board specific or making
> | the speaker CODEC optional.
>
> Please don't ignore review comments.

In the description of the dts property I said that its board specific
amp. If it not what you want then I do not know what "saying it's
board specific" means. Could you please provide examples of "board
specific" properties?
