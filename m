From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 3/5] ALSA: ASoC: McASP: add support for 24
	bit samples
Date: Tue, 09 Oct 2012 09:30:11 +0200
Message-ID: <5073D283.6080906@gmail.com>
References: <1349356122-14794-1-git-send-email-zonque@gmail.com>
 <1349356122-14794-4-git-send-email-zonque@gmail.com>
 <20121009071755.GX8237@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E947265086
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 09:30:19 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so1987044bku.38
 for <alsa-devel@alsa-project.org>; Tue, 09 Oct 2012 00:30:19 -0700 (PDT)
In-Reply-To: <20121009071755.GX8237@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Matt Porter <mporter@ti.com>, alsa-devel@alsa-project.org, lrg@ti.com, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org

On 09.10.2012 09:17, Mark Brown wrote:
> On Thu, Oct 04, 2012 at 03:08:40PM +0200, Daniel Mack wrote:
> 
>> +	case SNDRV_PCM_FORMAT_U24_3LE:
>> +	case SNDRV_PCM_FORMAT_S24_3LE:
>> +	case SNDRV_PCM_FORMAT_U24_LE:
>> +	case SNDRV_PCM_FORMAT_S24_LE:
>> +		dma_params->data_type = 3;
>> +		word_length = DAVINCI_AUDIO_WORD_24;
>> +		break;
>> +
> 
> This is fine but should be adding the format to the set of supported
> formats in the DAI as well, otherwise userspace should never select 24
> bits.
> 

Thanks for the review! I'll quickly resend this one.
