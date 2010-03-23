From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 2.6.34-rc1: regression: ^Z no longer stops sound
Date: Tue, 23 Mar 2010 15:08:51 +0100
Message-ID: <4BA8CB73.80400@ladisch.de>
References: <20100314075831.GA13457@elf.ucw.cz> <hnjjud$k26$1@dough.gmane.org>
	<20100323135942.GB1703@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de
	[80.67.29.23]) by alsa0.perex.cz (Postfix) with ESMTP id 2956F243B0
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2010 15:08:57 +0100 (CET)
In-Reply-To: <20100323135942.GB1703@ucw.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: alsa-devel@alsa-project.org, Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Pavel Machek wrote:
> On Sun 2010-03-14 17:20:13, Bill Davidsen wrote:
>> Pavel Machek wrote:
>>> In 2.6.33, hitting ^Z stopped mpg123 in a way you'd expect (both on
>>> thinkpad and geode notebook).
>>>
>>> On 2.6.34-rc1, hit ^Z and sound starts looping.
>>
>> That's not new, I have seen it back as far as 2.6.27.25 doing a suspend 
>> in a VM (KVM, no libvirt). But it only happens a few times a year, so I 
>> never chased it. I hate to report an occasional problem in an obsolete 
>> kernel, and I can't reproduce it.
>>
>> Does it happen repeatably with the new kernel?
> 
> It happened reliably so far, yes.

This sounds as if the device has been configured to ignore underruns.
What are the contents of /proc/asound/card0/pcm0p/sub0/{sw_params,status}
when it's looping, and when it's really suspended?


Regards,
Clemens
