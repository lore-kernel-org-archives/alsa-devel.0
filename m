From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: EPIPE and underruns
Date: Mon, 4 Oct 2010 22:45:21 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010042241460.20467@eeebox2.perex-int.cz>
References: <AANLkTi=3phX8UtGd0wbrfv7gYHYYV1TitWE4bvm4CTAi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A8671038F1
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 22:45:21 +0200 (CEST)
In-Reply-To: <AANLkTi=3phX8UtGd0wbrfv7gYHYYV1TitWE4bvm4CTAi@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrew Bell <andrew.bell.ia@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 4 Oct 2010, Andrew Bell wrote:

> Hi,
>
> Can somebody explain precisely the circumstances leading to an EPIPE
> as the result of a pcm_snd_writei()?

Simply, the driver consumed all queued samples in the ring buffer.

> What buffer has been underrun that leads to this error?  Does
> providing more data to pcn_snd_writei() help alleviate the issue?

Yes, also the ring buffer size may be increased depending on the stream
parameter setup to prevent underruns.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
