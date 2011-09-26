From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/10] ASoC: twl6040: Move delayed_work
 struct inside twl6040_output for HS/HF
Date: Mon, 26 Sep 2011 22:23:46 +0100
Message-ID: <20110926212346.GC2872@opensource.wolfsonmicro.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
	<1317043593-27202-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 94AB0245E3
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 23:23:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317043593-27202-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 26, 2011 at 04:26:26PM +0300, Peter Ujfalusi wrote:
> The delayed works for the output can be moved within the
> twl6040_output struct (from the twl6040_data) to be better
> organized.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applied, thanks.
