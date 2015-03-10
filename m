From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 01/14] ASoC: adav80x: Fix wrong value
 references for boolean kctl
Date: Tue, 10 Mar 2015 12:42:07 +0100
Message-ID: <54FED88F.5030904@metafoo.de>
References: <1425987556-569-1-git-send-email-tiwai@suse.de>
 <1425987556-569-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-239.synserver.de (smtp-out-239.synserver.de
 [212.40.185.239])
 by alsa0.perex.cz (Postfix) with ESMTP id 59BDA2617C6
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 12:42:03 +0100 (CET)
In-Reply-To: <1425987556-569-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On 03/10/2015 12:39 PM, Takashi Iwai wrote:
> The correct values referred by a boolean control are
> value.integer.value[], not value.enumerated.item[].
> The former is long while the latter is int, so it's even incompatible
> on 64bit architectures.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
