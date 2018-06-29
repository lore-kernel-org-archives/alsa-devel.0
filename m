From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH RESEND] ASoC: pxa: remove the dmaengine
	compat need
Date: Fri, 29 Jun 2018 22:30:45 +0200
Message-ID: <871scpl4i2.fsf@belgarion.home>
References: <20180628200837.17957-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr
 [80.12.242.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 22A392675C8
 for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2018 22:30:47 +0200 (CEST)
In-Reply-To: <20180628200837.17957-1-daniel@zonque.org> (Daniel Mack's message
 of "Thu, 28 Jun 2018 22:08:37 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>, broonie@kernel.org
Cc: boris.brezillon@bootlin.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Mack <daniel@zonque.org> writes:

> From: Robert Jarzmik <robert.jarzmik@free.fr>
>
> As the pxa architecture switched towards the dmaengine slave map, the
> old compatibility mechanism to acquire the dma requestor line number and
> priority are not needed anymore.
>
> This patch simplifies the dma resource acquisition, using the more
> generic function dma_request_slave_channel().
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> Acked-by: Mark Brown <broonie@kernel.org>
Now I see it in Mark's tree.

Dropping from pxa/for-next.

Cheers.

--
Robert
