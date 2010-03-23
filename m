From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.34-rc1: regression: ^Z no longer stops sound
Date: Tue, 23 Mar 2010 14:59:43 +0100
Message-ID: <20100323135942.GB1703@ucw.cz>
References: <20100314075831.GA13457@elf.ucw.cz> <hnjjud$k26$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (ksp.mff.cuni.cz [195.113.26.206])
	by alsa0.perex.cz (Postfix) with ESMTP id B8F1324350
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2010 14:59:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <hnjjud$k26$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bill Davidsen <davidsen@tmr.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun 2010-03-14 17:20:13, Bill Davidsen wrote:
> Pavel Machek wrote:
>> Hi!
>>
>> In 2.6.33, hitting ^Z stopped mpg123 in a way you'd expect (both on
>> thinkpad and geode notebook).
>>
>> On 2.6.34-rc1, hit ^Z and sound starts looping.
>> 									Pavel
> That's not new, I have seen it back as far as 2.6.27.25 doing a suspend 
> in a VM (KVM, no libvirt). But it only happens a few times a year, so I 
> never chased it. I hate to report an occasional problem in an obsolete 
> kernel, and I can't reproduce it.
>
> Does it happen repeatably with the new kernel?

It happened reliably so far, yes.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
