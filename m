From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Improve error reporting in Speyside
 WM8962 driver
Date: Thu, 30 Jun 2011 19:08:21 +0100
Message-ID: <4E0CBB95.2020005@ti.com>
References: <1309382331-30552-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110630165617.GF26397@qtel.sh.intel.com>
	<20110630180225.GB5064@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id C6887245CD
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jun 2011 20:08:27 +0200 (CEST)
In-Reply-To: <20110630180225.GB5064@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 30/06/11 19:02, Mark Brown wrote:
> On Fri, Jul 01, 2011 at 12:56:17AM +0800, Lu Guanqun wrote:
>> On Thu, Jun 30, 2011 at 05:18:51AM +0800, Mark Brown wrote:
>>>  			if (ret < 0)
>>> -				pr_err("Failed to start FLL\n");
>>> +				pr_err("Failed to start FLL: %d\n");
> 
>> missed 'ret' here? :)
> 
> Fixed locally, Liam I'll not bother reposting if you're otherwise OK?

I'm OK.

Liam
