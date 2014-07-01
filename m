From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v4 6/8] ASoC: compress: Add support for DAI
	multicodec
Date: Tue, 01 Jul 2014 19:32:32 +0200
Message-ID: <53B2F0B0.6060600@baylibre.com>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-7-git-send-email-bcousson@baylibre.com>
 <53B2BC7F.2060909@metafoo.de> <20140701162540.GG2296@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id E77272652E5
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 19:32:34 +0200 (CEST)
Received: by mail-wg0-f41.google.com with SMTP id a1so10221053wgh.24
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 10:32:34 -0700 (PDT)
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
To: Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: misael.lopez@ti.com, broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/07/2014 18:25, Vinod Koul wrote:
> On Tue, Jul 01, 2014 at 03:49:51PM +0200, Lars-Peter Clausen wrote:
>> On 07/01/2014 09:47 AM, Benoit Cousson wrote:
> And you should have cced me on this patch

Sorry, my mistake. I'll add you for the next release.

Regards,
Benoit

>
>> [...]
>> for (i =3D 0; i < rtd->num_codecs; i++) {
>>> +		struct snd_soc_dai *codec_dai =3D rtd->codec_dais[i];
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
> Looking at the patch series I dont think the soc_pcm_new() has been updat=
ed
> (please point out if i missed, it is late in night)
> Shouldnt this be updated for pcm too?
>
> I would suggest makes sense is to keep appending the codec name for the
> dai-link. But yes keep a check on the size. Unless we have better ideas.
>


-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
