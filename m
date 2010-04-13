From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.34
Date: Tue, 13 Apr 2010 09:34:34 +0100
Message-ID: <20100413083434.GA22320@sirena.org.uk>
References: <20100405183840.GA2688@rakim.wolfsonmicro.main>
	<20100412113158.GV30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A89E6103869
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 10:34:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100412113158.GV30801@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 12, 2010 at 01:31:58PM +0200, Daniel Mack wrote:

> Do you think it is safe to push this ASoC-DMA patch to stable@ as well?
> I posted backported version already and I believe they're fine.

I don't think that's a good idea.  Since this changes the API
incompatibily it will cause any out of tree users tracking the tree to
break which isn't the sort of update that seems suitable for a stable
update.  I'm not concerned about the code quality, it's just the simple
fact of the interface change.
