From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: User space drivers
Date: Fri, 03 Aug 2007 01:04:24 +0100
Message-ID: <46B27108.1000409@superbug.co.uk>
References: <C7A98C6EB85FFF4FAE03BD695D68EC7601239680@NAEX05.na.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net
	[194.217.242.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 685E0103886
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Aug 2007 02:04:26 +0200 (CEST)
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

Wallace, Brooke wrote:
> Hi,
>  
> I've been trying to sort thru the ALSA docs and am starting to get the
> impression that all of the existing drivers are written as Kernel
> Modules. Doesn't this mean that they are running in Kernel space and
> infact are not User Space drivers? Shouldn't there be an ALSA Drivers
> API document that covers an API that User Space Drivers can use? I must
> be mssing something here...
>  
> I'm looking into ALSA because my company wants to use this standard for
> writing User Space drivers for our product running on various linux
> kernels. The reasoning for this is strictly proprietary licensing - our
> leagl department is not comfortable with the GPL and the possiblitiy
> that something written for Kernel space could at some time be considered
> as required to be GPL - not my decision...
>  
> -Brooke
>  

Brooke,

What is the problem? Just license your driver as GPL. Result, no more 
legal problems.
The advantage of this approach is that you then get to use your device 
with Linux. Alternatives along the lines of what you are considering are 
not worth the effort by yourselves, and certainly not worth our effort 
helping you.

Kind Regards

James
