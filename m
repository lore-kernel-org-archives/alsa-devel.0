From: <LoganLi@viatech.com.cn>
Subject: Re: [PATCH 0/30] ALSA: HDA VIA: patch series
Date: Tue, 13 Oct 2009 17:40:48 +0800
Message-ID: <5B2BE0DB92BC8F4694F815C2F34E0D5F123E67@exchbj03.viatech.com.bj>
References: <51f3faa70910121940lfdfc318vcbaf9168727b50ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 6259C10388F
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Oct 2009 11:40:35 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <51f3faa70910121940lfdfc318vcbaf9168727b50ca@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: hancockrwd@gmail.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Robert Hancock [mailto:hancockrwd@gmail.com] =

> Sent: Tuesday, October 13, 2009 10:41 AM
> To: Takashi Iwai
> Cc: Logan Li; alsa-devel@alsa-project.org; Lydia Wang; Harald Welte
> Subject: Re: [PATCH 0/30] ALSA: HDA VIA: patch series
> =

> On Sun, Oct 11, 2009 at 11:29 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > At Sun, 11 Oct 2009 13:51:28 -0600,
> > Robert Hancock wrote:
> >>
> >> On 10/11/2009 01:27 PM, Takashi Iwai wrote:
> >> > At Sun, 11 Oct 2009 10:56:48 -0600,
> >> > Robert Hancock wrote:
> >> >>
> >> >> On Sun, Oct 11, 2009 at 10:18 AM, Takashi =

> Iwai<tiwai@suse.de> =A0wrote:
> >> >>> At Sat, 10 Oct 2009 19:07:09 +0800,
> >> >>> Logan Li wrote:
> >> >>>>
> >> >>>> Following patch series mainly includes:
> >> >>>> =A0 - support VT1718S, VT2002P, VT1812S, VT1716S, ...
> >> >>>> =A0 - support smart 5.1
> >> >>>> =A0 - add jack detection for VT1708
> >> >>>> =A0 - power saving functions
> >> >>>
> >> >>> Thanks for the patches. =A0They are all well formatted now.
> >> >>>
> >> >>> I applied your patches except for 17,
> >> >>> =A0 =A0 =A0 =A0 ALSA: HDA VIA: Add 2nd S/PDIF out for VT1708S =

> and VT1702
> >> >>> as Robert reported a regression.
> >> >>>
> >> >>> This is likely because of the behavior change by this =

> patch. =A0Now
> >> >>> the second SPDIF has to be specified manually with the explicit
> >> >>> substream number. =A0This itself is fine, but I see the =

> problem with
> >> >>> pulseaudio, for example. =A0There is no good way to =

> specify this substream
> >> >>> automatically for PA with some symbols like "spdif" or "hdmi".
> >> >>>
> >> >>> This is basically a problem of the current ALSA core =

> and HD-audio core
> >> >>> implementation. =A0So, we should solve all together.
> >> >>
> >> >> Actually, the latest posted version didn't have the =

> mixer problem I
> >> >> had before (I haven't looked in detail at what was =

> different). But I
> >> >> agree using a different substream for a different =

> output isn't ideal
> >> >> since there's no way for software to detect that this =

> is the case. Can
> >> >> it be a separate PCM like hw:0,2 or something?
> >> >
> >> > It would work like hw:0,1,1. =A0But, this is exactly what =

> I mentioned in
> >> > the above. =A0The secondary SPDIF isn't specified as an intuitively
> >> > selectable PCM device.
> >>
> >> Well, if it was its own subdevice like hw:0,2 it would =

> have some hope of
> >> being detected by HAL, PulseAudio, etc. If it's just a =

> substream then I
> >> don't think that software can actually tell it's a =

> separate output and
> >> not just a HW mixing-type stream, etc.
> >
> > Right, that's the missing information.
> >
> >> >> Hopefully VIA will also look into the SPDIF no-output =

> problem I have
> >> >> with VT1828S..
> >> >
> >> > What is the problem, specifically?
> >>
> >> With the latest patch I do get the optical output lighting =

> up and the
> >> receiver detects a PCM signal, but it seems to be just =

> silence coming
> >> through. (In previous iterations the SPDIF digital converter wasn't
> >> being enabled automatically so it didn't get even that far.)
> >
> > You can fiddle with hda-verb to issue digital-converter verbs.
> > Possibly you need to flip the digital-enable bit to send =

> the values...
> =

> Well, I think I tried all combinations of the flags on the digital
> converter in hda_analyzer without any luck. I'm assuming it's
> something else (presumably codec-specific) that hda_analyzer doesn't
> know about..
> =


Hi, Robert
  We cannot duplicate bug of SPDIF Out cannot work on VT1828S board.
  You said it's fine in Windows, right?
  About the 48k limit, I'll send a patch to remove it later, thank you for =
review!

Hi, Takashi
  So need I modify 2nd S/PDIF as separate PCM?
