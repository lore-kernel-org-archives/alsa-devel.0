From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: Audio driver for dbAu1250 Development board
Date: Sat, 6 Jun 2009 13:13:13 +0200
Message-ID: <20090606131313.07e142f8@scarran.roarinelk.net>
References: <4A2793A6.9090800@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BDB7244F5
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Jun 2009 13:13:15 +0200 (CEST)
In-Reply-To: <4A2793A6.9090800@tataelxsi.co.in>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: manjunatham@tataelxsi.co.in
Cc: alsa-devel@alsa-project.org, "nitinm76 at yahoo.com"@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello!

On Thu, 04 Jun 2009 14:58:06 +0530
Manjunath A M <manjunatham@tataelxsi.co.in> wrote:
> I am trying to make audio up in dbAu1250 Development board, I downloaded 
> linux-2.6.29.4 kernel from the site 
> "http://www.linux-mips.org/pub/linux/mips/kernel/v2.6/ " and
> applied the patch "asoc-v2.6.29-rc8-2009-03-17.patch"downloaded from 
> "http://opensource.wolfsonmicro.com/~git/asoc/"
> but while compiling i am getting the bellow errors
> 
> ********Linux compilation errors*************
> 
> sound/soc/au1x/exmmb-ac97.c:24:38: error: asm/mach-exm1200/exm1200.h: No 

For AC97, I suggest you use the "sound/soc/au1x/sample-ac97.c" driver.
It does work on the DB1200 (and ONLY the db1200).   If you also want
I2S, I posted a set of patches on linux-mips which enhance DB1200
support; among it is a replacement audio machine driver with both AC97
and I2S (selectable through one of the board switches of the S6 group).

	Manuel Lauss
