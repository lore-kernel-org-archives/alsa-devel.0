From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: i.MX audio support
Date: Thu, 19 Nov 2009 18:32:30 +0000
Message-ID: <BBD75ED1-D1F8-421B-8B62-17C786975733@opensource.wolfsonmicro.com>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<20091119163241.GB31336@rakim.wolfsonmicro.main>
	<20091119174755.GU30179@pengutronix.de>
	(sfid-20091119_174902_751652_79B3A281)
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AE07110380B
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2009 19:32:27 +0100 (CET)
In-Reply-To: <20091119174755.GU30179@pengutronix.de>
	(sfid-20091119_174902_751652_79B3A281)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 19 Nov 2009, at 17:47, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> On Thu, Nov 19, 2009 at 04:32:41PM +0000, Mark Brown wrote:
>> On Thu, Nov 19, 2009 at 04:48:14PM +0100, Sascha Hauer wrote:
>>
>>> There already is a driver for i.MX in the tree, this one is a  
>>> nearly complete
>>> rewrite. I haven't touched the in Kernel driver with these  
>>> patches. The in
>>> Kernel driver has several problems, it doesn't use ioremap, uses  
>>> direct pointer
>>> derefs instead of proper access functions and the only board  
>>> supported so far is
>>> itself not supported in mainline.
>>
>> BTW, unless I notice anything particularly bad in there I'm  
>> inclined to
>> just merge all the arch/arm patches by themselves since obviously  
>> you're
>> the maintainer they'd normally go via - I'm assuming the other  
>> patches
>> depend on them?
>
> I'd prefer merging the arm patches myself as I'm afraid of bothering
> upstream upstream with merge conflicts. I think I can rebase this  
> series
> in a way that there won't be compile breakages during merge.

Please do say when you're submitting if this is you're intention - if  
you just send me patches without any other comment I'll tend to assume  
that your intention is that I should apply them and go ahead and do so  
if they review OK. Merging via ARM is OK providing the build doesn't  
get broken. If that happens we can do the same thing as has been done  
with TWL4030 and merge a branch into both trees.
