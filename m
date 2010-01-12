From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: ASoC updates for 2.6.34
Date: Tue, 12 Jan 2010 16:12:41 +0200
Message-ID: <201001121612.41952.peter.ujfalusi@nokia.com>
References: <20100112132002.GC1418@rakim.wolfsonmicro.main>
	<s5hockzmo1t.wl%tiwai@suse.de>
	<20100112140936.GH1418@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B4121038A6
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 15:13:07 +0100 (CET)
In-Reply-To: <20100112140936.GH1418@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 12 January 2010 16:09:37 ext Mark Brown wrote:
> On Tue, Jan 12, 2010 at 02:48:46PM +0100, Takashi Iwai wrote:
> > Other low-hanging fruits:
> >
> >   sound/soc/codecs/da7210.c:499: warning: 'da7210_i2c_remove' defined b=
ut
> > not used sound/soc/codecs/tlv320dac33.c:1349: warning: 'dac33_i2c_remov=
e'
> > defined but not used sound/soc/codecs/tpa6130a2.c:483: warning:
> > 'tpa6130a2_remove' defined but not used
> >
> > Should be easily fixed by adding __devexit (and better with __devinit)
> > properly.
> =

> What config do you use to generate these warnings?  None of mine
> generate them.

I have not seen them either, but I will send a patch for the tpa and dac33,=
 and =

add the __devexit and __devinit to *_probe *_remove.

-- =

P=E9ter
