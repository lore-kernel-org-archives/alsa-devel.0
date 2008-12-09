From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/9] ASoC: TWL4030: DAPM mapping of the
	Earpiece output
Date: Tue, 9 Dec 2008 10:03:07 +0000
Message-ID: <20081209100307.GC1630@sirena.org.uk>
References: <1228805151-29385-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228805151-29385-2-git-send-email-peter.ujfalusi@nokia.com>
	<1228805151-29385-3-git-send-email-peter.ujfalusi@nokia.com>
	<1228805151-29385-4-git-send-email-peter.ujfalusi@nokia.com>
	<1228805151-29385-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B895F10380E
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 11:03:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1228805151-29385-5-git-send-email-peter.ujfalusi@nokia.com>
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

On Tue, Dec 09, 2008 at 08:45:46AM +0200, Peter Ujfalusi wrote:

> +static const char *twl4030_earpiece_texts[] =
> +		{"Off", "DACL1", "DACL2", "Invalid",
> +		"DACR1"};

...

> +	/* Internal playback routings */
> +	/* Earpiece */
> +	{"Earpiece Mux", "DACL1 Switch", "ARXL1_APGA"},
> +	{"Earpiece Mux", "DACL2 Switch", "ARXL2_APGA"},
> +	{"Earpiece Mux", "DACR1 Switch", "ARXR1_APGA"},

These are now out of sync with each other.
