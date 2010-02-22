From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: On resume also check the
	soc	device state
Date: Mon, 22 Feb 2010 14:41:55 +0000
Message-ID: <20100222144155.GC27789@sirena.org.uk>
References: <1266838033-8087-1-git-send-email-peter.ujfalusi@nokia.com>
	<1266838332.3159.10.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B4DD810384A
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 15:41:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1266838332.3159.10.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 22, 2010 at 11:32:12AM +0000, Liam Girdwood wrote:
> On Mon, 2010-02-22 at 13:27 +0200, Peter Ujfalusi wrote:
> > Check the card->codec on soc_resume to detect if the soc
> > device is properly initialized.
> > If the card->codec is NULL, than do not continue the resume
> > operation, since the device is not initialized properly.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Applied, thanks.
