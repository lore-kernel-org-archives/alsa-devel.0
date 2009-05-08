From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Headset VMID ramp fix
Date: Fri, 8 May 2009 13:34:22 +0100
Message-ID: <20090508123422.GB12895@sirena.org.uk>
References: <1241763077-6851-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090508094044.0c85e86a.jhnikula@gmail.com>
	<200905081456.50445.peter.ujfalusi@nokia.com>
	<200905081514.18044.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B0881038CA
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 14:34:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200905081514.18044.peter.ujfalusi@nokia.com>
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, alsa-devel@alsa-project.org, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 08, 2009 at 03:14:17PM +0300, Peter Ujfalusi wrote:

> We could fixate the RAMP_DELAY to 0 (27/20/14 ms, MCLK = 19.2/26/38.4 MHz) and 
> add mdelay(28/21/15) in the headsetl_event function... But I'm not sure is it 
> allowed, at least it looks hackish. Mark?

A short delay there wouldn't be ideal but shouldn't break anything
either - the power down will be happening out of line after the pop wait
so it's not as critical as it might be.
