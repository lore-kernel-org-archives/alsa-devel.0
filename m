From: Patrick Lai <plai@codeaurora.org>
Subject: Re: ASoC Peek individual register debugfs
Date: Fri, 22 Jul 2011 11:52:44 -0700
Message-ID: <4E29C6FC.6060801@codeaurora.org>
References: <4E28C543.5090802@codeaurora.org>
	<20110722090757.GG23192@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E2F7103804
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jul 2011 20:52:51 +0200 (CEST)
In-Reply-To: <20110722090757.GG23192@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, brubin@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 7/22/2011 2:07 AM, Mark Brown wrote:
> On Thu, Jul 21, 2011 at 05:33:07PM -0700, Patrick Lai wrote:
>
>> Does latest soc-core.c provide debugfs interface for peeking individual
>> register? If not, I plan to add this interface.
>
> codec_reg.  This is the sort of question that can easily be answered by
> looking at the code, or a running system.

I checked soc-core.c on Linux next and I do not believe there is such 
debugfs interface. Here is the interface proposal.

By default, cat codec_reg prints entire register dump
If someone echo "<register_addr>" > codec_reg before running
cat codec_reg, only register address and value of given register
would be printed. Afterward, state gets reset. Entire register dump gets 
printed if user cat codec_reg again

Please let me know if the proposal is not appropriate. Otherwise,
I will start implementation going by proposed interface.

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
