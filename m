From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: AC97 reset fail after suspend
Date: Fri, 8 May 2009 19:04:58 +0100
Message-ID: <20090508180458.GA11502@sirena.org.uk>
References: <200905080148.20137.sleep_walker@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BE9DB1038FA
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 20:04:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200905080148.20137.sleep_walker@suse.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomas 'Sleep_Walker' Cech <sleep_walker@suse.cz>
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Fri, May 08, 2009 at 01:48:19AM +0200, Tomas 'Sleep_Walker' Cech wrote:

> I also tried this with Treo680 (code will be sent soon). HW is very similar, 
> only codec is different - LD/T5/TX use WM9712, Treo680 use WM9713. On Treo680 
> there is no problem with that.

Do you mean that suspend and resume work on the Treo680?

Have you tried the non-ASoC AC97 driver?
