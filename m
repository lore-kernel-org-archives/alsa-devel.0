From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ASoC problem
Date: Thu, 15 May 2008 10:41:10 +0100
Message-ID: <1210844470.6297.9.camel@odin>
References: <ddeffb610805142102q5f19d120qd7e73c9babb838d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84AD924751
	for <alsa-devel@alsa-project.org>;
	Thu, 15 May 2008 11:41:12 +0200 (CEST)
In-Reply-To: <ddeffb610805142102q5f19d120qd7e73c9babb838d4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Lu <alanlu001@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2008-05-15 at 12:02 +0800, Alan Lu wrote:
> Hi,
> 
> I built linux-2.6.25.2 kernel with ASoC driver for SMDK2412 board.
>  The following is dmesg,
> 
>   Advanced Linux Sound Architecture Driver Version 1.0.16rc2 (Thu Jan 31
> 16:40:16
> ASoC version 0.13.2
> 
> ALSA device
> list:
>   No soundcards found.
> 
>  I traced the soc_core.c and it never reaches soc_probe() routine.
>  That's why "No soundcards found."
> 
>  Could you give me some light ?
> 

Could you provide a little more information. It would be helpful to know
what codec you are using. I suspect your codec/machine combination is
not fully supported atm.

Liam 
