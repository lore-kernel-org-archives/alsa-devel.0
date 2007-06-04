From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Alsa-OSS Duplex bug (revisited)
Date: Mon, 04 Jun 2007 10:45:18 +0200
Message-ID: <1180946718.26554.1193268319@webmail.messagingengine.com>
References: <200705272323.13056.gineera@aspect135.co.uk>
	<200705312200.25483.gineera@aspect135.co.uk>
	<s5h8xb4c80t.wl%tiwai@suse.de>
	<200706032055.27495.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 91B3A2453A
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2007 10:45:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200706032055.27495.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Alan Horstmann wrote:
> So that there is no misunderstanding, are you willing to confirm that, as far 
> as Alsa-OSS goes, opening both
> 	input_handle = open("/dev/dsp", O_RDONLY)
> and
> 	output_handle = open("/dev/dsp", O_WRONLY)
> at the same time is a reliable way to open the device bi-directional, enabling 
> different sample formats and/or numbers of channels to be set?  (Actually, I 
> am curious whether different sample rates would also work?)

Yes; yes.

This is the _only_ way.  If the hardware supports it, any driver (not
only ALSA) has no choice but to support this.


Regards,
Clemens
