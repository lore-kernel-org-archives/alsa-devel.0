From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ASoC: Fix the power update function
	for snd_soc_dapm_value_mux
Date: Thu, 15 Jan 2009 12:52:17 +0000
Message-ID: <20090115125216.GE2147@sirena.org.uk>
References: <1232023247-21480-1-git-send-email-peter.ujfalusi@nokia.com>
	<1232023247-21480-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 059D810385F
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 13:52:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1232023247-21480-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

")
Fcc: +sent-mail

On Thu, Jan 15, 2009 at 02:40:47PM +0200, Peter Ujfalusi wrote:
> Modify the check for the mux type to also handle the
> snd_soc_dapm_value_mux type in a same way as the snd_soc_dapm_mux.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

This should go to 2.6.29, I'll send to Takashi later.
