From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: [PATCH v2 16/21] ASoC: max98088: use
	match_string() helper
Date: Fri, 1 Jun 2018 08:38:13 +0800
Message-ID: <e7c6d379-8413-9af8-9562-17085359b2c5@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-17-git-send-email-xieyisheng1@huawei.com>
 <20180531114921.GD13319@sirena.org.uk>
 <8009e494-9ba0-bff3-e900-37f8923886a0@huawei.com>
 <20180531160206.GE13319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by alsa0.perex.cz (Postfix) with ESMTP id A5D372676DD
 for <alsa-devel@alsa-project.org>; Fri,  1 Jun 2018 02:39:38 +0200 (CEST)
In-Reply-To: <20180531160206.GE13319@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, andy.shevchenko@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 2018/6/1 0:02, Mark Brown wrote:
> On Thu, May 31, 2018 at 08:25:39PM +0800, Yisheng Xie wrote:
> 
>> Anyway, Here is the cover letter of v1 and I have add v2's cover letter to you:
>>   https://lkml.org/lkml/2018/5/21/303
> 
>> Each patch in this patchset is a separate one, for what this patchset want to do
>> is use match_string() helper for echo subsystem.
> 
> For something like this it's generally easier to not send everything as
> one big series - it avoids any confusion about dependencies and there's
> no actual relationship between the patches.  Instead just sending each
> subsystem as a series or perhaps even just a bunch of separate patches
> should make things smoother.

Thanks, will take this suggestion maybe next time.

Thanks
Yisheng
> 
