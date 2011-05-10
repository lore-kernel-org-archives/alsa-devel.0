From: preetam <preetamsashankreddy@gmail.com>
Subject: Re: aplay throws error
Date: Tue, 10 May 2011 10:31:36 +0530
Message-ID: <4DC8C6B0.8080300@gmail.com>
References: <4DC4F447.4040607@gmail.com>
	<20110507142934.GD13216@qtel.sh.intel.com>
	<4DC580EA.9030802@gmail.com>
	<20110509003128.GA6952@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 54AFA243B8
	for <alsa-devel@alsa-project.org>;
	Tue, 10 May 2011 07:01:51 +0200 (CEST)
Received: by pvf33 with SMTP id 33so3203593pvf.38
	for <alsa-devel@alsa-project.org>; Mon, 09 May 2011 22:01:47 -0700 (PDT)
In-Reply-To: <20110509003128.GA6952@qtel.sh.intel.com>
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

On Monday 09 May 2011 06:01 AM, Lu Guanqun wrote:
> On Sun, May 08, 2011 at 01:27:06AM +0800, preetam wrote:
>> On Saturday 07 May 2011 07:59 PM, Lu Guanqun wrote:
>>> On Sat, May 07, 2011 at 03:27:03PM +0800, preetam wrote:
>>>> Hai,
>>>>
>>>> My aplay throws the following error:
>>>>
>>>> Playing WAVE 'Linkin Park - New divide.wav' : Signed 16 bit Little
>>>> Endian, Rate 44100 Hz, Stereo
>>>> aplay: aplay.c:1029: set_params: Assertion `err>= 0' failed.
>>> Hi,
>>>
>>> What's your version of alsa-utils?
>>> I don't see the assert(err>= 0) on line 1029 on the latest repository
>>> code.
>>>
>>> Well, if this utilizes your newly written driver, I would suggest you
>>> insert some logs in your hw_params callback in driver. It might actually
>>> be your driver's mis-behavour.
>>>
>>> I'm not an expert on alsa, so it's just my 2 cents...
>>>
>>>> Aborted by signal Aborted...
>>>>
>>>>
>>>> I am using a pandaboard. Kernel is 2.6.35 from omap tree L27.11.1.
>>>>
>>>> I am new to alsa and I have written an soc driver for this.
>>>> can anyone help me.
>>>>
>>>> I can only trace the function calls to alloca. I am blank from here on.
>>>>
>>>> Regards,
>>>> Preetam
>>>> _______________________________________________
>>>> Alsa-devel mailing list
>>>> Alsa-devel@alsa-project.org
>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> Hai,
>>
>> I dont know how to check the alsa-utils version. Its part of android
>> gingerbread source tree.
>> There is also an ambiguousness as to whether its a problem with
>> hw_params or sw_params function.
>> Is there any way I can use something as simple as ctags with vim in
>> android source tree?
>>
>> Is there any updated documentation for starters in alsa soc for the new
>> pandaboard 2.6.35 kernel?
> Hi,
>
> I'm not familar with pandaboard, not sure whether there's any
> documentation for this.
>
>> I want to learn and master, but I am only getting information in bits
>> and pieces.
assert(err>=0) is present in the aplay code at 1029 line. I myself am 
unable find it. However, when I give, apla -F100 <song.wav> the error is 
gone. But no audio is heard.

Regards,
Preetam
