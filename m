From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Unable to find an usable access for 'default'
Date: Tue, 10 Jul 2007 08:29:18 +0200
Message-ID: <1184048958.4318.1199353265@webmail.messagingengine.com>
References: <468ACB86.1040303@freescale.com>
	<1183530859.19025.1198427403@webmail.messagingengine.com>
	<468CE7AD.8020305@freescale.com>
	<1183719027.2620.1198799059@webmail.messagingengine.com>
	<468EC305.8080301@freescale.com>
	<1183963895.22813.1199147561@webmail.messagingengine.com>
	<4692A262.2080908@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 585982441A
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 08:29:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4692A262.2080908@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> Clemens Ladisch wrote:
> > This is possible.  Try using aplay with a .wav file that uses a sample
> > format supported by the hardware.
> 
> I tried that, and I'm still having problems.  Here's the output with rule debugging turned
> on.  I can't make sense of this, so could you interpret this for me?

The output shows that the application tries to set several parameters,
but never sets all parameters.

Please play to the "hw" device instead of the "default" one so that
alsa-lib doesn't try other sample formats.

It would help to tell me what the sample format of the file actually is.

And please show at least the struct snd_pcm_hardware definition of your
driver, together with any code that changes its filed and all calls to
snd_pcm_hw_constraint_*, if any.


Regards,
Clemens
