From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/9] ASoC: TWL4030: Add helper function for
	output gain controls
Date: Mon, 24 Nov 2008 13:57:35 +0000
Message-ID: <20081124135735.GF22394@sirena.org.uk>
References: <1227527383-22516-1-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-2-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-3-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-4-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 74BC610380A
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 14:57:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227527383-22516-5-git-send-email-peter.ujfalusi@nokia.com>
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

On Mon, Nov 24, 2008 at 01:49:38PM +0200, Peter Ujfalusi wrote:
> Some of the gain controls in TWL (mostly those which are associated with
> the outputs) are implemented in an interesting way:
>  0x0 : Power down (mute)
>  0x1 : 6dB
>  0x2 : 0 dB
>  0x3 : -6 dB
> Inverting not going to help with these.
> Custom volsw and volsw_2r get/put functions to handle these gains.

Applied.
