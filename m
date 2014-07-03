From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 4/5] ALSA: pcm_dmaengine: Correct support for 24bits
 physical sample widths
Date: Thu, 03 Jul 2014 10:29:22 +0200
Message-ID: <53B51462.1090805@metafoo.de>
References: <1404363116-10538-1-git-send-email-peter.ujfalusi@ti.com> <1404363116-10538-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404363116-10538-5-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, vinod.koul@intel.com, dan.j.williams@intel.com, tiwai@suse.de, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, joelf@ti.com, nsekhar@ti.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, dmaengine@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 07/03/2014 06:51 AM, Peter Ujfalusi wrote:
> In case of _3LE/_3BE formats the samples are stored in 3 consecutive bytes
> without padding it to 4 bytes. This means that the DMA needs to be able to
> support 3 bytes word length in order to read/write the samples from memory
> correctly. Originally the code treated 24 bits physical length samples as
> they were 32 bits which leads to corruption when playing or recording audio.
>
> The hw.formats field has already been prepared to exclude formats not
> supported by the DMA engine in use, which means that only on platforms where
> 3 bytes is supported by the DMA will be able to use this format.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
