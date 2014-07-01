From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v4 2/8] ASoC: pcm: Refactor
	soc_pcm_apply_msb for multicodecs
Date: Tue, 01 Jul 2014 19:31:28 +0200
Message-ID: <53B2F070.8010706@baylibre.com>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-3-git-send-email-bcousson@baylibre.com>
 <20140701172053.GC15028@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 101DD265139
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 19:31:32 +0200 (CEST)
Received: by mail-wg0-f43.google.com with SMTP id k14so1169259wgh.14
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 10:31:31 -0700 (PDT)
In-Reply-To: <20140701172053.GC15028@sirena.org.uk>
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

On 01/07/2014 19:20, Mark Brown wrote:
> On Tue, Jul 01, 2014 at 09:47:55AM +0200, Benoit Cousson wrote:
>> Refactor the function to facilitate the migration to
>> multiple codecs.
>
> Applied, thanks.
>
>> Fix a trailing space in the header as well.
>
> Please don't do things like this if they're not in a part of the code
> being changed, it makes review a bit harder.  A separate patch would be
> fine.

OK, sorry about that. I'll not do it again.

Thanks,
Benoit

-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
