From: Mike Dunn <mikedunn@newsguy.com>
Subject: Re: [PATCH 4/4] ALSA: pxa27x: rename
	pxa27x_assert_ac97()
Date: Mon, 07 Jan 2013 06:34:33 -0800
Message-ID: <50EADCF9.10307@newsguy.com>
References: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com>
 <1357499640-13871-5-git-send-email-mikedunn@newsguy.com>
 <50EA97EA.4030807@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.newsguy.com (smtp.newsguy.com [74.209.136.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F4972650F2
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2013 15:34:14 +0100 (CET)
In-Reply-To: <50EA97EA.4030807@compulab.co.il>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 01/07/2013 01:39 AM, Igor Grinberg wrote:
> 
> 
> On 01/06/13 21:14, Mike Dunn wrote:
>> This patch does nothing functionally, it just gives the function a new name and
>> modifies the prototype slightly in order to clarify what the function is doing
>> (which is not necessarily asserting the reset).
>> Some commentary also added.
>>
>> Tested on a palm treo 680 machine.
>>
>> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> 
> This patch makes sense, but again raising your concern...
> The gpio_direction_output(reset_gpio, 1) should be called after
> the change to AF0.


Can you clarify please?  Don't you mean *before* the change to AF0?  The proper
values must be set in the GPDR and GPSR/GPCR before changing to AF0, no?  This
not only makes intuitive sense, it is also consistent with the information in
the pxa270 developer's manual.  Once AF0 is set, the last values that were set
for direction and level take immediate effect, no?

Thanks,
Mike
