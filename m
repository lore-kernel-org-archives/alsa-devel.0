From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH 2/2] ALSA: hda - add connection to thinkpad_acpi to
 control mute/micmute LEDs
Date: Wed, 16 Oct 2013 23:08:44 +0200
Message-ID: <525F005C.3060806@canonical.com>
References: <1381925736-11399-1-git-send-email-david.henningsson@canonical.com>	<1381925736-11399-3-git-send-email-david.henningsson@canonical.com> <s5hob6puuyg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <s5hob6puuyg.wl%tiwai@suse.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, platform-driver-x86@vger.kernel.org, ibm-acpi@hmh.eng.br, alex.hung@canonical.com, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

On 10/16/2013 04:55 PM, Takashi Iwai wrote:
> At Wed, 16 Oct 2013 14:15:36 +0200,
> David Henningsson wrote:
>>
>> Notes/questions:
>>
>> For mute LEDs we can follow master like we already do on HP machines, but for
>> mic mutes, we might have several capture switches. Honestly, on these laptops
>> which almost always have autoswitched mics, there is only one recording source
>> anyway. Can't we simply remove the extra capture PCMs, that seems easiest?
> 
> The fixup would be applied only to specific machines, so they are
> without extra capture PCMs, no?

Actually, what I was thinking of is already implemented: when auto_mic
is turned on, num_adc_nids is set to one, so there are no extra ADCs. I
think we can get away (at least for now) with just an extra check that
there are no extra ADCs (added in v2 of the patch).

>> For some reason CONFIG_THINKPAD_ACPI did not work here (it was not defined),
>> but maybe it's due to the way I'm testing, or I'm missing something obvious. 
>> Not sure.
> 
> It can be a module.  Use IS_ENABLED() macro.
> 
> #if IS_ENABLED(CONFIG_THINKPAD_ACPI)

Thanks!

>> There are Thinkpad's with Realtek codecs as well which have mute/micmute.
>> Maybe we should consider a more generic solution instead of copy-pasting
>> between differen patch_* files?
> 
> Maybe.  But it's not that wide spread. 

Perhaps other people on this list have a better overview than I, but I
get the feeling that at least the mute LED is quite common on Thinkpads.
The micmute LED perhaps not so much.

> Let's make this one working at
> first.  The further code sharing (involving module split eventually)
> can be discussed later.

Ok.

>> And also, we're missing a symbol_put in this version. Should we add a new
>> "free" fixup action where we can add a call to symbol_put, or do you have a
>> better suggestion?
> 
> Hm, yes, a new free fixup action is a feasible option.

Ok, added in v2.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
