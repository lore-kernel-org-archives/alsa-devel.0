From: "Adrian McMenamin" <adrianmcmenamin@gmail.com>
Subject: Re: Effect of CONFIG_SND_PCM_OSS_PLUGINS
Date: Fri, 27 Jul 2007 10:50:29 +0100
Message-ID: <92a12cdb0707270250h1598cdbel20dc1f13c9dc346@mail.gmail.com>
References: <92a12cdb0707241530h3703a721md7bceeac2cd3144a@mail.gmail.com>
	<1185345398.10658.1201916763@webmail.messagingengine.com>
	<92a12cdb0707261400u624be88av154447e7ea5be081@mail.gmail.com>
	<1185517283.21908.1202305699@webmail.messagingengine.com>
	<92a12cdb0707270015n712854ceg6fe93bb41fa6153f@mail.gmail.com>
	<s5hd4yew5dw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by alsa0.perex.cz (Postfix) with ESMTP id D437C24430
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Jul 2007 11:50:30 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id d32so1482913pye
	for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2007 02:50:29 -0700 (PDT)
In-Reply-To: <s5hd4yew5dw.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 27/07/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 27 Jul 2007 08:15:13 +0100,
> Adrian McMenamin wrote:
> >
> > On 27/07/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> > > Adrian McMenamin wrote:
> > > > On 25/07/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> > > > > Well, your driver does support S16_LE, doesn't it?
> > > >
> > > > I think so
> > > >
> > > > .formats =
> > > >           (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |
> > > >            SNDRV_PCM_FMTBIT_IMA_ADPCM),
> > >
> > > Looks OK.
> > >
> > > What are the other snd_pcm_hardware settings?
> > >
> >
> > static struct snd_pcm_hardware snd_pcm_aica_playback_hw = {
> >       .info = (SNDRV_PCM_INFO_NONINTERLEAVED),
>
> This one.
>
Sorry. "This one" what? Is this the reason why mpg123 has difficulties
without the plugin? As long as it is not a fault with the driver as
opposed to a reflection of the hardware, then I am happy.
