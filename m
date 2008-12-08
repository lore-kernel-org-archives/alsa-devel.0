From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 5/8] ASoC: TWL4030: DAPM mapping of the
	PreDriv outputs
Date: Mon, 8 Dec 2008 11:28:48 +0000
Message-ID: <20081208112847.GE5159@sirena.org.uk>
References: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-2-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-3-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-4-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-5-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-6-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5077D103824
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 12:28:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1228723748-22911-6-git-send-email-peter.ujfalusi@nokia.com>
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

On Mon, Dec 08, 2008 at 10:09:05AM +0200, Peter Ujfalusi wrote:

> +static const char *twl4030_predrivel_texts[] =
> +		{"Off", "DACL1 Switch", "DACL2 Switch", "Invalid",
> +		"DACR2 Switch"};

Why the "Switch" in the option names - I'd expect to see it omitted.
Does the "Invalid" option work well in applications like alsamixer?
