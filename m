From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: quick question, BT codec???
Date: Wed, 22 Oct 2008 09:48:55 +0100
Message-ID: <20081022084854.GA7640@sirena.org.uk>
References: <520f0cf10810220136h7d9d1877tbbaa7f4f956be97d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FF33244D7
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 10:49:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <520f0cf10810220136h7d9d1877tbbaa7f4f956be97d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Kacur <jkacur@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 22, 2008 at 10:36:40AM +0200, John Kacur wrote:
> Hello, quick question, both s3c24xx-pcm.c and pxa2xx-pcm.c contain the
> following comment and code segment, what does the "BT codec" refer to?

> /* return if this is a bufferless transfer e.g.
> 	 * codec <--> BT codec or GSM modem -- lg FIXME */
> if (!dma)
> 	return 0;

A bluetooth codec.
