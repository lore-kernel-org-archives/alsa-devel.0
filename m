From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: 2.6.34-rc1: regression: ^Z no longer stops sound
Date: Sun, 14 Mar 2010 17:20:13 -0400
Message-ID: <hnjjud$k26$1@dough.gmane.org>
References: <20100314075831.GA13457@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100314075831.GA13457@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pavel Machek wrote:
> Hi!
> 
> In 2.6.33, hitting ^Z stopped mpg123 in a way you'd expect (both on
> thinkpad and geode notebook).
> 
> On 2.6.34-rc1, hit ^Z and sound starts looping.
> 									Pavel
That's not new, I have seen it back as far as 2.6.27.25 doing a suspend in a VM 
(KVM, no libvirt). But it only happens a few times a year, so I never chased it. 
I hate to report an occasional problem in an obsolete kernel, and I can't 
reproduce it.

Does it happen repeatably with the new kernel?

-- 
Bill Davidsen <davidsen@tmr.com>
   "We have more to fear from the bungling of the incompetent than from
the machinations of the wicked."  - from Slashdot
