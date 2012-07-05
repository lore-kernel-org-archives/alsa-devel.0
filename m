From: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: Re: How to handle parameter variation across different boards but
	same platform
Date: Thu, 5 Jul 2012 11:12:32 +0530
Message-ID: <4FF52948.6090904@ti.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
	<20120704131749.GZ4111@opensource.wolfsonmicro.com>
	<1BAFE6F6C881BF42822005164F1491C33EA35456@DBDE01.ent.ti.com>
	<20120704140118.GA4111@opensource.wolfsonmicro.com>
	<1BAFE6F6C881BF42822005164F1491C33EA35B10@DBDE01.ent.ti.com>
	<20120704142745.GC4111@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20120704142745.GC4111-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "alsa-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <alsa-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Girdwood, Liam" <lrg-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



On 7/4/2012 7:57 PM, Mark Brown wrote:
> On Wed, Jul 04, 2012 at 02:17:48PM +0000, Hebbar, Gururaja wrote:
>> On Wed, Jul 04, 2012 at 19:31:18, Mark Brown wrote:
> 
>>> If these are totally different boards they should have different machine
>>> IDs set so machine_is_() should identify.  If that isn't there then you
>>> need to do something custom to your products to identify the boards
>>> further.
> 
>> They are different boards with same SoC (AM33xx). So they both are true for
>> machine_is_am33xx().
> 

What if the device only supports Linux boot from DT, where we set
machine_desc.nr = ~0 ??

Does machine ID still gets set? May be I am missing something...

As part of my debugging, on AM335xEVM platform machine_is_am33xx()
returns false, since the value of machine_desc.nr is set to ~0.

Thanks,
Vaibhav

> That's not how this stuff is supposed to work - machine is the board,
> you should have cpu_is_() for identifying the SoC.
> 
>> We have a means to detect the type of board but in arch/arm/mach-omap2/ 
>> board file. However, I believe it is not recommended to call boards api
>> inside drivers.
> 
> Only for generic drivers, board specific drivers are obviously board
> specific.  The point is that you shouldn't make something that could run
> on many boards depend on an API specific to a particular board.
> 
> 
> 
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 
