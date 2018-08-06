From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH 11/11] ASoC: wm8994: Mark expected switch
	fall-through
Date: Mon, 6 Aug 2018 06:59:46 -0500
Message-ID: <a413a275-3f89-e8fa-df02-b669aa64dbf2@embeddedor.com>
References: <cover.1533151956.git.gustavo@embeddedor.com>
 <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com>
 <30613.1533313609@turing-police.cc.vt.edu>
 <85d918a5-6a14-ead0-4d0e-d63b5e43ad81@embeddedor.com>
 <20180803164504.GF6591@sirena.org.uk>
 <684a4fe9-6818-d19c-e7b7-fb8d592a0cee@embeddedor.com>
 <39703.1533318918@turing-police.cc.vt.edu>
 <20180806113426.GA17525@sirena.org.uk>
 <e839abf4-cf54-fe2e-7eb8-57b12106b586@embeddedor.com>
 <20180806115256.GC17525@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway32.websitewelcome.com (gateway32.websitewelcome.com
 [192.185.145.187])
 by alsa0.perex.cz (Postfix) with ESMTP id B66F12677A2
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 13:59:49 +0200 (CEST)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
 by gateway32.websitewelcome.com (Postfix) with ESMTP id 5E5264A252
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 06:59:48 -0500 (CDT)
In-Reply-To: <20180806115256.GC17525@sirena.org.uk>
Content-Language: en-US
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
Cc: alsa-devel@alsa-project.org, valdis.kletnieks@vt.edu, patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 08/06/2018 06:52 AM, Mark Brown wrote:
> On Mon, Aug 06, 2018 at 06:48:13AM -0500, Gustavo A. R. Silva wrote:
> 
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.
> 

Sure thing.

>> OK. I'll send a patch for this. But I wonder what's the best approach in this case,
>> so the fix can also be applied to stable.
> 
> Just send a patch, a fixup can be done when the backport fails.
> 

I got it.

I'll send the patch and I'll take care of the backport when the
time comes.

Thanks
--
Gustavo
