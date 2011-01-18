From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix race condition in widgets
 power list creation
Date: Tue, 18 Jan 2011 13:23:11 +0000
Message-ID: <20110118132310.GK26498@opensource.wolfsonmicro.com>
References: <1295318127-17968-1-git-send-email-misael.lopez@ti.com>
	<20110118103954.GA26498@opensource.wolfsonmicro.com>
	<4D357B09.70505@nokia.com>
	<20110118113956.GE26498@opensource.wolfsonmicro.com>
	<4D3582D3.40105@nokia.com>
	<20110118122605.GG26498@opensource.wolfsonmicro.com>
	<4D358BD5.4010207@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E0B3103840
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 14:23:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D358BD5.4010207@nokia.com>
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
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 18, 2011 at 02:47:17PM +0200, Peter Ujfalusi wrote:

> But I think the snd_soc_dapm_sync call in soc_post_component_init can be
> removed, since it has been taken care of the snd_soc_dapm_new_widgets
> call...

Yes.
