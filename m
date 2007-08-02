From: Rene Herman <rene.herman@gmail.com>
Subject: Re: User space drivers
Date: Fri, 03 Aug 2007 01:25:08 +0200
Message-ID: <46B267D4.3040702@gmail.com>
References: <C7A98C6EB85FFF4FAE03BD695D68EC7601239680@NAEX05.na.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id DE85C103863
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Aug 2007 01:27:52 +0200 (CEST)
In-Reply-To: <C7A98C6EB85FFF4FAE03BD695D68EC7601239680@NAEX05.na.qualcomm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Wallace, Brooke" <brookew@qualcomm.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/02/2007 11:39 PM, Wallace, Brooke wrote:

> I've been trying to sort thru the ALSA docs and am starting to get the 
> impression that all of the existing drivers are written as Kernel 
> Modules.

Yes. Some stuff like mixing happens in userspace but the lowlevel drivers 
are in kernel space.

> Doesn't this mean that they are running in Kernel space and infact are
> not User Space drivers?

Yes.

> Shouldn't there be an ALSA Drivers API document that covers an API that
> User Space Drivers can use? I must be mssing something here...

I believe you are. Who told you that ALSA drivers ran in userspace?

> I'm looking into ALSA because my company wants to use this standard for 
> writing User Space drivers for our product running on various linux 
> kernels. The reasoning for this is strictly proprietary licensing - our 
> leagl department is not comfortable with the GPL and the possiblitiy that
> something written for Kernel space could at some time be considered as
> required to be GPL - not my decision...

You have a sensible legal department. Many hold that distributing Linux 
kernelspace code under a non GPL compatible license is illegal, period.

Your job, should you chose to accept it, is convince them that releasing the 
code you will be writing under a GPL compatible license is not actually all 
that scary. Pointing them to all the other companies that do so can help.

The other option you have is make do without _any_ help from _anyone_ on 
this list at least. Good luck.

Rene.
