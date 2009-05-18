From: Karthik Ramgopal <applefreakpeeps@gmail.com>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Mon, 18 May 2009 14:44:48 +0800
Message-ID: <4b8c423b0905172344y551048cag9991a1dff9813d7f@mail.gmail.com>
References: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
	<s5h4ovj7hva.wl%tiwai@suse.de>
	<d54969c50905171348v12a58613sa8425f450e843eea@mail.gmail.com>
	<s5hws8fdj65.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 56B712447D
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 08:44:49 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id k29so1326890rvb.32
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2009 23:44:48 -0700 (PDT)
In-Reply-To: <s5hws8fdj65.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,
      Here is a list of ALC889 verbs for the 6920/6935 series of laptops. I
got this from someone who has got the audio subsystem fully working (jack
sensing+proper mapping+mic+SPDIF) with Mac OS X.

*NID 17 [Jack] Digital Out at Int HDMI*
Node - 0x11
Pin Default - 0x18561130
*Verb* - 01171C30 01171D11 01171E56 01171F18

*NID 18 [Fixed] Mic at Int ATAPI*
Node 0x12
Pin Default - 0x99a3094e
*Verb* - 01271C4E 01271D09 01271EA3 01271F99

*NID 20 [Fixed] Speaker at Int ATAPI*
Node - 0x14
Pin Default - 0x99130110
*Verb* - 01471C10 01471D01 01471E13 01471F99

*NID 21 [Jack] HP Out at Ext Front*
Node - 0x15
Pin Default - 0x0221101f
*Verb* - 01571C1F 01571D10 01571E21 01571F02

*NID 22 [N/A] Speaker at Ext Rear*
Node - 0x16
Pin Default - 0x411111f0
*Verb* - 01671CF0 01671D11 01671E11 01671F41

*NID 23 [N/A] Speaker at Ext Rear*
Node - 0x17
Pin Default - 0x411111f0
*Verb* - 01771CF0 01771D11 01771E11 01771F41

*NID 24 [Jack] Mic at Ext Front*
Node - 0x18
Pin Default - 0x02a19c40
*Verb* - 01871C40 01871D9C 01871EA1 01871F02

*NID 25 [N/A] Speaker at Ext Rea*r
Node - 0x19
Pin Default - 0x411111f0
*Verb* - 01971CF0 01971D11 01971E11 01971F41

*NID 26 [Jack] Line In at Ext Front*
Node - 0x1A
Pin Default - 0x02813441
*Verb* - 01A71C41 01A71D34 01A71E81 01A71F02

*NID 27 [N/A] Speaker at Ext Rear*
Node - 0x1B
Pin Default - 0x411111f0
*Verb* - 01B71CF0 01B71D11 01B71E11 01B71F41

*NID 28 [N/A] Speaker at Ext Rear*
Node - 0x1C
Pin Default - 0x411111f0
*Verb* - 01C71CF0 01C71D11 01C71E11 01C71F41

*NID 29 [N/A] Speaker at Ext Rear*
Node - 0x1D
Pin Default - 0x4016852d
*Verb* - 01D71C2D 01D71D85 01D71E16 01D71F40

*NID 30 [Jack] SPDIF Out at Ext Front*
Node - 0x1E
Pin Default - 0x02451120
*Verb* - 01E71C20 01E71D11 01E71E45 01E71F02

*NID 31 [N/A] Speaker at Ext Rear*
Node - 0x1F
Pin Default - 0x411111f0
*Verb* - 01F71CF0 01F71D11 01F71E11 01F71F41

Any use of these?

Regards,
Karthik


On Mon, May 18, 2009 at 2:22 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 17 May 2009 17:48:08 -0300,
> Emilio L=F3pez wrote:
> >
> > I seem to have the same card looking at lspci -v, and I experience the
> same
> > problems. My laptop is an Acer Aspire 6930, so maybe the Acer bioses are
> > broken? I got the sound to work (with the controls mapped uncorrectly),
> but I
> > still can't make the mic work. I'll try with that model, I also tried
> with
> > acer and acer-aspire with no luck.
>
> The latest snapshot driver (or alsa-driver 1.0.20) should work as is
> (although not sure about mic-in).  It's basically mapping the model to
> model=3Dacer-aspire-4930g
>
> The snapshot driver tarball is:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-s=
napshot.tar.gz
>
>
> Takashi
>
