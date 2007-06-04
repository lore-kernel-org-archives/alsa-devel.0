From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Alsa-OSS Duplex bug (revisited)
Date: Mon, 4 Jun 2007 12:51:15 +0100
Message-ID: <200706041251.15237.gineera@aspect135.co.uk>
References: <200705272323.13056.gineera@aspect135.co.uk>
	<200706032055.27495.gineera@aspect135.co.uk>
	<1180946718.26554.1193268319@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (unknown [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 99A3824556
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2007 13:41:09 +0200 (CEST)
In-Reply-To: <1180946718.26554.1193268319@webmail.messagingengine.com>
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
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Monday 04 June 2007 09:45, you wrote:
> Alan Horstmann wrote:
> > So that there is no misunderstanding, are you willing to confirm that, as
> > far as Alsa-OSS goes, opening both
> > 	input_handle = open("/dev/dsp", O_RDONLY)
> > and
> > 	output_handle = open("/dev/dsp", O_WRONLY)
> > at the same time is a reliable way to open the device bi-directional,
> > enabling different sample formats and/or numbers of channels to be set? 
> > (Actually, I am curious whether different sample rates would also work?)
>
> Yes; yes.
>
> This is the _only_ way.  If the hardware supports it, any driver (not
> only ALSA) has no choice but to support this.
>

Thanks Clemens for confirming that, and your earlier inputs.

Alan
