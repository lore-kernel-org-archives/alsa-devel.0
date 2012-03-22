From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
Subject: Re: [PATCH 05/16] ASoC: core: Add strobe control
Date: Thu, 22 Mar 2012 18:09:22 +0100
Message-ID: <4F6B5CC2.60605@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-6-git-send-email-ola.o.lilja@stericsson.com>
	<20120313213356.GE3177@opensource.wolfsonmicro.com>
	<4F6B5136.5040208@stericsson.com>
	<20120322163352.GL3091@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog111.obsmtp.com (eu1sys200aog111.obsmtp.com
	[207.126.144.131])
	by alsa0.perex.cz (Postfix) with ESMTP id BD6DF10442C
	for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2012 18:09:50 +0100 (CET)
In-Reply-To: <20120322163352.GL3091@opensource.wolfsonmicro.com>
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
Cc: Ola LILJA2 <ola.o.lilja@stericsson.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 2012-03-22 17:33, Mark Brown wrote:

> On Thu, Mar 22, 2012 at 05:20:06PM +0100, Kristoffer KARLSSON wrote:
>> On 2012-03-13 22:33, Mark Brown wrote:
>>> On Tue, Mar 13, 2012 at 04:11:32PM +0100, Ola Lilja wrote:
> 
>>> Based on this description it's hard to see why this control is patterned
>>> after an enum - why would we have an enumerated control to bounce a
>>> single register bit on then off?
> 
>> I originally chose to pattern this control after an enum since enum controls
>> would allow for exposing such intuitive textual information to the client about
>> the state of the control for this type of use case.
> 
> But if this is a strobe control it has no state, you do a write to
> generate a strobe but the strobe lasts for no meaningful time so isn't
> observable.


You are correct. The state would not be the most important thing since normally
there be only one client accessing the card in this very short period of time
like you said. However the allowing for a way to expose a strobe "action"
control would. So do you think it should be modeled after a SOC_SINGLE_EXT
instead or how would you prefer that a strobe "action" control be implemented?
