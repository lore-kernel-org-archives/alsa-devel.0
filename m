From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH 1/7] ak4114 - fix errors in output selector
	bits
Date: Wed, 16 Sep 2009 09:00:59 +0200
Message-ID: <4AB08D2B.5070604@ivitera.com>
References: <1253054396-7978-1-git-send-email-pavel.hofman@ivitera.com>
	<s5hbplbzarg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id BF19524151
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Sep 2009 09:00:39 +0200 (CEST)
In-Reply-To: <s5hbplbzarg.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 16 Sep 2009 00:39:50 +0200,
> pavel.hofman@ivitera.com wrote:
>> From: Pavel Hofman <pavel.hofman@ivitera.com>
>>
>>
>> Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>
> 
> Could you describe *what* are exactly fixed?
> Do these change influence on any driver behavior?

It is just a fix - the original version had a typo - see the equal
values for
AK4114_OPS12 = AK4114_OPS02
AK4114_OPS11 = AK4114_OPS01
AK4114_OPS10 = AK4114_OPS00

Since no cards actually use this feature, the bug was not uncovered earlier.

Thanks,

Pavel.

> 
> 
> thanks,
> 
> Takashi
> 
>> diff --git a/include/ak4114.h b/include/ak4114.h
>> index d293d36..3ce69fd 100644
>> --- a/include/ak4114.h
>> +++ b/include/ak4114.h
>> @@ -95,13 +95,13 @@
>>  
>>  /* AK4114_REG_IO0 */
>>  #define AK4114_TX1E		(1<<7)	/* TX1 Output Enable (1 = enable) */
>> -#define AK4114_OPS12		(1<<2)	/* Output Though Data Selector for TX1 pin */
>> -#define AK4114_OPS11		(1<<1)	/* Output Though Data Selector for TX1 pin */
>> -#define AK4114_OPS10		(1<<0)	/* Output Though Data Selector for TX1 pin */
>> +#define AK4114_OPS12		(1<<6)	/* Output Data Selector for TX1 pin */
>> +#define AK4114_OPS11		(1<<5)	/* Output Data Selector for TX1 pin */
>> +#define AK4114_OPS10		(1<<4)	/* Output Data Selector for TX1 pin */
>>  #define AK4114_TX0E		(1<<3)	/* TX0 Output Enable (1 = enable) */
>> -#define AK4114_OPS02		(1<<2)	/* Output Though Data Selector for TX0 pin */
>> -#define AK4114_OPS01		(1<<1)	/* Output Though Data Selector for TX0 pin */
>> -#define AK4114_OPS00		(1<<0)	/* Output Though Data Selector for TX0 pin */
>> +#define AK4114_OPS02		(1<<2)	/* Output Data Selector for TX0 pin */
>> +#define AK4114_OPS01		(1<<1)	/* Output Data Selector for TX0 pin */
>> +#define AK4114_OPS00		(1<<0)	/* Output Data Selector for TX0 pin */
>>  
>>  /* AK4114_REG_IO1 */
>>  #define AK4114_EFH1		(1<<7)	/* Interrupt 0 pin Hold */
>> -- 
>> 1.5.6.3
>>

-- 

IVITERA a.s., www.ivitera.com
Kafkova 16, 160 00 Praha 6
Rubesova 29, 326 00 Plzen
Czech Republic

Mobil +420 603 163 973
Tel.  +420 377 449 358
Fax   +420 222 745 553
pavel.hofman@ivitera.com


www.educity.cz   www.jobcity.cz
www.meetings.cz   www.hrzive.cz
www.zamestnaneckevyhody.cz
www.comben.cz

--------------------------------
Navstivte nejvetsi nabidku kurzu a skoleni
na ceskem internetu www.educity.cz,
nejvetsi vyber prostor pro firemni akce www.meetings.cz
a www.jobcity.cz s nabidkami lepsi prace.
