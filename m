From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [RFC] ALSA: usb-audio: Add custom mixer status
 quirks for RME CC devices
Date: Fri, 21 Sep 2018 11:35:49 +0300
Message-ID: <76bd64a6-6d83-912d-e2e3-ec2c4c191dd2@sonarnerd.net>
References: <1537481240-4999-1-git-send-email-jussi@sonarnerd.net>
 <s5h7ejfuyex.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id E838C2676E6
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2018 10:35:50 +0200 (CEST)
In-Reply-To: <s5h7ejfuyex.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> The caching is currently enabled for all elements, but changing it
> should be trivial.  The patch below adds is_volatile flag to the
> element, and you can set it to true in the quirk somehow for uncached
> controls.

This patch looks good and what I need! When trying to figure out where 
it is safe to set the volatile flag I thought that I could set it 
transparently in add_single_ctl_with_resume() in mixer_quirks.c based on 
the SNDRV_CTL_ELEM_ACCESS_VOLATILE flag in provided snd_kcontrol_new 
access-member. However, add_single_ctl_with_resume() is allocating just 
size of usb_mixer_elem_list unlike snd_create_std_mono_ctl_offset() 
which in turn is allocating full usb_mixer_elem_info size. However, the 
mixer code seems to be assuming that the item is always 
usb_mixer_elem_info instead of just list header item. Is this allocation 
behavior correct and is the item turned into usb_mixer_elem_info 
somewhere, or is this some kind of bug? So can I safely turn the 
allocation in add_single_ctl_with_resume() into zero initialized 
usb_mixer_elem_info instead and set the flag there while keeping correct 
behavior, or am I missing something?


Thanks,

	- Jussi
