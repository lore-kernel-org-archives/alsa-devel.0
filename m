From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ALSA: ASoC: fix raumfeld platform
Date: Tue, 24 May 2011 13:16:30 +0100
Message-ID: <4DDBA19E.3080904@ti.com>
References: <1306239032-7951-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 83914103809
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 14:16:36 +0200 (CEST)
In-Reply-To: <1306239032-7951-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 24/05/11 13:10, Daniel Mack wrote:
> Commit f0fba2ad (ASoC: multi-component - ASoC Multi-Component Support)
> broke support for Raumfeld platforms as it didn't take into account the
> different hardware features on individual devices.
> 
> In particular, Raumfeld speakers have no S/PDIF output, so the members
> of the snd_soc_card struct must be set dynamically.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>

Acked-by: Liam Girdwood <lrg@ti.com>
