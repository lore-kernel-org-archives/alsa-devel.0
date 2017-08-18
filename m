From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v3 2/9] ASoC: rockchip: Remove obsolete
	dmic-delay
Date: Fri, 18 Aug 2017 09:41:54 +0800
Message-ID: <599645E2.4020402@rock-chips.com>
References: <20170817044417.22069-1-jeffy.chen@rock-chips.com>
 <20170817044417.22069-3-jeffy.chen@rock-chips.com>
 <20170817171152.abf3ngr6nr22jfif@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular2.263xmail.com (regular2.263xmail.com [211.157.152.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 965A926648D
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 03:42:46 +0200 (CEST)
Received: from regular1.263xmail.com (unknown [192.168.165.231])
 by regular2.263xmail.com (Postfix) with ESMTP id B20FC1EC67
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 09:42:42 +0800 (CST)
In-Reply-To: <20170817171152.abf3ngr6nr22jfif@sirena.org.uk>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, heiko@sntech.de, Liam Girdwood <lgirdwood@gmail.com>, briannorris@chromium.org, dianders@chromium.org, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, mka@chromium.org, Takashi Iwai <tiwai@suse.com>, dgreid@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

thanks for your reply

On 08/18/2017 01:11 AM, Mark Brown wrote:
> On Thu, Aug 17, 2017 at 12:44:10PM +0800, Jeffy Chen wrote:
>
>> This property is no longer used.
>
>> -Optional properties:
>> -- dmic-wakeup-delay-ms : specify delay time (ms) for DMIC ready.
>> -  If this option is specified, which means it's required dmic need
>> -  delay for DMIC to ready so that rt5514 can avoid recording before
>> -  DMIC send valid data
>
> Why would nobody ever want to use this in future?
>

hmmm, check again, rt5514 fixed this issue in there driver instead in:
a5461fd6c8f7 ASoC: rt5514: Add the DMIC initial delay to wait it ready.

so we don't need this...
