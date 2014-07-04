From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v4 1/8] ASoC: core: Change
 soc_link_dai_widgets signature for multiple codecs
Date: Fri, 04 Jul 2014 18:13:38 +0200
Message-ID: <53B6D2B2.5000607@baylibre.com>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-2-git-send-email-bcousson@baylibre.com>
 <20140701171735.GB15028@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CF802659FF
 for <alsa-devel@alsa-project.org>; Fri,  4 Jul 2014 18:13:40 +0200 (CEST)
Received: by mail-wi0-f173.google.com with SMTP id cc10so13164774wib.12
 for <alsa-devel@alsa-project.org>; Fri, 04 Jul 2014 09:13:40 -0700 (PDT)
In-Reply-To: <20140701171735.GB15028@sirena.org.uk>
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
Cc: misael.lopez@ti.com, lars@metafoo.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 01/07/2014 19:17, Mark Brown wrote:
> On Tue, Jul 01, 2014 at 09:47:54AM +0200, Benoit Cousson wrote:
>> Since multiple codecs DAI will be usable in the future, remove
>> explicit unique codec_dai and cpu_dai parameters.
>> Replace them with snd_soc_pcm_runtime pointer that will contain
>> every instances.
>
> Applied, thanks.

Where did you applied this patch and the next one? I couldn't find them =

during the rebase. Neither in asoc/for-next nor in topic/multicodec.

Thanks,
Benoit

-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
