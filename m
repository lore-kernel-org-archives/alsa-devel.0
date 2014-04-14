From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [RFT v2 5/6] ASoC: core: Add helpers for dai link
 and aux dev init
Date: Mon, 14 Apr 2014 22:12:43 +0200
Message-ID: <534C413B.4010402@baylibre.com>
References: <1395415650-20045-1-git-send-email-bcousson@baylibre.com>
 <1395415650-20045-6-git-send-email-bcousson@baylibre.com>
 <20140414193906.GL25182@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 89216261A53
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 22:12:48 +0200 (CEST)
Received: by mail-wi0-f177.google.com with SMTP id cc10so4641247wib.4
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 13:12:47 -0700 (PDT)
In-Reply-To: <20140414193906.GL25182@sirena.org.uk>
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
Cc: Fabien Parent <fparent@baylibre.com>, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 14/04/2014 21:39, Mark Brown wrote:
> On Fri, Mar 21, 2014 at 04:27:29PM +0100, Benoit Cousson wrote:
>> From: Misael Lopez Cruz <misael.lopez@ti.com>
>>
>> Separate DAI link and aux dev initialization in preparation for
>> DAI multicodec support.
>> Since aux dev will remain using single codecs but DAI links
>> will be able to support multiple codecs.
>
> I applied everything up to here.  This one didn't apply, probably due to
> context changes but I didn't make any real effort to understand the
> issue.

Yep, I've just seen that. It is indeed a small move in the previous =

context code.

I'm still in the process of updating the series based on Lars comments, =

but was somehow too busy the last 2 weeks to complete the changes.
I should be able to post the update this week.

Sorry for the delay.

Thanks,
Benoit

-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
