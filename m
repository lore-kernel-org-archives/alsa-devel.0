From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 6/8] ASoC: compress: Add support for DAI
	multicodec
Date: Tue, 01 Jul 2014 18:42:12 +0200
Message-ID: <53B2E4E4.7020006@metafoo.de>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-7-git-send-email-bcousson@baylibre.com>
 <53B2BC7F.2060909@metafoo.de> <20140701162540.GG2296@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-145.synserver.de
 [212.40.185.145])
 by alsa0.perex.cz (Postfix) with ESMTP id E6F6B261691
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 18:42:13 +0200 (CEST)
In-Reply-To: <20140701162540.GG2296@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, broonie@kernel.org, lgirdwood@gmail.com, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On 07/01/2014 06:25 PM, Vinod Koul wrote:
> On Tue, Jul 01, 2014 at 03:49:51PM +0200, Lars-Peter Clausen wrote:
>> On 07/01/2014 09:47 AM, Benoit Cousson wrote:
> And you should have cced me on this patch
>
>> [...]
>> for (i = 0; i < rtd->num_codecs; i++) {
>>> +		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
>>> +		/* check client and interface hw capabilities */
>>> +		snprintf(new_name, sizeof(new_name), "%s %s-%d",
>>> +			 rtd->dai_link->stream_name, codec_dai->name, num);
>>
>> We may need to rethink how to do the naming for multiple CODEC DAI
>> links here. This implementation will just keep overwriting new_name
>> with each loop iteration and end up using the last one. Vinod may
>> have some insights.
>
> I am intrugued on how we do this for pcms with multi-codec support.
>
> Looking at the patch series I dont think the soc_pcm_new() has been updated
> (please point out if i missed, it is late in night)
> Shouldnt this be updated for pcm too?
>
> I would suggest makes sense is to keep appending the codec name for the
> dai-link. But yes keep a check on the size. Unless we have better ideas.
>

This is what the patch series does for normal PCMs

  	snprintf(new_name, sizeof(new_name), "%s %s-%d",
-		rtd->dai_link->stream_name, codec_dai->name, num);
+		rtd->dai_link->stream_name,
+		(rtd->num_codecs > 1) ?
+		"multicodec" : rtd->codec_dai->name, num);
