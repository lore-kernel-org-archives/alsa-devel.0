From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: constify snd_soc_dai_ops
 structure
Date: Thu, 13 Jul 2017 10:18:14 -0500
Message-ID: <20170713101814.Horde.q8OhHejhvSALVEt2o11aUTW@gator4166.hostgator.com>
References: <20170713072351.GA1485@embeddedgus> <s5hlgnsiyg6.wl-tiwai@suse.de>
 <20170713101630.odml56qmsvgxqj64@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com
 [192.185.49.124])
 by alsa0.perex.cz (Postfix) with ESMTP id 78E85267264
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 17:18:16 +0200 (CEST)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
 by gateway23.websitewelcome.com (Postfix) with ESMTP id 00D41252C4
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 10:18:15 -0500 (CDT)
In-Reply-To: <20170713101630.odml56qmsvgxqj64@sirena.org.uk>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Quoting Mark Brown <broonie@kernel.org>:

> On Thu, Jul 13, 2017 at 09:32:41AM +0200, Takashi Iwai wrote:
>
>> please stop posting in this style.  It's really annoying to see
>> spontaneously popping-up almost same patch for more than two hours
>> long.
>
>> If you have a series of the same fix patches, send them as a patch
>> set in a shot with a thread.  git-send-email does it right.
>
>> I don't mind a couple of patches posted separately, but this is over
>> the limit.
>
> Or at least just collect them up and send them all at one time even if
> not as a single thread (you don't want to CC everyone affected by a
> single patch in the set on everything, that's harder to avoid when
> sending a series via git, but it can be confusing to get one item in a
> large patch series without context).

I like this idea better. I will do so next time. :)

Thank you
--
Gustavo A. R. Silva
