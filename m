From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/3][RFC] ASoC: pxa-ssp: Use 16-bit DMA	for
	magician stereo
Date: Thu, 12 Mar 2009 15:57:51 +0000
Message-ID: <20090312155751.GD24376@sirena.org.uk>
References: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E78A4103896
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2009 16:57:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 11, 2009 at 07:16:58PM +0100, Philipp Zabel wrote:
> Please advise how this behaviour could be made configurable. I guess
> the only machines that will ever need this are HTC Magician, Blueangel
> and Himalaya.

Mmm...  fun.  :/

For configurability I'd suggest using one of the ops that the DAI
exports to allow you to flip a variable somewhere.  That variable can
then be checked instead of your machine_is_() check.  Not terribly nice
but as you say I don't see this being needed terribly often.
