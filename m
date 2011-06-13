From: Liam Girdwood <lrg@ti.com>
Subject: Re: soc-dsp questions
Date: Mon, 13 Jun 2011 18:49:51 +0100
Message-ID: <4DF64DBF.4020908@ti.com>
References: <BANLkTi=jmoZOvxe=29Et=C6YYHrFZ58evw@mail.gmail.com>	<1303810865.3332.57.camel@odin>	<20110426101848.GA23812@sirena.org.uk>	<4DF1C08F.90306@codeaurora.org>	<20110610094226.GA26436@opensource.wolfsonmicro.com>
	<4DF2C2BD.6050505@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id E1E9A24367
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 19:49:58 +0200 (CEST)
In-Reply-To: <4DF2C2BD.6050505@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "waiw@codeaurora.org" <waiw@codeaurora.org>, pl bossart <bossart.nospam@gmail.com>, "asishb@codeaurora.org" <asishb@codeaurora.org>, "jaywang@codeaurora.org" <jaywang@codeaurora.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 11/06/11 02:19, Patrick Lai wrote:
> On 6/10/2011 2:42 AM, Mark Brown wrote:
> 
>>
>> That might be handlable by either of the methods I was suggesting above.
>> Of course depending on the algorithms you're running the DSP may want
>> more mics than it's producing output channels - beam forming or noise
>> cancellation are the obvious examples there.
> 
> Yes, exactly.
> 
>> Do you mean not also a concern?  I *believe* OMAP is passing the
>> configuration through to the external DAI using the front end/back end
>> connection so the format gets selected by the app when it does a record,
> 

This is correct. We pass configuration from the FE PCM to all the connected BE DAIs.

Liam
