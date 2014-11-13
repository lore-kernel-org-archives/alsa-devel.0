From: Chris Pemberton <cjpembo@gmail.com>
Subject: Re: possible snd_hda_intel jack-sensing issue with
 device 8086:1c20
Date: Thu, 13 Nov 2014 00:47:04 -0600
Message-ID: <546453E8.1050408@gmail.com>
References: <546256C1.80604@gmail.com> <s5hegt8rh2m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f174.google.com (mail-ob0-f174.google.com
 [209.85.214.174])
 by alsa0.perex.cz (Postfix) with ESMTP id DE577260464
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 07:47:06 +0100 (CET)
Received: by mail-ob0-f174.google.com with SMTP id uz6so10362403obc.19
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 22:47:05 -0800 (PST)
In-Reply-To: <s5hegt8rh2m.wl-tiwai@suse.de>
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

I looked again and the motherboard only has ONE front panel audio socket 
and the case cable has two ends - one labelled HD and the other AC97.

Hooking up the cable end labelled AC97 and setting the BIOS to AC97 
seems to be working.

On 11/12/2014 01:52 AM, Takashi Iwai wrote:
> At Tue, 11 Nov 2014 12:34:41 -0600,
> Chris Pemberton wrote:
>> CentOS 7 x86_64
>> Asus P8Z68-V motherboard
>> Realtek ALC892
>> Gnome 3 desktop
>> nVidia GTX 770 with nVidia's driver
>>
>> With BIOS set to HD for both rear and front jacks, I experience the problems I reported here:
>>
>> https://bugs.freedesktop.org/show_bug.cgi?id=86158
>>
>> Basically, sound works, but the selected output keeps auto-magically flipping from Analog-Out to Headphones and back so fast you barely hear a click..
>>
>> Tried all sorts of snd_hda_intel module options and it didn't change.
>>
>> Finally changed BIOS to set front jacks to AC97 (left rear jacks as HD) and sound works great... but no jack sensing occurs at all...
>>
>> I can live without the jack sensing... but if anyone wants a stab at a fix, I'm game.
>>
>> I've got the HDA Analyzer downloaded and running if that helps.
>>
>> My device has id 8086:1c20
>>
>> Perhaps similar to this bug that was brought to my attention?
>>
>> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=1565cc358585be40608b46f18f7ac431a1aae2bc
>>
>> Output of alsa-info.sh is here:
>>
>> http://www.alsa-project.org/db/?f=8cf116b0bc230524bcfa7285b2adb698078d4224
> Could you check the pin connection again?  The symptom appears more like
> a hardware problem.
>
>
> Takashi
