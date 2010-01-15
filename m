From: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
Subject: Re: [PATCH v2] ALSA: Fix mute led GPIO on HP dv-series
	notebooks.
Date: Fri, 15 Jan 2010 19:02:17 +0530
Message-ID: <201001151902.17260.kunal.gangakhedkar@gmail.com>
References: <s5hockvlryh.wl%tiwai@suse.de>
	<1263560719-4702-1-git-send-email-kunal.gangakhedkar@gmail.com>
	<s5hmy0fld0l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196])
	by alsa0.perex.cz (Postfix) with ESMTP id 5780324469
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 14:32:26 +0100 (CET)
Received: by yxe34 with SMTP id 34so376122yxe.16
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 05:32:25 -0800 (PST)
In-Reply-To: <s5hmy0fld0l.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Devel List <alsa-devel@alsa-project.org>, Goldwyn Rodrigues <goldwynr@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Friday 15 Jan 2010 6:51:30 pm Takashi Iwai wrote:
> At Fri, 15 Jan 2010 18:35:19 +0530,
> Kunal Gangakhedkar wrote:
> > 
> > On my laptop (HP dv6-1110ax), there are no OEM strings in SMBIOS of type
> > "HP_Mute_LED*". Hence, the GPIO for the mute button LED doesn't get set
> > properly. I didn't find the strings in my cousin's laptop (HP dv9500t CTO)
> > either.
> > 
> > As per the documentation of find_mute_led_gpio(), these strings occur
> > in HP B-series systems - so, before scanning the SMBIOS strings, we need to
> > check if we're dealing with a B-series system.
> > Need to get confirmation from HP if this logic takes care of all the
> > systems. I'm trying to poke a friend there.
> > 
> > Please let me know if this looks OK or needs changes.
> 
> Well, the open switch() for blike-system should be replaced with
> set_hp_led_gpio().  That's the very purpose I proposed to create a
> function.
> 

I don't think you can do that since both cases (b-like and non-b-like) have
different ways of setting the gpio. 

> Thinking the logic again, however, it might be safer to check DMI
> entries no matter which model is.  Then set statically if it's DV
> series (i.e. !hp_blike_system()) as fallback.  I suppose HP will
> implement the DMI entry for their new BIOS on other models in future,
> too, so the chance is high that the right setup is detected through
> DMI check instead of blindly fixed setup.
> 

They're notorious to discontinue models really fast. For example, my laptop model
is already discontinued in less than 6 months. So, I don't think I'll be getting updates
for my BIOS at all. What do you propose for such cases?

I agree with your approach that we should be checking for DMI string unconditionally and 
use the fixed setup as fallback - I can send the patch with those fixes too.
Let me know if that's what you'd prefer.

Thanks,
Kunal

> 
> thanks,
> 
> Takashi
> 
> > 
