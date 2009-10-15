From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 0/30] ALSA: HDA VIA: patch series
Date: Wed, 14 Oct 2009 21:24:51 -0600
Message-ID: <51f3faa70910142024n39881e8dod2fefcd7d180b142@mail.gmail.com>
References: <51f3faa70910121940lfdfc318vcbaf9168727b50ca@mail.gmail.com>
	<5B2BE0DB92BC8F4694F815C2F34E0D5F123E67@exchbj03.viatech.com.bj>
	<51f3faa70910132052j286e0fa8vb5aeabe34e8bb4f@mail.gmail.com>
	<s5hocoavv1i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f198.google.com (mail-iw0-f198.google.com
	[209.85.223.198])
	by alsa0.perex.cz (Postfix) with ESMTP id D986F103813
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Oct 2009 05:24:52 +0200 (CEST)
Received: by iwn36 with SMTP id 36so290600iwn.24
	for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2009 20:24:51 -0700 (PDT)
In-Reply-To: <s5hocoavv1i.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, LydiaWang@viatech.com.cn, LoganLi@viatech.com.cn, HaraldWelte@viatech.com
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 14, 2009 at 9:45 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 13 Oct 2009 21:52:02 -0600,
> Robert Hancock wrote:
>>
>> On Tue, Oct 13, 2009 at 3:40 AM, =A0<LoganLi@viatech.com.cn> wrote:
>> >> >> > What is the problem, specifically?
>> >> >>
>> >> >> With the latest patch I do get the optical output lighting
>> >> up and the
>> >> >> receiver detects a PCM signal, but it seems to be just
>> >> silence coming
>> >> >> through. (In previous iterations the SPDIF digital converter wasn't
>> >> >> being enabled automatically so it didn't get even that far.)
>> >> >
>> >> > You can fiddle with hda-verb to issue digital-converter verbs.
>> >> > Possibly you need to flip the digital-enable bit to send
>> >> the values...
>> >>
>> >> Well, I think I tried all combinations of the flags on the digital
>> >> converter in hda_analyzer without any luck. I'm assuming it's
>> >> something else (presumably codec-specific) that hda_analyzer doesn't
>> >> know about..
>> >>
>> >
>> > Hi, Robert
>> > =A0We cannot duplicate bug of SPDIF Out cannot work on VT1828S board.
>> > =A0You said it's fine in Windows, right?
>>
>> Ahh, I see the problem. I think it's related to what we were talking
>> about with the second SPDIF output: If I play back on subdevice 1 I
>> don't get any output. But if I force playing on substream 1 instead of
>> the default 0 (i.e. hw:0,1,1) then I get audio. I'm assuming that
>> substream 0 is the codec's HDMI output (which actually doesn't exist
>> on this motherboard).
>>
>> It appears whether or not the "iec958" alias that PulseAudio uses when
>> selecting "Output Digital Stereo" profile actually ends up using
>> substream 1 instead of 0 is based on luck. as it sometimes works and
>> sometimes doesn't. Having different substreams go different places is
>> pretty non-intuitive and it seems software doesn't expect this
>> behavior. I think that the SPDIF and HDMI outputs really should be
>> separate subdevices (i.e. hw:0,1 and hw:0,2 or something) instead,
>> unless something makes this impossible. If the aliases for iec958 and
>> hdmi were set up to point to the correct subdevice then everything
>> would work as it should..
>
> Yes, it's possible to assign two different devices if the pin-config
> of each digital output is set up properly for SPDIF and HDMI.
> It won't be too difficult to fix, but I have little time now.

Actually, I just checked the version of patch_via.c that's in the
sound git tree and it doesn't seem to have this problem with SPDIF
output. (I believe the version I was using had one of the second-SPDIF
patches that was dropped.) There are still 2 substreams it appears,
but both seem to output to SPDIF..
