From: "Pedro I. Sanchez" <psanchez@fosstel.com>
Subject: Re: ASoC: at91sam9260-PCM1808/TAS5709-based board
	driver
Date: Tue, 11 Aug 2009 14:41:57 -0400
Message-ID: <4A81BB75.3070405@fosstel.com>
References: <4A7DB844.3030303@fosstel.com>	
	<9e4733910908090635j29db4ebn64f92c2176f3cb85@mail.gmail.com>
	<9e4733910908090637g4b9eaf19ud1b46de354664df2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from a2s40.a2hosting.com (a2s40.a2hosting.com [74.126.24.200])
	by alsa0.perex.cz (Postfix) with ESMTP id A05B524D4E
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Aug 2009 20:42:29 +0200 (CEST)
In-Reply-To: <9e4733910908090637g4b9eaf19ud1b46de354664df2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you John for the sample code. It's going to be very useful 
specially when I get to the TAS5709 part and the I2C interface.

My next question is with regards to clocking on the SSC interface. The 
PCM1808 in my board has a pretty straight forward connection as follows:

SSC-I/F     PCM1808     Comment
   RF  ---->   LRCK      Frame clock
   RK  ---->   BCK       Bit clock
   RD  <----   DOUT      Digital data

The PCM1808 is hardwired to be in slave mode. The two clock lines are 
expected to be provided by the SoC's SSC interface.

I have the following code in my machine driver to request the SSC 
interface and bind the PCM1808 to it:

         /*
          * Request SSC device
          */
         ssc = ssc_request(0);
         if (IS_ERR(ssc)) {
                 printk(KERN_ERR "ASoC: Failed to request SSC 0\n");
                 ret = PTR_ERR(ssc);
                 ssc = NULL;
                 goto err_ssc;
         }
         ssc_p->ssc = ssc;

What I need to do now is to set the SSC's clock divider to feed the 
PCM1808 with the proper clocking. So these are my next questions:

1. How do I specify in the machine driver that my pcm1808 is hardwired 
to slave mode and that I need bit/frame clocks to be provided by the SSC 
interface?

2. How do I set the SSC's clock divider to provide the right clock signals?

Thanks again,

-- 
Pedro


Jon Smirl wrote:
> On Sun, Aug 9, 2009 at 9:35 AM, Jon Smirl<jonsmirl@gmail.com> wrote:
>> On Sat, Aug 8, 2009 at 1:39 PM, Pedro Sanchez<psanchez@fosstel.com> wrote:
>>> Hello,
>>>
>>> I have to develop a driver for a custom board based on the at91sam9260 with
>>> a PCM1808/TAS5709 chipset combo. I am addressing the PCM1808 first because
>>> it is a simpler device. Since I'm new to ASoC I'm looking for some help in
>>> this list on how to go about writing this driver.
>> I attached a PCM1690 driver I'm currently working on.
> 
> The attached fabric driver show how to use it.
> 
>>
>>> So far I have identified two files that I need to work on (other than the
>>> needed kconfig modifications). First is the codec driver at
>>> sound/soc/codecs/PCM1808.[c|h] which is based on the existent pcm3008
>>> driver; I believe I'm fine with this.
>>>
>>> The second file is the machine driver at sound/soc/atmel/myBoard.c. I'm
>>> using sam9g20_wm8731.c as reference, on which I believe I found a typo which
>>> I reported in a separated e-mail.
>>>
>>> So my first question is, is this two-files step the right approach? am I in
>>> the right track? I'm using the 2.6.30 kernel.
>>>
>>> Other questions will come and I hope I will get some cycles from you to help
>>> me direct my work. Of course I'll be glad to submit my driver work for
>>> inclusion in the kernel if it proves useful.
>>>
>>> Regards,
>>>
>>> --
>>> Pedro
>>>
>>>
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>
>>>
>>
>>
>> --
>> Jon Smirl
>> jonsmirl@gmail.com
>>
> 
> 
> 
