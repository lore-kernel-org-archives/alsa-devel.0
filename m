From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: dmix and mmap
Date: Tue, 5 May 2009 12:32:43 +0100
Message-ID: <20090505113242.GB27386@sirena.org.uk>
References: <bb6204720904300810ma174b6cn825f8565c0b694c0@mail.gmail.com>
	<20090430151301.GA27605@sirena.org.uk>
	<bb6204720904301229q3b0b93eao28563ec7bdef73cb@mail.gmail.com>
	<20090501113240.GF6975@sirena.org.uk>
	<ed82fe3e0905040957l13e53319j57ddd1c1de902f92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4379324560
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 13:32:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ed82fe3e0905040957l13e53319j57ddd1c1de902f92@mail.gmail.com>
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
Cc: Gabriel Johnson <johnsoga@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 04, 2009 at 11:57:20AM -0500, Timur Tabi wrote:

> The PowerPC MPC8610 drivers enable mmap support, and it seems to work,
> but that chip has a coherent MMU.  I've never done a definitive test
> that it works, though.  What's the easiest way to test mmap?

If you had issues they'd be fairly obvious in the audio stream.
