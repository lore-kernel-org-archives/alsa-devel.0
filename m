From: MR Swami Reddy <MR.Swami.Reddy@ti.com>
Subject: Re: [PATCH v2] ASoC: Support TI Isabelle Audio driver
Date: Mon, 4 Jun 2012 16:18:32 +0530
Message-ID: <4FCC9280.2090706@ti.com>
References: <1338569514-18106-1-git-send-email-MR.Swami.Reddy@ti.com>
	<20120604103519.GE7538@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 3367D104176
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 12:42:38 +0200 (CEST)
In-Reply-To: <20120604103519.GE7538@opensource.wolfsonmicro.com>
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

On Monday 04 June 2012 04:05 PM, Mark Brown wrote:
> On Fri, Jun 01, 2012 at 10:21:54PM +0530, MR.Swami.Reddy@ti.com wrote:
>
>>    o Used dev_get_regmap and devm_regmap_init_i2c APIs.
> This looks mostly good so I've applied it but please send an incremental
> patch to remove the use of regmap_exit() - the major point of devm_ APIs
> is that you don't need to explicitly clean things up, removing a class
> of potential leaks.

Thank you.
I will remove the regmap_exit() and send the next patch soon.
Plz confirm, do I need to send full patch or only removing part for
regmap_exit()?

Thanks
Swami
