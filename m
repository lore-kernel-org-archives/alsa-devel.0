From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Triggering a DAPM widget event
Date: Wed, 26 Jan 2011 16:53:47 +0000
Message-ID: <20110126165347.GB10759@sirena.org.uk>
References: <39D4D143FC30524CAB784A72ADFECEEE34A0BC92CA@NLCLUEXM02.connect1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 66B342458F
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 17:53:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <39D4D143FC30524CAB784A72ADFECEEE34A0BC92CA@NLCLUEXM02.connect1.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harrod, John" <john.harrod@philips.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 25, 2011 at 05:53:13PM +0100, Harrod, John wrote:

Please CC maintianers on mails, things on mailing lists get lost easily.
Please also fix your MUA to word wrap within paragraphs, I've reflowed
your mail below so I can read it.

> I have a program that uses the ALSA PCM interface to play sounds on an
> embedded system. Does anyone know how alsa-lib triggers a
> SND_SOC_DAPM_PRE_PMD widget event in DAPM core? On my system the event
> only gets called when the pcm is closed with snd_pcm_close(). Is there
> another function that can cause a widget shutdown?

A pre-powerdown even is generated before a DAPM widget is powered down.
This will happen whenever it ceases to be part of an active audio path.
This is not something that is visible at application layer.

> Or is opening and closing the PCM every time I want to play a sound a
> good practice for saving power?

You should never need to close application layer streams.  You should
stop data flowing on them when you are not transferring audio since
obviously even ignoring the CODEC power sitting DMAing data when you're
not playing audio is going to waste power.
