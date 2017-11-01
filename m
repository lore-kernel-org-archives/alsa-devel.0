From: Hans de Goede <hdegoede@redhat.com>
Subject: Changing snd_hda_intel.power_save default value ?
Date: Wed, 1 Nov 2017 15:19:44 +0100
Message-ID: <9247bda8-da84-81e0-7897-8a45008c0d10@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id E8EB226709F
 for <alsa-devel@alsa-project.org>; Wed,  1 Nov 2017 15:19:49 +0100 (CET)
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
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi All,

I'm working on trying to improve the OOTB power-consumption
of Linux (Fedora Workstation) on laptops.

One of the easy wins here is setting snd_hda_intel.power_save=1

I see that the default is configurable through a Kconfig option,
currently Fedora is using the Kconfig default value of 0.

So I'm wondering if there any known issues with changing the
default to 1 ?

I was also thinking that maybe an automatic value
(SND_HDA_POWER_SAVE_DEFAULT == -1) might be a good idea,
which would mean 0 normally except for PCI-ids which are
markes with a MOBILE flag in their driver_data in
the azx_ids pci_device_id table ?

Regards,

Hans
