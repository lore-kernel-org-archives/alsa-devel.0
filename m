From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: davinci_request_dma()
Date: Thu, 16 Oct 2008 10:08:11 +0100
Message-ID: <20081016090810.GA3539@sirena.org.uk>
References: <520f0cf10810160158y67c8330fg959f198d9026d680@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 16F7D10380D
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Oct 2008 11:08:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <520f0cf10810160158y67c8330fg959f198d9026d680@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 16, 2008 at 10:58:58AM +0200, John Kacur wrote:

[The ASoC DaVinci driver uses davinci_request_dma() but...]

> However, when I grep for davinci_request_dma, the only places I can
> find it are in davinci_pcm_dma_request itself!

...

> Either I'm missing something, or this code wouldn't even compile. I
> would appreciate any help in understanding this.

It was discovered a while ago that the code depends on an unmerged set
of DMA API updates.  See this thread for more info:

  http://mailman.alsa-project.org/pipermail/alsa-devel/2008-June/008674.html

To be honest, I had expected that the required updates would have been
merged by now but it seems not.  CCing the DaVinci list - I don't know
what the status is on merging the new DMA API?
