From: Timur Tabi <timur@freescale.com>
Subject: Re: I don't understand snd_pcm_ops
Date: Tue, 22 May 2007 11:17:08 -0500
Message-ID: <46531784.70308@freescale.com>
References: <20070519000407.DCE031CE303@ws1-6.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id E36C824484
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2007 18:17:11 +0200 (CEST)
In-Reply-To: <20070519000407.DCE031CE303@ws1-6.us4.outblaze.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ash Willis <ashwillis@programmer.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ash Willis wrote:

> Have you read "Writing an ALSA driver"? It generally describes ALSA drivers as
> they relate to PCI, and how to write them, but it does a good job at explaining
> the general ALSA driver architecture.

Unfortunately, most of my confusion stems from ASoC-specific issues.  For instance, that 
document says I should call snd_pcm_new().  But that's not true for ASoC drivers, because 
I should really call snd_soc_new_pcms(), which in turn calls soc_new_pcm(), and *that* 
function calls snd_pcm_new().  However, none of that explains why it's the *codec* driver 
that is calling these functions.  I don't understand why the codec driver is registering 
new PCMs.  Shouldn't the PCM driver be registering the codec?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
