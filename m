From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: constify snd_soc_dai_ops
 structure
Date: Thu, 13 Jul 2017 16:10:56 -0500
Message-ID: <20170713161056.Horde.jVvECgjHYS4t4jiD4hqm2WC@gator4166.hostgator.com>
References: <20170713072351.GA1485@embeddedgus> <s5hlgnsiyg6.wl-tiwai@suse.de>
 <20170713101630.odml56qmsvgxqj64@sirena.org.uk>
 <20170713101814.Horde.q8OhHejhvSALVEt2o11aUTW@gator4166.hostgator.com>
 <1499969891.4457.59.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com
 [192.185.47.100])
 by alsa0.perex.cz (Postfix) with ESMTP id AF77426727D
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 23:10:58 +0200 (CEST)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
 by gateway22.websitewelcome.com (Postfix) with ESMTP id 79EB25765D
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 16:10:57 -0500 (CDT)
In-Reply-To: <1499969891.4457.59.camel@perches.com>
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
To: Joe Perches <joe@perches.com>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi Joe,

Quoting Joe Perches <joe@perches.com>:

> On Thu, 2017-07-13 at 10:18 -0500, Gustavo A. R. Silva wrote:
>> Hi Mark,
>>
>> Quoting Mark Brown <broonie@kernel.org>:
>>
>> > On Thu, Jul 13, 2017 at 09:32:41AM +0200, Takashi Iwai wrote:
>> >
>> > > please stop posting in this style.  It's really annoying to see
>> > > spontaneously popping-up almost same patch for more than two hours
>> > > long.
>> > > If you have a series of the same fix patches, send them as a patch
>> > > set in a shot with a thread.  git-send-email does it right.
>> > > I don't mind a couple of patches posted separately, but this is over
>> > > the limit.
>> >
>> > Or at least just collect them up and send them all at one time even if
>> > not as a single thread (you don't want to CC everyone affected by a
>> > single patch in the set on everything, that's harder to avoid when
>> > sending a series via git, but it can be confusing to get one item in a
>> > large patch series without context).
>>
>> I like this idea better. I will do so next time. :)
>
> I don't it's better.
>
> It's not that confusing if the 0/n patch cover letter is cc'd
> to all the appropriate mailing lists and all the [1..n]/n
> patches are sent with in-reply-to of the cover letter and
> send to the maintainers and appropriate mailing lists.

I ended up following your suggestions:

https://lkml.org/lkml/2017/7/13/739 (Notice that these are new  
patches. Not related to the ones I previously sent)

Much appreciated
Thanks!
--
Gustavo A. R. Silva
