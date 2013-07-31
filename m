From: Olof Johansson <olof@lixom.net>
Subject: Re: New dapm panic on beaver with next-20130730
Date: Tue, 30 Jul 2013 23:13:52 -0700
Message-ID: <CAOesGMjqyF7zPoGsW6oBRFey7Bc_umnoGob7oQ=_c3n7oevuaQ@mail.gmail.com>
References: <CAOesGMig6jry1GJLoTnOqxom1KjtBTUtZz-_-SiZLpGTc3VkqA@mail.gmail.com>
 <51F8A933.4080708@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f47.google.com (mail-qe0-f47.google.com
 [209.85.128.47])
 by alsa0.perex.cz (Postfix) with ESMTP id DB8B92610A1
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 08:13:52 +0200 (CEST)
Received: by mail-qe0-f47.google.com with SMTP id b10so167728qen.20
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2013 23:13:52 -0700 (PDT)
In-Reply-To: <51F8A933.4080708@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 30, 2013 at 11:05 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 07/31/2013 07:36 AM, Olof Johansson wrote:
>>
>> Hi Mark, Lars-Peter,
>>
>> I noticed the below panic on beaver (Tegra30). Seems like seaboard
>> (Tegra20) is fine. This is with next-20130730, tegra_defconfig.
>
>
> Hi,
>
> So the same machine driver with the same codec works on tegra2, but not on
> tegra3? The crash doesn't seem to be directly related to the patch, but the
> patch changed the memory layout. Is it possible that you still have a
> outdated module that's being loaded on your tegra3 board?

Sorry, I should have been cleared on that. Not at all the same codec,
seaboard uses wm8903, beaver rt5640.

> Can you add a few debugging printks and run the test again and paste the
> last few lines before the crash:

[beaver          00:18] [    4.045897] dapm_generic_check_power: IF2 ADC L
[beaver          00:18] [    4.050417] dapm_clear_walk_output 1: ee3a7bc0
[beaver          00:18] [    4.054845] dapm_generic_check_power: IF2 DAC
[beaver          00:18] [    4.059193] dapm_clear_walk_output 1: ee3a8240
[beaver          00:18] [    4.063621] dapm_clear_walk_output 1: ee3a8280
[beaver          00:18] [    4.068048] dapm_generic_check_power: IF1 ADC R
[beaver          00:18] [    4.072661] dapm_clear_walk_output 1: ee3a7c40
[beaver          00:18] [    4.077091] dapm_generic_check_power: IF1 ADC L
[beaver          00:18] [    4.081616] dapm_clear_walk_output 1: ee3a7c80
[beaver          00:18] [    4.086045] dapm_generic_check_power: IF1 DAC
[beaver          00:18] [    4.090394] dapm_clear_walk_output 1: ee3a82c0
[beaver          00:18] [    4.094821] dapm_clear_walk_output 1: ee3a8300
[beaver          00:18] [    4.099256] dapm_generic_check_power: INR Mux
[beaver          00:18] [    4.103599] dapm_clear_walk_output 1: ee3af670
[beaver          00:18] [    4.108026] dapm_generic_check_power: INL Mux
[beaver          00:18] [    4.112375] dapm_clear_walk_output 1: ee3af5f0
[beaver          00:18] [    4.116802] dapm_clear_walk_output 2: 6b6b6b6b
[beaver          00:18] [    4.121246] Unable to handle kernel paging
request at virtual address 6b6b6b6f
[beaver          00:18] [    4.128449] pgd = c0004000
[beaver          00:18] [    4.131151] [6b6b6b6f] *pgd=00000000
[beaver          00:18] [    4.134723] Internal error: Oops: 5 [#1]
PREEMPT SMP ARM
