From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/4] ASoC: Use network mode with 2
	slots	for 16-bit stereo in pxa-ssp/Zylonite
Date: Tue, 3 Mar 2009 15:48:14 +0000
Message-ID: <20090303154813.GG27155@sirena.org.uk>
References: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A04ED103849
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 16:48:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
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

On Tue, Mar 03, 2009 at 04:10:51PM +0100, Philipp Zabel wrote:
> For consistency with 24-bit and 32-bit modes, don't send 16-bit stereo
> in one 32-bit transfer. Use 2 slots instead on Zylonite. It should result
> in exactly the same behaviour.

I've tested, it does indeed.

Applied, thanks.
