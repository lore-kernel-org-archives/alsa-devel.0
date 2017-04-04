From: Ralf Jung <post@ralfj.de>
Subject: Re: PROBLEM: Internal microphone (& combined headset
 jack, in default config) not working on Acer VN7-592G (Skylake)
Date: Tue, 4 Apr 2017 19:34:23 +0200
Message-ID: <7b570b96-cd16-d282-c17c-af2f6b468430@ralfj.de>
References: <990a87bf-735b-d978-b6ba-74bb7a65a244@ralfj.de>
 <s5ha8avyywb.wl-tiwai@suse.de>
 <fe7fce02-9f22-53e9-f7a3-fa74bfbf3e66@ralfj.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eins.ralfj.de (eins.ralfj.de [85.214.220.216])
 by alsa0.perex.cz (Postfix) with ESMTP id 19544266834
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 19:34:26 +0200 (CEST)
In-Reply-To: <fe7fce02-9f22-53e9-f7a3-fa74bfbf3e66@ralfj.de>
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

Hi again,

On 15.01.2017 10:52, Ralf Jung wrote:
>>> I was able to improve the situation by adding this to modprobe.d:
>>>   options snd-hda-intel model=dell-headset-multi
>>> Now, mics and external speakers plugged in work fine (where for mics, I
>>> need to manually configure them in pacuvontrol: "Speakers" and
>>> "Microphone").  Combined headsets also work (with "Headphones" and
>>> "Headset Microphone"), i.e. I get audio in and audio out, but the audio
>>> in from the microphone is fairly noisy.  I am not sure whether this is
>>> due to the headset or the laptop; I am using the same headset with my
>>> phone and people I called did not complain about noise.
>>>   Furthermore, there is a weird effect: I have a headset with *separate*
>>> plugs for speaker and mic (which I used above to test the speaker vs.
>>> mic functionality).  If I plug in the speaker part, but configure it as
>>> a microhpone (out: "Speakers", in: "Microphone"), then I actually get a
>>> (rather noisy) input signal. Not sure what is going on there, but I'm
>>> reasonably sure it is getting that signal from the headset, not the
>>> internal mic of the laptop.
>>
>> It's a configuration with "headphone mic" for Dell, so it doesn't fit
>> with yours properly.
>>
>> Look at the lspci -nv output, and check the PCI SSID of the
>> corresponding device.  Then try to add an entry applying some fixup,
>> e.g. ALC269_FIXUP_ASPIRE_HEADSET_MIC, in alc269_fixup_tbl[] defined in
>> sound/pci/hda/patch_realtek.c:
>>
>> static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>> .....
>>         SND_PCI_QUIRK(0x1025, XXXX, "Acer Your Model", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
>> .....
>>
>> There are other definitions for 1025:*, so put your own one there.
>> The list is sorted in the id number order.
>>
>> There are quite lots of fixup models that can be applied, do figure
>> out by trial-and-error.
> 
> I tried a bunch of fixup models (and even defined one myself), but none
> of them made the internal microhpone work.  Funny enough, the
> definitions involving "DELL" work best.
> 
> Here's what I tried:
> 
> ALC269_FIXUP_ASPIRE_HEADSET_MIC, ALC255_FIXUP_ASPIRE_HEADSET_MIC [*]:
> Combined headset plugged into the hack works. PLugging in a "pure" mic
> doesn't. pavuctl says "Headset Microphone (unplugged)".
> 
> ALC255_FIXUP_HEADSET_MODE, ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC:
> No mic works, pavuctl: "Analog Input"
> 
> ALC255_FIXUP_DELL1_MIC_NO_PRESENCE, ALC269_FIXUP_DELL1_MIC_NO_PRESENCE:
> pavuctl: "Headset Microhpone" & "Microphone". Both kinds of microphone
> work (after sometimes manually selecting the right thing in pavuctl),
> but the "pure" mix has a 50 Hz noise on it that goes away when I unplug
> all cable. Notice that this is running the laptop in a different place
> and with a different mic than when I previously tried just passing an
> option to the vanilla module, so I don't know whether the 50 Hz hum also
> appears in the other conditions.  There's no 50 Hz hum with the
> "combined" headset.
>   There's a weird bug: When starting Audacity, playback breaks and I
> have to switch (in pavuctl) to "Microphone" and then back to "Headset
> Microphone" to make it work again.
> 
> [*] See attached patch.  Notice that I don't know what I am doing here,
> I am just pattern-matching.
> 
> I can't realistically try all the hundreds of fixups, so I tried those
> that sounded most realistic and those that mention ALC255 (which seems
> to be the chip I have).  However, as can be seen above, ALC269-fixups
> vs. ALC255-fixups doesn't seem to make any difference.

Any news on this; anything else I could try?  As I mentioned I tried
various combinations and settings, and none seemed to have any effect on
the internal microphone.  It doesn't look like the driver even notices a
mic is around.

Kind regards,
Ralf
