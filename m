From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: ASoC: Make ams-delta/cx20442 pair back working for
	multi-component
Date: Wed, 11 Aug 2010 10:00:00 +0300
Message-ID: <201008111000.00580.peter.ujfalusi@nokia.com>
References: <201008110129.34662.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 8626210384A
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 09:00:05 +0200 (CEST)
In-Reply-To: <201008110129.34662.jkrzyszt@tis.icnet.pl>
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
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: alsa-devel@alsa-project.org

Hello Janusz!

Since you have not sent patch for the OMAP McBSP part, I assume that it is =

working correctly on OMAP1.
Thanks for taking time for testing it!

On Wednesday 11 August 2010 02:29:32 ext Janusz Krzysztofik wrote:
> 1.
> After a static codec pointer removal from the sound/soc/codecs/cx20442.c
> code, both codec and card specific tty line discipline functions lost
> their access to the codec structure data. Arrange for passing the pointer
> back to the codec tty ldisc bits from the card initialization code.
> =

> 2.
> Update incosistent codec device naming in the card code.
> =

> 3.
> Since a new element, control_data, has been added to the cx20442_priv
> structure, it looks like the old snd_soc_codec->control_data may be
> scheduled for removal. To avoid problems in the near future, use the
> cx20442_priv->control_data instead of the snd_soc_codec->control_data
> throughout the cx20442 code.

I believe that the snd_soc_codec->control_data is not going away, the =

control_data in the private struct is used to pass this information from bu=
s =

probe to soc probe within the private structure.
If I'm not wrong, the reasoning is that sever chip can have I2C/SPI/etc con=
trol =

interfaces, and in this way the soc does not need to know anything about it=
, =

since the probe for the used bus will set the needed things for later use.
I might misunderstood something, Mark or Liam will correct me for sure ;)

> In the ams-delta card code, check for the
> snd_soc_codec->hw_write not NULL instead of the
> snd_soc_codec->control_data.
> =

> Created and tested on Amstrad Delta against
> git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git,
> commit a212dd5b2e1da045cbf423c70c87f48265531de4.


-- =

P=E9ter
