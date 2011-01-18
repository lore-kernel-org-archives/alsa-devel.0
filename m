From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix race condition in widgets
 power list creation
Date: Tue, 18 Jan 2011 13:22:24 +0000
Message-ID: <20110118132223.GJ26498@opensource.wolfsonmicro.com>
References: <1295318127-17968-1-git-send-email-misael.lopez@ti.com>
	<20110118113956.GE26498@opensource.wolfsonmicro.com>
	<4D3582D3.40105@nokia.com>
	<201101181434.13937.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 66DAB103840
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 14:22:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201101181434.13937.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 18, 2011 at 02:34:13PM +0200, Peter Ujfalusi wrote:

> Or not.. soc-jack.c:snd_soc_jack_report also calls snd_soc_dapm_sync, while 
> keeping the codec->mutex locked...
> Should machine drivers also take the mutex when they call snd_soc_dapm_sync?

In general yes.
