From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Fix typo
	in	twl4030_codec_mute function
Date: Fri, 8 May 2009 12:15:07 +0100
Message-ID: <20090508111506.GA19865@sirena.org.uk>
References: <1241695920-24509-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8017024940
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 13:15:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1241695920-24509-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 07, 2009 at 02:32:00PM +0300, Peter Ujfalusi wrote:
> Copy-paste error: TWL4030_PRECKL_GAIN >> TWL4030_PRECKR_GAIN
> It has not caused problems, since
> TWL4030_PRECKL_GAIN == TWL4030_PRECKR_GAIN == 0x30

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Applied, thanks.
