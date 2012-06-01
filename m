From: MR Swami Reddy <MR.Swami.Reddy@ti.com>
Subject: Re: [PATCH RESEND] ASoC: Support TI Isabelle Audio
	driver
Date: Fri, 1 Jun 2012 19:22:43 +0530
Message-ID: <4FC8C92B.6000200@ti.com>
References: <1338289786-2751-1-git-send-email-MR.Swami.Reddy@ti.com>
	<20120530164008.GO9947@opensource.wolfsonmicro.com>
	<4FC8B476.4030305@ti.com>
	<20120601124624.GM24139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 17489103F6E
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2012 15:47:04 +0200 (CEST)
In-Reply-To: <20120601124624.GM24139@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Deshpande A,
	Vishwas" <Vishwas.A.Deshpande@ti.com>, "Girdwood, Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Friday 01 June 2012 06:16 PM, Mark Brown wrote:
> On Fri, Jun 01, 2012 at 05:54:22PM +0530, MR Swami Reddy wrote:
>> On Wednesday 30 May 2012 10:10 PM, Mark Brown wrote:
>>> If this is all you need then you should be able to use the newly
>>> introduced dev_get_regmap() to get the regmap back (other drivers should
>>> be being updated for this soon).
>> The dev_get_regmap() is not found in the 'for-next' or '3.5' branch. So
>> this api can't be used with 'for-next' source base. Please advice. 
> It's in Linus' tree so it'll be in for-3.6 just as soon as the merge
> window is open.  While the merge window is still open we don't update
> anything in for-next except for bug fixes but once the merge window
> closes I'll rebase for-3.6 onto -rc1 and add that into for-next.
>
Is it OK, if Ithe 'dev_get_regmap()' api will be included in the patch,
after its merged into 'for-next' branch?

Thanks
Swami
