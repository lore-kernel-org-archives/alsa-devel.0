From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.34
Date: Thu, 25 Feb 2010 17:44:07 +0000
Message-ID: <F09D4078-E4A5-4277-A6A9-9BFF91056206@opensource.wolfsonmicro.com>
References: <20100225160959.GA3241@opensource.wolfsonmicro.com>
	<s5heik9l19n.wl%tiwai@suse.de>
	(sfid-20100225_163745_623863_B585F8DB)
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B09C110380F
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 19:36:51 +0100 (CET)
In-Reply-To: <s5heik9l19n.wl%tiwai@suse.de>
	(sfid-20100225_163745_623863_B585F8DB)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 25 Feb 2010, at 16:37, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 25 Feb 2010 16:10:00 +0000,
> Mark Brown wrote:
>>
>> The following changes since commit  
>> d62abe563fa4718e7f85f3e871655434db92366d:
>>  Misael Lopez Cruz (1):
>>        OMAP4: PMIC: Add support for twl6030 codec
>>
>> are available in the git repository at:
>>
>>  git://opensource.wolfsonmicro.com/linux-2.6-asoc.git for-2.6.34
>>
>> These wind up being a bug fix, without fixing the reporting of the
>> periods a lot of hardware is going to get lots of clock domain  
>> issues.
>>
>> Mark Brown (2):
>>      ASoC: Remove a unused variables from i.MX FIQ runtime data
>>      ASoC: Check progress when reporting periods from i.MX FIQ  
>> handler
>>
>> sound/soc/imx/imx-pcm-fiq.c |   40 +++++++++++++++++++++++++++++ 
>> +----------
>> 1 files changed, 30 insertions(+), 10 deletions(-)
>
> I pulled but got only the commit:
>
>    commit f893e2766ad6c05288cf037716a8b041b8df3ed1
>    Author: Jassi Brar <jassi.brar@samsung.com>
>    Date:   Thu Feb 25 11:24:53 2010 +0900
>
>    ASoC: soc_pcm_open: Add missing bailout tag
>
> Forgot to push?

Note that that's not the usual server - master.kernel.org wasn't  
responding. I'll check when I get home.

>
>
> Takashi
