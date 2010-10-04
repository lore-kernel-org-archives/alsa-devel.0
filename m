From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl adds volume controls?
Date: Mon, 4 Oct 2010 19:09:11 +0800
Message-ID: <AANLkTi=zwH4CK+=eC-NaY+wTy-W90HiBFp7Vk67xN0Wk@mail.gmail.com>
References: <s5hr5hczi06.wl%tiwai@suse.de> <4C7F6D5D.7020101@canonical.com>
	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>
	<4C7FB2CF.5060505@ladisch.de>
	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>
	<4C7FC85B.4000009@ladisch.de>
	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>
	<i7viav$kjb$1@dough.gmane.org> <4CA46E98.10402@ladisch.de>
	<4CA4A844.7060403@colin.guthr.ie>
	<20100930164753.GB9431@sirena.org.uk>
	<s5hr5gb9k83.wl%tiwai@suse.de> <4CA5834D.5030408@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E8EC24430
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 13:09:12 +0200 (CEST)
Received: by eye27 with SMTP id 27so1816539eye.38
	for <alsa-devel@alsa-project.org>; Mon, 04 Oct 2010 04:09:12 -0700 (PDT)
In-Reply-To: <4CA5834D.5030408@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/10/1 Clemens Ladisch <clemens@ladisch.de>

> Takashi Iwai wrote:
> > Mark Brown wrote:
> > > On Thu, Sep 30, 2010 at 04:09:56PM +0100, Colin Guthrie wrote:
> > > > *shouldn't* use them, but at present it does and they *are* active
> and
> > > > used, so it's not an issue for me), the problem is rather one of
> setting
> > > > Master (not PCM) to 0% aka -46.5dB causes some kind of auto-mute that
> > > > cuts off all sound. It shouldn't do that.
> > >
> > > Is this perhaps just an error in the TLV information - should it be
> > > flagging that the minimim gain is mute but isn't?
> >
> > There is no clear (or consistent) definition in HD-audio codec, I guess.
>
> The HDA spec is quite clear that muting is done only with the mute bit.
>
> > Some chips do mute at 0 and some not.
>
> Those that do are violating the specification.
>
> But we have to support them anyway.
> Colin, please tell us the IDs of your codec so that we can add a TLV
> workaround to the driver.
>
>
> Regards,
> Clemens
>
>
Actually, the softvol plugin behave as the same way as Colin describe since
when the resolution is 2 , the softvol become a mute switch

http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=f78af4ab0412052aabb74c9122a8d8f3ab6d45e6

So the question is why -51dB is selected as min_dB

Is this value enough for S16_LE or  S32_LE for hda-intel ?

http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=eacbb9dba6b4c982a0217ea2c7d15db88d4fda37;hp=d91b424d6d7bda0773b6b6b606d48d089c4f5115

As those DACs support -120dB to 0dB , but the driver can actually limit the
dB range to -60dB to 0dB . so the minimum volume -60dB is definitly not mute
in this case

why -60dB is selected  ?
