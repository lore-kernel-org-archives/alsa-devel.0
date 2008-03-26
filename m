From: Oliver Ford <ipaqlinux@oliford.co.uk>
Subject: Re: PXA2xx/3xx AC97 Driver(s)
Date: Wed, 26 Mar 2008 13:52:39 +0000
Message-ID: <47EA5527.9050201@oliford.co.uk>
References: <47E7A0A8.3010200@oliford.co.uk>
	<20080324134231.GA30281@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20080324134231.GA30281@sirena.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Oliver Ford <ipaqlinux@oliford.co.uk>, linux-arm-kernel@lists.arm.linux.org.uk, alsa-devel@alsa-project.org
Cc: alex.meakins@gmail.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> There is PXA3xx AC97 support present in the ASoC tree:
>
>    git://opensource.wolfsonmicro.com/linux-2.6-asoc
>
> It's under the asoc-v2-dev branch at the minute
>
After a few hours of learning what git is and how to find and fetch that
branch I've got it.
I'm now using the whole kernel from there and have applied my patches
for the Ipaq214 to it. The Pxa2xx driver (with 3xx support) happily
talks down the AC97 bus now. The sound isn't working yet as I've still
got to set up the platform definition file properly.

> All the ARM architecture changes have been submitted and marked as
> applied in the patch system so should hopefully appear in Linus' kernel
> early in the 2.6.26 cycle.  Once this has happened I will submit the
> AC97 driver PXA3xx support.
>   
The machine no longer reboots out of linux though. I assume there were
some changes in 2.6.25-rc4 mainline that aren't in the asoc-v2-dev yet.
I will wait for the pxa3xx stuff to be merged into the mainline for
this. What version of the mainline kernel is the latest asoc-v2-dev
branch based on. (I'm still a little hazy on the git stuff I'm afraid).
>> I want to get the touch screen working on my iPAQ 214, which uses the 
>> PXA310. It's a WM97xx chip on the AC97 interface. I'm not really too 
>>     
>
> I know that there are a number of users currently using the tree for
> that use case so the asoc-v2-dev branch should hopefully work for you.
> If you run into trouble please let me know.
>   
The WM97xx touchscreen driver only appears to be in the linux-2.6-touch
repository (dev branch, iirc), rather than  linux-2.6-asoc where the
pxa3xx support is. Since I want both the wm97xx touchscreen and pxa3xx
support, is there a simple way I can get the necessary changes in one
applied to the other?

Thanks,

Oliver



-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
