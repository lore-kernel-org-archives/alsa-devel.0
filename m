From: Simos Xenitellis <simos.lists@googlemail.com>
Subject: Re: OFFTOPIC atkbd.c: Use 'setkeycodes... (Was: Re: My
	Codec: IDT 92HD75B3X5 issues)
Date: Fri, 2 Oct 2009 17:24:10 +0300
Message-ID: <598e9210910020724n6daee6b0hf31be5cb3a8bcf70@mail.gmail.com>
References: <598e9210910020512j67cfad99i7369bbd34228f3c0@mail.gmail.com>
	<20091002124112.GA2553@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f192.google.com (mail-yw0-f192.google.com
	[209.85.211.192])
	by alsa0.perex.cz (Postfix) with ESMTP id 66DCA244BB
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 16:24:31 +0200 (CEST)
Received: by ywh30 with SMTP id 30so850714ywh.23
	for <alsa-devel@alsa-project.org>; Fri, 02 Oct 2009 07:24:30 -0700 (PDT)
In-Reply-To: <20091002124112.GA2553@tango.0pointer.de>
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

On Fri, Oct 2, 2009 at 3:41 PM, Lennart Poettering <mznyfn@0pointer.de> wrote:
> On Fri, 02.10.09 15:12, Simos Xenitellis (simos.lists@googlemail.com) wrote:
>
>> Those keys are a 'HAL' thing. Until recently there has been a website
>> by the HAL developer
>> with detailed instructions. Search for 'HAL Quirk Site' on Google to
>> view the site in Google cache.
>> The website was not updated for some time
>> (http://www.mail-archive.com/pm-utils@lists.freedesktop.org/msg01594.html)
>> and being obsolete, it was probably taken down.
>> Your changes would need to make it eventually to the hal-info repository,
>> http://cgit.freedesktop.org/hal-info/
>> Use the Freedesktop Bugzilla, product 'hal' and component 'hal-info'
>> when reporting,
>> https://bugs.freedesktop.org/enter_bug.cgi?product=hal
>
> That is actually no true anymore. HAL is dead and the keycode stuff
> has been moved to udev:
>
> http://git.kernel.org/?p=linux/hotplug/udev.git;a=tree;f=extras/keymap/keymaps

Oh, thanks for these.
I'll update my tune.

Cheers,
Simos
