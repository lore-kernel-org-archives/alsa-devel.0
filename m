From: Linux Mailing lists account <linux@darykon.cet.com>
Subject: Re: es1869 as sb?
Date: Mon, 29 Apr 2002 07:04:41 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204291404.g3TE4fD08745@dakkon.darykon.cet.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: kasper@303.nu
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday, Apr 26 Kasper Souren wrote:
>
> Hi. I'm trying to get my laptop soundchip, an ES1869 running under ALSA.
> Under OSS it runs as an sb. With "modprobe sb io=0x220 irq=5 dma=1 dma16=5"
> I get:
> 
> SB 3.01 detected OK (220)
> ESS Chip ES1869 detected
> <ESS ES1869 AudioDrive (rev 11) (3.01)> at 0x220 irq 5 dma 1,5

I also have a laptop that has an ESS ES1879 AudioDrive, and could get ALSA to
work. I posted a question/request to this list about 6 weeks ago as well, but
never even got a response back.I gave up and went back to OSS.

I hope you have more luck! Maybe, if you get the ES1869 problem solved, it'll
fix the ES1879 as well! :-)  I wouldn't think that the ALSA developement team
would want to keep around a broken driver.

Gerry Simmons
linux@darykon.cet.com
