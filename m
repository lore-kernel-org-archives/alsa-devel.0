From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [RFC] ASoC: core: Add support for DAI multicodec
Date: Thu, 13 Mar 2014 11:42:50 +0100
Message-ID: <53218BAA.9000600@baylibre.com>
References: <1394536644-21438-1-git-send-email-bcousson@baylibre.com>
 <20140312002821.GD28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id C612A265176
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 11:42:53 +0100 (CET)
Received: by mail-wg0-f50.google.com with SMTP id x13so654080wgg.21
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 03:42:53 -0700 (PDT)
In-Reply-To: <20140312002821.GD28112@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 12/03/2014 01:28, Mark Brown wrote:
> On Tue, Mar 11, 2014 at 12:17:24PM +0100, Benoit Cousson wrote:
>> From: Misael Lopez Cruz <misael.lopez@ti.com>
>>
>> DAI link assumes a one to one mapping between CPU DAI and CODEC. In
>> some cases, the same CPU DAI can be connected to several codecs.
>> This is the case for example, if you connect two mono codecs to the
>> same I2S link in order to have a stereo card.
>> The current ASoC implementation does not allow such setup.
>
> First up thanks for working on this, it's a feature which has been
> requested for a long time but nobody stepped forward to do it before
> now.
>
> This is rather large so I've not had time to review it today, I'll try
> to get at least a first pass at that done tomorrow.  I did notice that
> in your comment about rebasing you mentioned a series - it'd be good if
> we could see this as a series, splitting it up would make review easier.

Yeah, I know. The issue is that the original series was done on a 3.8 =

Android branch with few refactor patches before that one to introduce =

some helpers. During the 3.8 -> 3.13 rebase then 3.13 -> 3.14 rebase, a =

lot of them did not survive due to internal asoc changes and cleanups =

that happened since 3.8.

At least, there are still few helpers that can be introduced sooner, but =

it will still make the main patch pretty huge. I don't think we can make =

the transition in smaller chunks.

>> CPU DAI in a multicodec DAI link can have more channels than what each
>> CODEC has. The number of channels each CODEC is responsible for is
>> machine specific, hence it's fixed up in machine drivers in a similar
>> way to what DPCM does.
>
> This one is interesting.  It feels like most things will want a static
> mapping because that's what the hardware does but there will doubtless
> be things that could use flexibility.  Liam has looked at this in the
> past (more for TDM IIRC, I thought about it for that as well and I seem
> to recall Liam's ideas covering it).  It feels like we should start out
> with static mappings and build up dynamic later on but equally well
> getting something merged would mean we could improve on it.
>
>> The patch is based on 3.14-rc6.
>
> For such an invasive set of changes it's probably worth working off
> -next, I forsee conflicts.

Indeed, I've just tried rebasing it on asoc/next and it does conflict :-(
But not a major conflict anyway. I'll do that for the repost.

Thanks for the comments,
Benoit


-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
