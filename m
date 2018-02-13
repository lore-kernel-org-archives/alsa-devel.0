From: Jan-Marek Glogowski <glogow@fbihome.de>
Subject: Re: [RfC][PATCH] ALSA: hda/realtek Pin quirk for
 Fujitsu U7[25]7
Date: Tue, 13 Feb 2018 12:00:29 +0100
Message-ID: <6d34fc90-48fb-8d5a-f7a5-7a3e33ddec9b@fbihome.de>
References: <c6ec1a50-187e-42d8-4137-f162c52e4f79@fbihome.de>
 <dcac37ef-4319-9eb3-4652-17bc6aa8fbc9@fbihome.de>
 <s5h7erh4e7z.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ironchief.h-da.de (ironchief.h-da.de [141.100.10.235])
 by alsa0.perex.cz (Postfix) with ESMTP id 89DBF266C0E
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 12:00:31 +0100 (CET)
In-Reply-To: <s5h7erh4e7z.wl-tiwai@suse.de>
Content-Language: en-GB
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

Hi Takashi,

Am 13.02.2018 um 07:04 schrieb Takashi Iwai:
> On Fri, 26 Jan 2018 16:12:53 +0100,
> Jan-Marek Glogowski wrote:
>>
>> I got new HW from our supplier, a Fujitsu U727 and a U757 laptop, which
>> have a headset jack. Attaching a headset, the microphone doesn't work.
>> After some reading and trying various tools to understand the problem, I
>> found hdajacksensetest, which showed a sense change for a seemingly
>> wrong unconnected pin.
>> Overriding this pins' config has fixed the headsets microphone, so now I
>> have the attached kernel patch with a SND_HDA_PIN_QUIRK.
> 
> The pin config override itself looks OK, but the way to identify the
> machine is an open question.  You've added the entries in
> alc269_pin_fixup_tbl[].  This table is for matching with a group of
> machines that have the same "fingerprint" by pin configs.  Usually
> this is used for Dell laptops and such.
> 
> OTOH, if one quirk is needed only for one or two machines, using the
> PCI SSID (or codec SSID) is the easier way to go, and it's done by
> putting into alc269_fixup_tbl[].

So I re-check the hardware:

$ cat /proc/asound/card0/codec#0 | head
Codec: Realtek ALC255
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0255
Subsystem Id: 0x10cf1629
Revision Id: 0x100002
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24

$ sudo lspci -vns 00:1f.3
00:1f.3 0403: 8086:9d70 (rev 21)
        Subsystem: 10cf:193e
        Flags: bus master, fast devsel, latency 32, IRQ 280
        Memory at c1240000 (64-bit, non-prefetchable) [size=16K]
        Memory at c1230000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 3
        Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Kernel driver in use: snd_hda_intel

I ran and diff'ed the output on both laptops. It's the same for both notebook types, so AFAIK there is no other way to distinguish them, except for the Jack pin being on the left or right side. The only difference I see is in the DMI datas' product name, but that data is not used in the sound driver at all.

$ sudo dmidecode -t 1
Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: FUJITSU
        Product Name: LIFEBOOK U757
        Family: LIFEBOOK-FTS

>> After compiling the patched module (for 4.4), everything works as
>> expected, but hdajackretask still shows the pin as unconnected, so I'm
>> wondering,  if I need to do something in addition?
> 
> If everything is working, why any more changes? :)

Ok. I'm not familiar with the HDA codecs, and I was just wondering, if this should / can be patched.

>> Is this normal behaviour?

Jan-Marek

>> P.S. checkpatch.pl warned about too long lines for the SND_HDA_PIN_QUIRK. Should I fix that?
