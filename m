From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Triggering a DAPM widget event
Date: Wed, 26 Jan 2011 20:43:07 +0000
Message-ID: <20110126204307.GA3744@opensource.wolfsonmicro.com>
References: <39D4D143FC30524CAB784A72ADFECEEE34A0BC92CA@NLCLUEXM02.connect1.local>
	<20110126165347.GB10759@sirena.org.uk>
	<39D4D143FC30524CAB784A72ADFECEEE34A0E8F3DF@NLCLUEXM02.connect1.local>
	<20110126182754.GJ8501@opensource.wolfsonmicro.com>
	<39D4D143FC30524CAB784A72ADFECEEE34A0E8F455@NLCLUEXM02.connect1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9C133103A7A
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 21:43:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <39D4D143FC30524CAB784A72ADFECEEE34A0E8F455@NLCLUEXM02.connect1.local>
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

On Wed, Jan 26, 2011 at 09:38:53PM +0100, Harrod, John wrote:

As previously mentioned please fix your mail client to word wrap mails
within paragraphs so that they are legible.

> > What is your actual problem here?

> I have a speaker widget (snd_soc_dapm_spk) whose event handler only receives a
> SND_SOC_DAPM_PRE_PMD event when the pcm is closed.

Why is this a problem?  As I said in my previous e-mail if you don't
stop playing audio the kernel will of course keep power up on the output
path from the DAC.
