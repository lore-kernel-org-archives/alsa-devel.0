From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_writei() return value
Date: Mon, 25 May 2009 09:49:04 +0200
Message-ID: <4A1A4D70.4050903@ladisch.de>
References: <8235e6f40905211026x15a45c05p3061cfb323b329a6@mail.gmail.com>	<alpine.LNX.2.00.0905212006040.4067@eeebox2.perex-int.cz>
	<8235e6f40905211126y52ce14e9w42d81aa10f5e064@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A0548103800
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 09:49:11 +0200 (CEST)
In-Reply-To: <8235e6f40905211126y52ce14e9w42d81aa10f5e064@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cristian Morales Vega <cmorve69@yahoo.es>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cristian Morales Vega wrote:
> But if an interrupt happened, it could be that some samples were
> written and others no, true? If only -EINTR is returned, how I know
> how many of them I still need to write?

If any samples have been written successfully, snd_pcm_writei() returns
that number of samples.  You get a negative result only if no samples
have been written.


HTH
Clemens
