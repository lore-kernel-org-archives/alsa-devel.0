From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH] ASoC: dwc: disallow building
 designware_pcm as a module
Date: Thu, 27 Apr 2017 19:49:04 +0100
Message-ID: <1fa94590-3dbf-922d-4fe7-1a507eec4b32@synopsys.com>
References: <20170418151834.c7e5fivmgn73sbwd@sirena.org.uk>
 <1492532010.28092.12.camel@v3.sk>
 <20170418171519.csiftftd434psyn5@sirena.org.uk>
 <2e39b000-bf25-6447-b53b-047401041f4e@synopsys.com>
 <1492618461.28092.18.camel@v3.sk>
 <03a3fbbb-7221-f4ee-5b1b-8fff518ea82c@synopsys.com>
 <20170420194646.qcpu7w3acjyfmeu5@sirena.org.uk>
 <s5h37d2su8h.wl-tiwai@suse.de>
 <376c5933-9321-5399-74c7-6fd4943fab3d@synopsys.com>
 <s5hshl2kpst.wl-tiwai@suse.de>
 <20170421104915.x7gxt5yqcuewa7rv@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.synopsys.com (smtprelay.synopsys.com [198.182.60.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A659266909
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 20:49:12 +0200 (CEST)
In-Reply-To: <20170421104915.x7gxt5yqcuewa7rv@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, Lubomir Rintel <lkundrak@v3.sk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

Hi,


On 21-04-2017 11:49, Mark Brown wrote:
> On Fri, Apr 21, 2017 at 12:39:30PM +0200, Takashi Iwai wrote:
>> Jose Abreu wrote:
>>> Maybe rename to "dwc-i2s.c" and "dwc-pcm.c" (as the folder is
>>> called "dwc") and let the module still be called "designware-i2s"?
>> Lubomir's patch keeps the module name intact.  My point is that rename
>> of a file isn't nice to look at the git commit history, so it's better
>> to be avoided as much as possible.  But in this case, it looks
>> unavoidable.
> Right.  Renaming the source file is the lesser evil, it's possible
> people might have the module name in their configuration for their
> systems somewhere.

I agree. I just noticed today that without a valid license tag we
get unresolved symbols when inserting pcm module so this patch is
really needed as a fix.

Lubomir, could you address the review comments and resend? If you
are not available let me know and I will fix and resend the patch
with your sign-off.

Best regards,
Jose Miguel Abreu
