From: Thorsten Leemhuis <fedora@leemhuis.info>
Subject: Re: Fwd: Problems with hda_intel, Santa Rosa,
	and suspend
Date: Fri, 06 Jul 2007 17:46:04 +0200
Message-ID: <468E63BC.6070401@leemhuis.info>
References: <dfd4051f0706161836xa191176ke10deff2868ad8d6@mail.gmail.com>	<dfd4051f0706201418o4d19a1f2g78081b052e8766e4@mail.gmail.com>	<s5hd4zpa9d9.wl%tiwai@suse.de>	<dfd4051f0706221331r681503d7h9d755bd91750a8ec@mail.gmail.com>	<s5hejk0ibhj.wl%tiwai@suse.de>	<dfd4051f0706251316uf265b3dw9c069dc5f75ceedf@mail.gmail.com>	<s5hsl8deffy.wl%tiwai@suse.de>	<dfd4051f0707041337m276d5536r6c65fd6d29463f39@mail.gmail.com>	<s5hvecz5cz3.wl%tiwai@suse.de>	<dfd4051f0707051513p697f22a2p4e34d9910f44f15e@mail.gmail.com>	<dfd4051f0707051942n699f69cava8a9d83b3bae5e1@mail.gmail.com>
	<s5hzm29513m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TZMXR01.htp-tel.de (tzmxr01.htp-tel.de [81.14.243.17])
	by alsa0.perex.cz (Postfix) with ESMTP id 7618F1037F8
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2007 17:46:05 +0200 (CEST)
In-Reply-To: <s5hzm29513m.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Matt Mullins <mokomull@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi!

FYI, I own the same laptop-model as Matt and have similar (identical?)
problems.

On 06.07.2007 11:32, Takashi Iwai wrote:
> At Thu, 5 Jul 2007 21:42:21 -0500,
> Matt Mullins wrote:
>> Found what I think is the problem... patch_sigmatel.c set
>> spec->num_pins=14, yet spec->pin_nids pointed to stac9205_pin_nids,
>> which was an array of only 12 NIDs.  That caused [total guess here]
>> either stac92xx_save_bios_config_regs or stac92xx_set_config_regs to
>> read past the end of the array and into an uninitialized area.  I
>> changed the 14 to a 12, and it seems to work.  The attached patch is
>> against the current Mercurial sources, but I made the similar change
>> to kernel 2.6.22-rc7, and it doesn't use single_cmd anymore.
> Argh!  Thanks for spotting this nasty bug.

Agreed; Matt, thx for your work.

> It'd be better to use ARRAY_SIZE there.  Then typos would be more
> obvious.  Could you check the patch below?

Works fine for me (patch was applied to alsa-driver 1.0.14 sources and
compiled against/tested on a Fedora 2.6.21 kernel and a 2.6.22-rc7-git3
kernel from the Fedora devel tree)

>>  It still
>> doesn't work after a suspend, though, making me unload and reload the
>> module.
> Do you mean you'll get a communication error after suspend, or got no
> sound output, or any other problem?

I simply don't get any audio output at all after either suspend or
hibernate. Reloading the module after suspend/hibernate makes the sound
working again.

CU
thl
