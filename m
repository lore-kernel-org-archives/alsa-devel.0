From: Justin Mattock <justinmattock@gmail.com>
Subject: Re: /proc/asound/* shows signs of life,
	but alsactl 	see's nothing
Date: Thu, 16 Apr 2009 12:50:46 -0700
Message-ID: <dd18b0c30904161250h131dc392x700675766c6a4b63@mail.gmail.com>
References: <dd18b0c30904151603x226dfedaje9e443f7dc9eda38@mail.gmail.com>
	<s5hbpqx2k6e.wl%tiwai@suse.de>
	<dd18b0c30904160700y4157ebbdg3c561f4b294d2f4e@mail.gmail.com>
	<dd18b0c30904161118y2fc7873jf8392b24c0ab0585@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 05D631039A3
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 21:50:48 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1064891qyk.16
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 12:50:48 -0700 (PDT)
In-Reply-To: <dd18b0c30904161118y2fc7873jf8392b24c0ab0585@mail.gmail.com>
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
Cc: Micah Bucy <micah.bucy@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 16, 2009 at 11:18 AM, Justin Mattock
<justinmattock@gmail.com> wrote:
> On Thu, Apr 16, 2009 at 7:00 AM, Justin Mattock <justinmattock@gmail.com>=
 wrote:
>> On Wed, Apr 15, 2009 at 11:21 PM, Takashi Iwai <tiwai@suse.de> wrote:
>>> At Wed, 15 Apr 2009 16:03:07 -0700,
>>> Justin Mattock wrote:
>>>>
>>>> This is confusing to me
>>>> (with or without the imac9,1 patch
>>>> for the imac)
>>>> there is still entries in /proc/asound
>>>>
>>>> lrwxrwxrwx 1 root root 5 Apr 15 22:49 NVidia -> card0
>>>> dr-xr-xr-x 7 root root 0 Apr 15 22:49 card0
>>>> -r--r--r-- 1 root root 0 Apr 15 22:49 cards
>>>> -r--r--r-- 1 root root 0 Apr 15 22:49 devices
>>>> -r--r--r-- 1 root root 0 Apr 15 22:49 hwdep
>>>> -r--r--r-- 1 root root 0 Apr 15 22:49 pcm
>>>> -r--r--r-- 1 root root 0 Apr 15 22:49 timers
>>>> -r--r--r-- 1 root root 0 Apr 15 22:49 version
>>>>
>>>> but when I do:
>>>> sudo /usr/sbin/alsactl store
>>>> /usr/sbin/alsactl: save_state:1502: No soundcards found...
>>>
>>> Check /dev/snd/* files.
>>>
>>
>> Thank you.
>> I ended up missing an entry in /etc/ude/rules.d/alsa-*
>> (the devices were present,but in /dev/* instead of /dev/snd/*
>>
>>
>>>> I this a software issue, or is this because the kernel is missing
>>>> something important in patch_realtek.c ?
>>>>
>>>> I've moved different things around in patch_realtek.c
>>>> but still no speaker sound or headphone, not even
>>>> the sound during boot when the module is being loaded.
>>>
>>> Then it sounds like a different problem.
>>
>> yeah devices in the wrong location(hopefully
>> just this simple)
>>
>>>
>>>> Also what is the best way to find PCI SSID?
>>>
>>> lspci -nv
>>>
>>
>> 00:08.0 0403: 10de:0ac0 (rev b1)
>> =A0 =A0 =A0 =A0Subsystem: 10de:cb79
>> =A0 =A0 =A0 =A0Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 17
>> =A0 =A0 =A0 =A0Memory at d3480000 (32-bit, non-prefetchable) [size=3D16K]
>> =A0 =A0 =A0 =A0Capabilities: <access denied>
>> =A0 =A0 =A0 =A0Kernel driver in use: HDA Intel
>> =A0 =A0 =A0 =A0Kernel modules: snd-hda-intel
>>
>>
>>>> under codec#0:(I have)
>>>>
>>>> Codec: Realtek ALC889A
>>>> Address: 0
>>>> Vendor Id: 0x10ec0885
>>>> Subsystem Id: 0x106b4900
>>>> Revision Id: 0x100103
>>>> No Modem Function Group found
>>>>
>>>> but with lspci -nnv
>>>>
>>>> 00:08.0 0403: 10de:0ac0 (rev b1)
>>>> =A0 =A0 =A0 =A0 Subsystem: 10de:cb79
>>>> =A0 =A0 =A0 =A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGAS=
noop-
>>>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>>> =A0 =A0 =A0 =A0 Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfas=
t >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> =A0 =A0 =A0 =A0 Latency: 0 (500ns min, 1250ns max)
>>>> =A0 =A0 =A0 =A0 Interrupt: pin A routed to IRQ 17
>>>> =A0 =A0 =A0 =A0 Region 0: Memory at d3480000 (32-bit, non-prefetchable=
) [size=3D16K]
>>>> =A0 =A0 =A0 =A0 Capabilities: <access denied>
>>>> =A0 =A0 =A0 =A0 Kernel driver in use: HDA Intel
>>>> =A0 =A0 =A0 =A0 Kernel modules: snd-hda-intel
>>>>
>>>> the subsystem is 10de:cb79
>>>> but is
>>>> Subsystem Id: 0x106b4900
>>>
>>> The former is PCI SSID and the latter is the codec SSID.
>>> They are often different.
>>>
>>>
>>> Takashi
>>>
>>
>> Now that i've realized udev
>> was not creating the device, everything
>> has changed(back to the beginning with this one)
>> so hopefully, by the end of the day one option
>> in there will work.
>> I'll let you know if I find anything
>> interesting(hopefully).
>>
>> regards,
>>
>> --
>> Justin P. Mattock
>>
>
> Alright after configuring udev,
> sound is finally working
> internal speakers and headphones
> here's the diff(no mac 9,1 patch)
>
> --- patch_realtek.c.old 2009-04-16 18:14:21.000000000 -0700
> +++ patch_realtek.c =A0 =A0 2009-04-16 18:13:41.000000000 -0700
> @@ -7023,6 +7023,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 0x106b2c00: /* Macbook Pro rev3 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 0x106b3600: /* Macbook 3.1 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 0x106b3800: /* MacbookPro4,1 - latter=
 revision */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 0x106b4900:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0board_config =3D ALC885_MB=
P3;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:
>
> I'll try imac 24, and then add the imac 91 patch to
> see the differences.
>
> As for quality damn this sh^t is loud,
> when plugging in headphones you need to
> change to channel 2 for internal speakers to mute
> and transition to headphones.
>
>
>
> --
> Justin P. Mattock
>

O.K.
after changing different options in patch_realtek.c
(mp3 option
imac24
imac9,1)

every option works,except imac24 configuration(no sound at all)
mbp3 works good(especially if imac9,1 is not patched into the kernel yet)
imac9,1 work's perfectly =3D its loud, plugging headphones(mutes
internal speakers),
microphone(don't know) I don't have any apps yet to test.(still need
to build them)

As for the main issue:
besides being an impatient drunk
I didnt follow the instructions at
http://cblfs.cross-lfs.org/index.php/ALSA_Utilities for
15-alsa.rules which was putting all of the created devices in
/dev/* instead of /dev/snd/*

Overall mbp3 options is good for now,
(this way people can enjoy there machines)
but the imac91.patch
works perfectly.

Thank you for helping me out.

regards,

-- =

Justin P. Mattock
