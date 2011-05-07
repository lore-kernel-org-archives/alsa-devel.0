From: preetam <preetamsashankreddy@gmail.com>
Subject: Re: aplay throws error
Date: Sat, 07 May 2011 22:57:06 +0530
Message-ID: <4DC580EA.9030802@gmail.com>
References: <4DC4F447.4040607@gmail.com>
	<20110507142934.GD13216@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EFDA244FD
	for <alsa-devel@alsa-project.org>;
	Sat,  7 May 2011 19:27:19 +0200 (CEST)
Received: by pxi19 with SMTP id 19so2806038pxi.29
	for <alsa-devel@alsa-project.org>; Sat, 07 May 2011 10:27:18 -0700 (PDT)
In-Reply-To: <20110507142934.GD13216@qtel.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Saturday 07 May 2011 07:59 PM, Lu Guanqun wrote:
> On Sat, May 07, 2011 at 03:27:03PM +0800, preetam wrote:
>> Hai,
>>
>> My aplay throws the following error:
>>
>> Playing WAVE 'Linkin Park - New divide.wav' : Signed 16 bit Little
>> Endian, Rate 44100 Hz, Stereo
>> aplay: aplay.c:1029: set_params: Assertion `err>= 0' failed.
> Hi,
>
> What's your version of alsa-utils?
> I don't see the assert(err>= 0) on line 1029 on the latest repository
> code.
>
> Well, if this utilizes your newly written driver, I would suggest you
> insert some logs in your hw_params callback in driver. It might actually
> be your driver's mis-behavour.
>
> I'm not an expert on alsa, so it's just my 2 cents...
>
>> Aborted by signal Aborted...
>>
>>
>> I am using a pandaboard. Kernel is 2.6.35 from omap tree L27.11.1.
>>
>> I am new to alsa and I have written an soc driver for this.
>> can anyone help me.
>>
>> I can only trace the function calls to alloca. I am blank from here on.
>>
>> Regards,
>> Preetam
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
Hai,

I dont know how to check the alsa-utils version. Its part of android 
gingerbread source tree.
There is also an ambiguousness as to whether its a problem with 
hw_params or sw_params function.
Is there any way I can use something as simple as ctags with vim in 
android source tree?

Is there any updated documentation for starters in alsa soc for the new 
pandaboard 2.6.35 kernel?
I want to learn and master, but I am only getting information in bits 
and pieces.

Regards,
Preetam
