From: Maarten de Boer <maarten@resorama.com>
Subject: Re: problem with RME DSP MADI,
	kernel 2.6.38 and hdspmixer from git
Date: Sat, 10 Sep 2011 10:52:44 +0200
Message-ID: <B4E35651-AB19-447A-9521-7894D05A2BB3@resorama.com>
References: <59A59943-F67D-4ACD-94E5-95987CC46796@resorama.com>	<20110908150911.GU9510@ltw.loris.tv>	<0A02B5E2-4D1B-4445-B9F2-B4876CC8EEB2@resorama.com>	<3BBC0003-F165-4994-8950-CC7CF24FDD6C@resorama.com>
	<4E6A8440.9090000@drcomp.erfurt.thur.de>
	<4E6B1B76.7010303@drcomp.erfurt.thur.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
	[217.70.183.196])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F2EF24430
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Sep 2011 10:52:53 +0200 (CEST)
In-Reply-To: <4E6B1B76.7010303@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Natanael Olaiz <natanael.olaiz@immsound.com>, Pau Arumi <pau.arumi@immsound.com>
List-Id: alsa-devel@alsa-project.org

Hi Adrian,

Thanks for the reply.

> Forget all this, as I just learned, monitor out is 63/64

Yes, I know this. But I find it confusing that, just by opening hdspmixer
the first time after loading the snd-hdspm module, all channels get routed
to 63/64, as this happens "under the hood". I understand though that this
routing makes more sense than the initial setting where you only hear
channel 63 and 64. Looking at the hdspmixer code, I don't see when this
happens but I will investigate a bit more so I fully understand this.

> I don't know how familiar you are with hdspmixer, if in doubt, consult
> the README.

I am new to hdspmixer. I am looking for the TotalMix documentation now,
but your explanation below makes sense.

> What you might want to do: activate submix mode (either by pressing S or
> clicking on the appropriate menu items), then choose "63+64" below an
> input or playback fader, thus changing all faders to operate on 63+64.
> Adjust according to your needs.

Okay. Thanks again,

Maarten
