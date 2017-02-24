From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [sound:topic/asus-e100h-4.10 5/26]
 arch/x86/include/asm/iosf_mbi.h:137:55: warning: 'struct notifier_block'
 declared inside parameter list will not be visible outside of this
 definition or declaration
Date: Fri, 24 Feb 2017 10:24:27 +0100
Message-ID: <b7cefd0d-4933-32a2-f76a-63e51d51202a@redhat.com>
References: <201702240641.IbhRlZCe%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B8EC261A1A
 for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2017 10:24:32 +0100 (CET)
In-Reply-To: <201702240641.IbhRlZCe%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm sending out a new v4 of the "coordinate cht i2c-pmic and i915-punit accesses"
patch-set fixing this.

Regards,

Hans


On 23-02-17 23:26, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/asus-e100h-4.10
> head:   c86c0067e6111324a39f523c250c8b1089b1d822
> commit: d97e0b9238852206e9dce1de994ff8d2791f6429 [5/26] x86/platform/intel/iosf_mbi: Add a PMIC bus access notifier
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout d97e0b9238852206e9dce1de994ff8d2791f6429
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All warnings (new ones prefixed by >>):
>
>    In file included from arch/x86/platform/intel-quark/imr.c:30:0:
>>> arch/x86/include/asm/iosf_mbi.h:137:55: warning: 'struct notifier_block' declared inside parameter list will not be visible outside of this definition or declaration
>     int iosf_mbi_register_pmic_bus_access_notifier(struct notifier_block *nb);
>                                                           ^~~~~~~~~~~~~~
>    arch/x86/include/asm/iosf_mbi.h:144:57: warning: 'struct notifier_block' declared inside parameter list will not be visible outside of this definition or declaration
>     int iosf_mbi_unregister_pmic_bus_access_notifier(struct notifier_block *nb);
>                                                             ^~~~~~~~~~~~~~
>
> vim +137 arch/x86/include/asm/iosf_mbi.h
>
>    121	
>    122	/**
>    123	 * iosf_mbi_register_pmic_bus_access_notifier - Register PMIC bus notifier
>    124	 *
>    125	 * This function can be used by drivers which may need to acquire P-Unit
>    126	 * managed resources from interrupt context, where iosf_mbi_punit_acquire()
>    127	 * can not be used.
>    128	 *
>    129	 * This function allows a driver to register a notifier to get notified (in a
>    130	 * process context) before other drivers start accessing the PMIC bus.
>    131	 *
>    132	 * This allows the driver to acquire any resources, which it may need during
>    133	 * the window the other driver is accessing the PMIC, before hand.
>    134	 *
>    135	 * @nb: notifier_block to register
>    136	 */
>  > 137	int iosf_mbi_register_pmic_bus_access_notifier(struct notifier_block *nb);
>    138	
>    139	/**
>    140	 * iosf_mbi_register_pmic_bus_access_notifier - Unregister PMIC bus notifier
>    141	 *
>    142	 * @nb: notifier_block to unregister
>    143	 */
>    144	int iosf_mbi_unregister_pmic_bus_access_notifier(struct notifier_block *nb);
>    145	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
