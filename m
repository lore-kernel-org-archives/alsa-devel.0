From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Check the
	interface	format for 4 channel mode
Date: Mon, 1 Jun 2009 23:59:12 +0100
Message-ID: <20090601225911.GB5807@sirena.org.uk>
References: <1243854400-20902-1-git-send-email-peter.ujfalusi@nokia.com>
	<1243854400-20902-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B7D72438C
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 00:59:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1243854400-20902-2-git-send-email-peter.ujfalusi@nokia.com>
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

On Mon, Jun 01, 2009 at 02:06:40PM +0300, Peter Ujfalusi wrote:
> In addition to the operating mode check, also check the
> codec's interface format in case of four channel mode.
> If the codec is not in TDM (DSP_A) mode, return with error.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Applied, thanks.
