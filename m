From: Keith Chew <keith.chew@gmail.com>
Subject: Re: 5.1 surround on 3 jacks (retasking)
Date: Tue, 31 Aug 2010 08:58:19 +1200
Message-ID: <AANLkTi=pz17YOHGbTUWSBhPB22LXTA3h8PkvEAQxGr=k@mail.gmail.com>
References: <AANLkTin3DKSRuUZwARAadMTVPTrj17eHK8557bCsb3YM@mail.gmail.com>
	<4C75A7D9.1030604@canonical.com>
	<AANLkTinE8sjRWWsHYJYq1w_rLJu9Y91J4gs7k-Q_M3j-@mail.gmail.com>
	<4C76100C.3040205@canonical.com>
	<AANLkTimRwKPFohM46pOKXDmGbcbnCuGWX1VwwcGbk+6o@mail.gmail.com>
	<AANLkTinzKoqc7xDgU1r4yL4AxS4OwUPzkwQ3ieJuXA4h@mail.gmail.com>
	<4C792365.6050308@canonical.com>
	<AANLkTimYykihF=1vvzGhYbHYHPtxVMJK_hND=4hy+L4Z@mail.gmail.com>
	<s5haao48rnq.wl%tiwai@suse.de>
	<AANLkTinofprWnFLOTGDWfe_ucaezDgRzHwGTehaFDjLk@mail.gmail.com>
	<s5hzkw3x31v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D8F8244FC
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 22:58:21 +0200 (CEST)
Received: by iwn4 with SMTP id 4so5069745iwn.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 13:58:20 -0700 (PDT)
In-Reply-To: <s5hzkw3x31v.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>
> There are some restrictions for automatic parser. =A0The STAC/IDT
> parser supports dual headphones, but realtek one doesn't, so far.
> But, anyway 3 headphones are wrong.
>
> Note that by setting the pins to HP, you get the amp boost in the
> codec chip, but it doesn't mean it's better audio quality. =A0For
> line-outs, you shouldn't put such an amp usually.
>

I agree, the audio quality does sound a bit coarse compared to the
soundblaster's one. I have read the datasheet for both Realtek and SB,
and found the Realtek's maximum output voltage to be only 1.2Vrms,
where as the SB's one is 2Vrms. This explains why approx 60% of the SB
volume is the same as 100% volume on the ALC888. From the datasheet,
it also states the HP amp boost gives an extra 1Vrms, which also
confirms when I enable this, the volume is close to the SB's volume
(but the quality is not as good).

Thanks again for your input. I guess if I need to interface this
hardware with external speakers, I will need a better external
amplifier since the output voltage is lower.

Regards
Keith
