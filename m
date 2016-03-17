From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: adau1701: Different sample rates need different
	firmwares
Date: Thu, 17 Mar 2016 13:40:07 +0100
Message-ID: <56EAA5A7.8080208@metafoo.de>
References: <56EA8C2C.4010606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-014.synserver.de
 [212.40.185.14])
 by alsa0.perex.cz (Postfix) with ESMTP id B71C426665D
 for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2016 13:40:11 +0100 (CET)
In-Reply-To: <56EA8C2C.4010606@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pascal Huerst <pascal.huerst@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 03/17/2016 11:51 AM, Pascal Huerst wrote:
> Hey Lars,
> 
> I'm having an issue with the adau1701 codec. There is this line which
> checks, if the mclk/lrclk ratio has changed and whether it is necessary
> to reset the codec and upload a new firmware.
> 
> http://lxr.free-electrons.com/source/sound/soc/codecs/adau1701.c#L444
> 
> But if we change mclk in the machine driver (for example to playback
> 44.1), this ration might not change, but still we have to upload a new
> firmware, so shouldn't we probably be checking for sample rate changes
> instead:
> 
> if (adau1701->current_rate != params_rate(params) {
> 	adau1701->current_rate = params_rate(params);
> 	ret = adau1701_reset(codec, clkdiv, params_rate(params));
> 	if (ret < 0)
> 		return ret;
> }
> 
> Or did I miss something?

Sounds good!

- Lars
