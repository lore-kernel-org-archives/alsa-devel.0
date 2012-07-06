From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [alsa-devel] DT support for Davinci ASoC platform
Date: Fri, 6 Jul 2012 18:42:36 +0530
Message-ID: <4FF6E444.1050901@ti.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA35352@DBDE01.ent.ti.com>
	<4FF5733E.6000604@gmail.com> <201207051536.45920.arnd@arndb.de>
	<4FF5BB34.9070002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4FF5BB34.9070002-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "alsa-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <alsa-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Girdwood, Liam" <lrg-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

On 7/5/2012 9:35 PM, Daniel Mack wrote:
> On 05.07.2012 17:36, Arnd Bergmann wrote:
>> On Thursday 05 July 2012, Daniel Mack wrote:
>>> On 04.07.2012 14:48, Hebbar, Gururaja wrote:
>>>> All,
>>>>
>>>> Are there any plans or work going on for providing Device Tree Support for Davinci
>>>> ASoC?
>>>>
>>>> I am planning to add DT support for TI AM335x (McASP) and I don't want to do duplicate
>>>> task.
>>>
>>> That's good to know. But isn't there a dependency on the EDMA engine? Is
>>> that part ported yet?
>>
>> None of the dma engines are ported yet, because the generic binding for dma
>> engines is still under debate. So far, all DMA channels are described using
>> auxdata on platforms that use DT, with the exception of exynos, but that one
>> will have to change once we have the common code.
> 
> You're talking about the DT bindings here, right? But the code itself is
> also only present in TI's BSP kernel sources, and not in mainline.

AM335x uses TI EDMA which is present in mainline under mach-davinci.
Matt Porter from TI is working on moving this to DMA engine. Once that's
done the driver should be usable on AM335x too. Have a look at the wiki
page Vaibhav posted under the thread "Current state of AM33xx patches"

Thanks,
Sekhar
