From: Jyri Sarha <jsarha@ti.com>
Subject: Re: ASoC updates for v3.15
Date: Thu, 13 Mar 2014 18:13:12 +0200
Message-ID: <5321D918.4010805@ti.com>
References: <20140313142939.GZ366@sirena.org.uk>
 <s5hd2hqxiz4.wl%tiwai@suse.de> <5321CF52.1070708@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D8032652F6
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 17:13:18 +0100 (CET)
In-Reply-To: <5321CF52.1070708@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/13/2014 05:31 PM, Lars-Peter Clausen wrote:
> On 03/13/2014 03:37 PM, Takashi Iwai wrote:
> [...]
...
>> make[3]: *** [sound/soc/codecs/tlv320aic31xx.o] Error 1
>
> Adding Jyri to Cc. Jyri can you send a patch that fixes this up? There
> was a overlap between your patch and a cleanup that changed the
> signature of snd_soc_codec_set_cache_io(). Note that you can just drop
> both the control_data assignment and the snd_soc_codec_set_cache_io()
> call from your codec probe function since this is now done automatically
> by the core.
>

I'll mail a patch for this in a minute...

Best regards,
Jyri
