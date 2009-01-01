From: sware <microcontrolfreak@gmail.com>
Subject: Re: Subject: [PATCH 1/1] set invalid dma channel to -1
 (and	properly check for it) since 0 is not an invalid channel but -1 is.
Date: Thu, 01 Jan 2009 09:29:06 -0800
Message-ID: <495CFD62.2010706@gmail.com>
References: <495BF49B.1000907@gmail.com> <20090101112951.GA6888@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by alsa0.perex.cz (Postfix) with ESMTP id ACF8424390
	for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2009 18:29:23 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so5548762rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 01 Jan 2009 09:29:22 -0800 (PST)
In-Reply-To: <20090101112951.GA6888@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA project mailing list <alsa-devel@alsa-project.org>, Dennis O'Brien <dennis.obrien@eqware.net>
List-Id: alsa-devel@alsa-project.org

Thanks, everyone. Especially Mark for pointing the way to a proper git
patch.

-stephen

Mark Brown wrote:
> On Wed, Dec 31, 2008 at 02:39:23PM -0800, sware wrote:
>   
>> Set the invalid dma channel to -1 (and check properly for it) in pxa2xx_pcm_hw_free().
>> Was assuming 0 is an invalid channel number but 0 is a valid pxa dma channel num.
>>     
>
>   
>> Signed-off-by: stephen <stephen.ware@eqware.net>
>>     
>
> Applied, thanks.
>
>   
