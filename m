From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/3] ASoC: Blackfin: add
	multi-channel	supporting in Blackfin ASoC driver and AD1980
	codec driver
Date: Tue, 21 Oct 2008 11:19:39 +0100
Message-ID: <20081021101938.GJ10841@sirena.org.uk>
References: <1224560173-8728-1-git-send-email-cooloney@kernel.org>
	<1224560173-8728-3-git-send-email-cooloney@kernel.org>
	<20081021083715.GA10841@sirena.org.uk>
	<0F1B54C89D5F954D8535DB252AF412FA02E66236@chinexm1.ad.analog.com>
	<20081021091550.GE10841@sirena.org.uk>
	<0F1B54C89D5F954D8535DB252AF412FA02E662B0@chinexm1.ad.analog.com>
	<s5hhc762sp1.wl%tiwai@suse.de>
	<0F1B54C89D5F954D8535DB252AF412FA02E662F8@chinexm1.ad.analog.com>
	<s5hd4hu2rna.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 38765103807
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 12:19:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd4hu2rna.wl%tiwai@suse.de>
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
Cc: "Cai, Cliff" <Cliff.Cai@analog.com>, Bryan Wu <cooloney@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 21, 2008 at 12:01:45PM +0200, Takashi Iwai wrote:
> Cai, Cliff wrote:

> BTW, are your changes to ad1980.c applicable unconditionally?
> For example,
> > --- a/sound/soc/codecs/ad1980.c
> > +++ b/sound/soc/codecs/ad1980.c
> > @@ -145,7 +145,7 @@ struct snd_soc_dai ad1980_dai = {
> >  	.playback = {
> >  		.stream_name = "Playback",
> >  		.channels_min = 2,
> > -		.channels_max = 2,
> > +		.channels_max = 6,

> This won't work if the machine side doesn't support the
> multi-channel.  Right now, blackfin is the only one, but the codec
> driver should be generic.

This is fine - the ASoC core does constraint checks so if the controller
doesn't support the extra channels user space will never be told about
them.
