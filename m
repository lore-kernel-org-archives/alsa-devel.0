From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Where can I find some info about the DAI?
Date: Mon, 8 Sep 2008 10:47:33 +0100
Message-ID: <20080908094733.GB790@sirena.org.uk>
References: <48C4EA43.2090607@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CBC3E244D8
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 11:47:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48C4EA43.2090607@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 08, 2008 at 11:02:59AM +0200, Sedji Gaouaou wrote:

> I am trying to write a DAI.
> I am working with a wolfson wm8731 and an atmel at91sam9g20. Basically I 
> had a look at the file eti_b1_wm8731.c, but I would like to use another 
> ssc archi(atmel_ssc instead of at91_ssc).
> So I would like to know where should I find some info concerning the DAI.

There is some documentation in Documentation/sound/alsa/soc which may be
helpful.  It should also be useful to refer to existing drivers for
examples of how to do things - the PXA and S3C24xx architectures get
much of the attention here so are among the best places to look.

If you run into trouble please just ask here.
