From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Changing snd_hda_intel.power_save default value ?
Date: Wed, 1 Nov 2017 19:11:32 +0100
Message-ID: <fa2d59f4-2a34-fb92-4f6f-3bcd138f92b1@redhat.com>
References: <9247bda8-da84-81e0-7897-8a45008c0d10@redhat.com>
 <s5ha806c52a.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C541266AE1
 for <alsa-devel@alsa-project.org>; Wed,  1 Nov 2017 19:11:36 +0100 (CET)
In-Reply-To: <s5ha806c52a.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 01-11-17 17:54, Takashi Iwai wrote:
> On Wed, 01 Nov 2017 15:19:44 +0100,
> Hans de Goede wrote:
>>
>> Hi All,
>>
>> I'm working on trying to improve the OOTB power-consumption
>> of Linux (Fedora Workstation) on laptops.
>>
>> One of the easy wins here is setting snd_hda_intel.power_save=1
>>
>> I see that the default is configurable through a Kconfig option,
>> currently Fedora is using the Kconfig default value of 0.
>>
>> So I'm wondering if there any known issues with changing the
>> default to 1 ?
> 
> This may bring click noises on some laptops or desktops, but it should
> be OK for the functionalities.  On openSUSE Tumbleweed kernels, we
> already pass 1 for some time.  Some reports came up occasionally but
> they can work around by setting the module option.
> 
>> I was also thinking that maybe an automatic value
>> (SND_HDA_POWER_SAVE_DEFAULT == -1) might be a good idea,
>> which would mean 0 normally except for PCI-ids which are
>> markes with a MOBILE flag in their driver_data in
>> the azx_ids pci_device_id table ?
> 
> I'm afraid that it'd be hard to manage that table.  This is one of
> mostly modified module option, e.g. a power-management daemon often
> adjusts the value dynamically.
> So, for modern distros, feel free simply set to value 1, but I see no
> reason to hustle for changing kconfig default value in the tree.  For
> the default value, we want to be conservative in general.

Ok, I will discuss changing the Kconfig option to "1" with the
Fedora kernel team.

Thanks & Regards,

Hans
