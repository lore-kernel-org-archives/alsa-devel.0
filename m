From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/6] ARM: ux500: Enable HIGHMEM on all
	mop500 platforms
Date: Tue, 31 Jul 2012 15:37:32 +0100
Message-ID: <20120731143732.GS6802@n2100.arm.linux.org.uk>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-10-git-send-email-lee.jones@linaro.org>
 <20120731135614.GR6802@n2100.arm.linux.org.uk> <5017EBDC.6010005@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id A8CA6265D1D
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 16:37:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5017EBDC.6010005@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 31, 2012 at 03:29:48PM +0100, Lee Jones wrote:
> On 31/07/12 14:56, Russell King - ARM Linux wrote:
>> On Tue, Jul 31, 2012 at 02:31:30PM +0100, Lee Jones wrote:
>>> The current kernel commandline for ux500 based devices includes
>>> hard-coded allocations for things like mali and hwmem, which
>>> actually run over lowmem. Here we enable highmem in order to
>>> avoid memory corruption errors.
>>
>> Err what?  highmem should make no difference if things are being done
>> correctly.
>>
>> In other words, your patch description is too vague to understand what
>> the problem is and why you have to force highmem on - and nothing should
>> _require_ highmem.
>
> I think I must have misunderstood some advice which was recently given  
> to me. I'll drop the patch.
>
> Thanks for reviewing.

There are two reasons for not doing this:

1. it is wrong to force core optional features on by using 'select'
2. it is wrong to use 'select' on user visible symbols because it creates
   confusion, and prevents the user from disabling the option.

Note that highmem is just a hack to make larger memory systems work before
64-bit systems happen - it is _known_ to make systems unstable with large
amounts of highmem (even on x86) due to the requirement to have a certain
amount of metadata stored in lowmem.

Nothing should ever force anyone to have highmem enabled.

I still fail to see how not having highmem enabled would ever cause memory
corruption errors (unless something dealing with memory in a very very
wrong way - iow, not using one of the reservation or memory allocation
methods provided by the kernel.)
