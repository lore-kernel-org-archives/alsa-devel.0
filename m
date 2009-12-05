From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
	CS4270 codec driver
Date: Sat, 5 Dec 2009 03:51:13 +0000
Message-ID: <C8F3ED1D-6FAD-42AD-8036-AC9D41C1CB2C@opensource.wolfsonmicro.com>
References: <20091130165104.GK14091@buzzloop.caiaq.de>
	<1259600171-30357-1-git-send-email-daniel@caiaq.de>
	<20091204120007.GH29442@buzzloop.caiaq.de>
	<20091204120721.GA30155@opensource.wolfsonmicro.com>
	<ed82fe3e0912041854l545a3c9bl7ac790694dadfb07@mail.gmail.com>
	(sfid-20091205_025446_583321_DC66769B)
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 562A8244B2
	for <alsa-devel@alsa-project.org>; Sat,  5 Dec 2009 04:50:57 +0100 (CET)
In-Reply-To: <ed82fe3e0912041854l545a3c9bl7ac790694dadfb07@mail.gmail.com>
	(sfid-20091205_025446_583321_DC66769B)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 5 Dec 2009, at 02:54, Timur Tabi <timur@freescale.com> wrote:

> On Fri, Dec 4, 2009 at 6:07 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Fri, Dec 04, 2009 at 01:00:07PM +0100, Daniel Mack wrote:
>>> Was that one applied?
>>
>> No, need review from Timur still.
>
> Wait, I'm confused.  I thought the patch didn't work at all and Daniel
> rescinded it.

Yes, but then he posted a new revision which didn't try to turn off  
the analogue supply seperately which ought to work.
