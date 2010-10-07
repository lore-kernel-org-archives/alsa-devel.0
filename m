From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Headphone jack and auto-mute of speak output
Date: Thu, 07 Oct 2010 18:03:43 +0200
Message-ID: <4CADEF5F.7070600@canonical.com>
References: <AANLkTi=ZhMVY1abcpxviy50yfSbdc1vABCtKa9jJXfig@mail.gmail.com>
	<AANLkTim-R=FGHo-CxT=gxysisTRT3T35pyrfu7HscKAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B8C7244FB
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 18:03:43 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1P3swX-0005kd-57
	for <alsa-devel@alsa-project.org>; Thu, 07 Oct 2010 17:03:41 +0100
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.102]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1P3swX-0001HY-0r
	for alsa-devel@alsa-project.org; Thu, 07 Oct 2010 17:03:41 +0100
In-Reply-To: <AANLkTim-R=FGHo-CxT=gxysisTRT3T35pyrfu7HscKAQ@mail.gmail.com>
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

On 2010-10-07 15:43, Raymond Yau wrote:
> 2010/10/7 Davyd McColl<davydm@gmail.com>
>
>> Good day
>>
>> I'm new to this list (though I've done some searching, I'm sure I could
>> have
>> missed something), so please bear with me.
>>
>> I filed a bug report recently against Ubuntu with respect to the problem
>> I'm
>> experiencing (as per the subject: jacking in my headphones doesn't mute the
>> speaker output) and was informed that the decision had been made upstream
>> as
>> a design intention. I was linked off to:
>>
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-August/030071.html
>> with respect to the thread on this topic. I'd like to raise it again
>> though,
>> perhaps as a configurable feature, for the following reasons:
>>
>
> Enable auto-muting in model=auto only for devices with HP and speakers.
>
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=2a2ed0dfc9ec44a899c7d4672f73f2c045099118;hp=299f293b3428ae6d73406642cd7d41f08d524c83
>
>
> if the bios set your laptop 's speaker as line out , you need to implement a
> new model for your laptop ,

Can't you just override the pin config (via user_pin_configs in sysfs, 
or a patch file) in this case?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
