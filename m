From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 4/6] ASoC: OMAP: Add CPU DAI driver for HDMI
Date: Sun, 8 May 2011 20:44:41 +0100
Message-ID: <4DC6F2A9.8070804@ti.com>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-5-git-send-email-ricardo.neri@ti.com>
	<20110505082253.GF11744@opensource.wolfsonmicro.com>
	<1304624105.1900.41.camel@sagan>
	<20110506132133.GM23729@opensource.wolfsonmicro.com>
	<1304813117.11941.197.camel@sagan>
	<20110508103402.GA12921@opensource.wolfsonmicro.com>
	<4DC67AFC.5040607@ti.com>
	<20110508155628.GA32214@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DDBC1037FF
	for <alsa-devel@alsa-project.org>;
	Sun,  8 May 2011 21:44:49 +0200 (CEST)
In-Reply-To: <20110508155628.GA32214@opensource.wolfsonmicro.com>
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
Cc: "Neri, Ricardo" <ricardo.neri@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 08/05/11 16:56, Mark Brown wrote:
> On Sun, May 08, 2011 at 12:14:04PM +0100, Liam Girdwood wrote:
>> On 08/05/11 11:34, Mark Brown wrote:
> 
>>> I repeat my question - why do you need to check this?  You'll get errors
>>> but you're generating an error anyway so it's not clear what the urgency
>>> is.
> 
>> I think the problem here is that the errors are fatal data aborts here
>> when L3 DSS access is disabled.
> 
> So it'll segfault or something instead of just not transferring data or
> whatever?

Yep, it will cause a CPU data abort exception in this case.

Liam
