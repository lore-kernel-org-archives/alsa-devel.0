From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH v5] ASoC/2.6.37: fix au1x platform
Date: Fri, 10 Sep 2010 17:00:52 +0200
Message-ID: <AANLkTim9YRNtYuZeSJP2ffj1tiLjs=yL54XV9n+wTgDs@mail.gmail.com>
References: <1282827231-17323-1-git-send-email-manuel.lauss@googlemail.com>
	<20100831110115.GC20849@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 029CC24454
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 17:00:53 +0200 (CEST)
Received: by ywg8 with SMTP id 8so1279955ywg.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2010 08:00:53 -0700 (PDT)
In-Reply-To: <20100831110115.GC20849@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello Mark, Liam

On Tue, Aug 31, 2010 at 1:01 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Aug 26, 2010 at 02:53:51PM +0200, Manuel Lauss wrote:
>> This patch fixes up the au1x audio platform after the multi-component
>> merge:
>> - compile fixes and updates to get DB1200 platform audio working again,
>> - removal of global variables in AC97/I2S/DMA(PCM) modules.
>>
>> The AC97 part is limited to one instance only for now due to issues
>> with getting at driver data in the soc_ac97_ops.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
>
> Applied, thanks - we can work on fixing up the remaining issues with
> AC'97 incrementally.

Here's a snippet of the kernel log with linked-list debugging enabled.
Looks like the list issue Liam fixed ~1.5 years ago:
( see http://mailman.alsa-project.org/pipermail/alsa-devel/2009-February/014757.html
)


AC97 SoC Audio Codec 0.6
asoc: ac97-hifi <-> au1xpsc_ac97.1 mapping ok
kobject (8f798da0): tried to init an initialized object, something is
seriously wrong.
Call Trace:
[<801082d8>] dump_stack+0x8/0x34
[<802d2bf0>] kobject_init+0xc4/0xd4
[<80310758>] device_initialize+0x2c/0x70
[<803110ac>] device_register+0x14/0x28
[<803d1ab4>] snd_soc_instantiate_cards+0xa60/0xbc0
[<803d1d50>] soc_probe+0x13c/0x154
[<80313970>] driver_probe_device+0xc4/0x204
[<80312b90>] bus_for_each_drv+0x68/0xd0
[<80313cd4>] device_attach+0xc0/0xfc
[<80312928>] bus_probe_device+0x38/0x54
[<80310fd8>] device_add+0x4b8/0x578
[<8031560c>] platform_device_add+0x12c/0x24c
[<8060da40>] db1200_audio_load+0x78/0xa4
[<8010aa40>] do_one_initcall+0x40/0x1e8
[<805fb338>] kernel_init+0xd4/0x174
[<8010e734>] kernel_thread_helper+0x10/0x18

------------[ cut here ]------------
WARNING: at /home/mano/db1200/kernel/linux-2.6.git/lib/list_debug.c:30
__list_add+0xa8/0xb0()
list_add corruption. prev->next should be next (8fe44fa8), but was
8f7eefc4. (prev=8f7eefc4).
Modules linked in:
Call Trace:
[<801082d8>] dump_stack+0x8/0x34
[<8012a2dc>] warn_slowpath_common+0x78/0xa4
[<8012a390>] warn_slowpath_fmt+0x2c/0x38
[<802e046c>] __list_add+0xa8/0xb0
[<80312b18>] bus_add_device+0x1d4/0x1e4
[<80310f88>] device_add+0x468/0x578
[<803d1ab4>] snd_soc_instantiate_cards+0xa60/0xbc0
[<803d1d50>] soc_probe+0x13c/0x154
[<80313970>] driver_probe_device+0xc4/0x204
[<80312b90>] bus_for_each_drv+0x68/0xd0
[<80313cd4>] device_attach+0xc0/0xfc
[<80312928>] bus_probe_device+0x38/0x54
[<80310fd8>] device_add+0x4b8/0x578
[<8031560c>] platform_device_add+0x12c/0x24c
[<8060da40>] db1200_audio_load+0x78/0xa4
[<8010aa40>] do_one_initcall+0x40/0x1e8
[<805fb338>] kernel_init+0xd4/0x174
[<8010e734>] kernel_thread_helper+0x10/0x18

---[ end trace 8e74e4819d0d06c3 ]---
------------[ cut here ]------------
WARNING: at /home/mano/db1200/kernel/linux-2.6.git/lib/list_debug.c:30
__list_add+0xa8/0xb0()
list_add corruption. prev->next should be next (8f788f90), but was
8f7eefa4. (prev=8f7eefa4).
Modules linked in:
Call Trace:
[<801082d8>] dump_stack+0x8/0x34
[<8012a2dc>] warn_slowpath_common+0x78/0xa4
[<8012a390>] warn_slowpath_fmt+0x2c/0x38
[<802e046c>] __list_add+0xa8/0xb0
[<80310ff0>] device_add+0x4d0/0x578
[<803d1ab4>] snd_soc_instantiate_cards+0xa60/0xbc0
[<803d1d50>] soc_probe+0x13c/0x154
[<80313970>] driver_probe_device+0xc4/0x204
[<80312b90>] bus_for_each_drv+0x68/0xd0
[<80313cd4>] device_attach+0xc0/0xfc
[<80312928>] bus_probe_device+0x38/0x54
[<80310fd8>] device_add+0x4b8/0x578
[<8031560c>] platform_device_add+0x12c/0x24c
[<8060da40>] db1200_audio_load+0x78/0xa4
[<8010aa40>] do_one_initcall+0x40/0x1e8
[<805fb338>] kernel_init+0xd4/0x174
[<8010e734>] kernel_thread_helper+0x10/0x18

---[ end trace 8e74e4819d0d06c4 ]---
ALSA device list:
  #0: DB1200_AC97


Thanks!
      Manuel Lauss
