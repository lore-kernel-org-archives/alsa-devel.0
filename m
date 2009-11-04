From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: VIA VT1828S hda_intel errors
Date: Wed, 4 Nov 2009 17:52:47 -0600
Message-ID: <51f3faa70911041552s5be9a0ebx7f28977040c4c7a0@mail.gmail.com>
References: <4AEA3BCB.5040202@gmail.com> <s5hws2dxdts.wl%tiwai@suse.de>
	<51f3faa70911011203x306dba43s4ce984f20f773144@mail.gmail.com>
	<s5hfx8xxluu.wl%tiwai@suse.de>
	<51f3faa70911022055s81f633du71fd10d2ef109e58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f198.google.com (mail-iw0-f198.google.com
	[209.85.223.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AA131037F9
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 00:52:48 +0100 (CET)
Received: by iwn36 with SMTP id 36so5339206iwn.24
	for <alsa-devel@alsa-project.org>; Wed, 04 Nov 2009 15:52:47 -0800 (PST)
In-Reply-To: <51f3faa70911022055s81f633du71fd10d2ef109e58@mail.gmail.com>
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
Cc: Alsa-Devel <alsa-devel@alsa-project.org>, LydiaWang@viatech.com.cn, Logan Li <loganli@viatech.com.cn>, Harald Welte <HaraldWelte@viatech.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 2, 2009 at 10:55 PM, Robert Hancock <hancockrwd@gmail.com> wrot=
e:
> On Mon, Nov 2, 2009 at 4:27 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> At Sun, 1 Nov 2009 14:03:18 -0600,
>> Robert Hancock wrote:
>>>
>>> On Fri, Oct 30, 2009 at 6:31 AM, Takashi Iwai <tiwai@suse.de> wrote:
>>> > At Thu, 29 Oct 2009 19:05:15 -0600,
>>> > Robert Hancock wrote:
>>> >>
>>> >> I've been using the VT1828S codec support from ALSA git for the last=
 few
>>> >> weeks. It seems to work fine, but there are some problems showing up=
 in
>>> >> dmesg:
>>> >>
>>> >> Oct 25 20:46:14 newcastle kernel: ALSA sound/pci/hda/hda_intel.c:683=
: No
>>> >> response from codec, disabling MSI: last cmd=3D0x02af0900
>>> >> Oct 25 20:46:15 newcastle kernel: ALSA sound/pci/hda/hda_intel.c:698:
>>> >> azx_get_response timeout, switching to polling mode: last cmd=3D0x02=
af0900
>>> >
>>> > Note that this isn't always a severe problem. =A0If polling mode works
>>> > (you don't see the similar errors after this), it means the IRQ isn't
>>> > properly generated at verb handling.
>>> >
>>> >> It seems like the cmd isn't always the same, previously it was
>>> >> 0x024f0c00. Is there something bad about this command that could be
>>> >> causing the response timeout?
>>> >
>>> > Hm, both aren't really same, pointing to different widgets. =A0So,
>>> > it looks like a generic problem in the codec communication on your
>>> > board.
>>>
>>> Something VIA guys should look into?
>>
>> Hopefully. =A0This is a bit hard problem to track, though...
>>
>>> >> Also, disabling MSI for one occurrence of
>>> >> this seems a bit paranoid..
>>> >
>>> > MSI was unstable for long time, so disabling it was a sane option :)
>>> > Now it gets better, so it should be a second option.
>>> > I changed the code now.
>>> >
>>> >> Also saw one of these:
>>> >>
>>> >> Oct 26 21:13:20 newcastle kernel: hda-intel: IRQ timing workaround is
>>> >> activated for card #0. Suggest a bigger bdl_pos_adj.
>>> >>
>>> >> and PulseAudio also complained:
>>> >>
>>> >> Oct 26 00:27:50 newcastle pulseaudio[16530]: alsa-sink.c: ALSA woke =
us
>>> >> up to write new data to the device, but there was actually nothing t=
o write!
>>> >> Oct 26 00:27:50 newcastle pulseaudio[16530]: alsa-sink.c: Most likely
>>> >> this is a bug in the ALSA driver 'snd_hda_intel'. Please report this
>>> >> issue to the ALSA developers.
>>> >> Oct 26 00:27:50 newcastle pulseaudio[16530]: alsa-sink.c: We were wo=
ken
>>> >> up with POLLOUT set -- however a subsequent snd_pcm_avail() returned=
 0
>>> >> or another value < min_avail.
>>> >
>>> > Well, this is the case where the hardware reports bad position data.
>>> > This is usually a hardware bug, and hard to fix properly. =A0We have =
some
>>> > mechanism to correct or take back to the last position. =A0This should
>>> > usually work, but apparently not in your case...
>>>
>>> Well, it looks like PulseAudio complained before the IRQ timing
>>> workaround was activated (about 20 hours earlier)..
>>
>> Then try to pass bdl_pos_adj=3D0 option to snd-hda-intel module.
>> The PA complaining still present?
>
> With bdl_pos_adj=3D0, so far no complaints from PulseAudio after some
> hours of audio playing.. I'll keep monitoring it.

Nope, saw one again:

Nov  2 23:53:18 newcastle pulseaudio[6306]: alsa-sink.c: ALSA woke us
up to write new data to the device, but there was actually nothing to
write!
Nov  2 23:53:18 newcastle pulseaudio[6306]: alsa-sink.c: Most likely
this is a bug in the ALSA driver 'snd_hda_intel'. Please report this
issue to the ALSA developers.
Nov  2 23:53:18 newcastle pulseaudio[6306]: alsa-sink.c: We were woken
up with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0
or another value < min_avail.

>
> Actually there's been no codec response timeout errors either since
> making that change, though I don't know if it's just by luck.. doesn't
> seem like it should be related.

Saw some more of these as well. Interestingly enough an ACPI GPE storm
was reported very close in time to it (same second in the log):

Nov  2 23:49:13 newcastle kernel: ACPI: EC: GPE storm detected,
transactions will use polling mode
Nov  2 23:49:13 newcastle kernel: ALSA sound/pci/hda/hda_intel.c:683:
No response from codec, disabling MSI: last cmd=3D0x024f0c00
Nov  2 23:49:14 newcastle kernel: ALSA sound/pci/hda/hda_intel.c:698:
azx_get_response timeout, switching to polling mode: last
cmd=3D0x024f0c00
