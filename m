From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 04/12] ASoC: twl6040: Simplify custom
	get_volsw callback
Date: Tue, 4 Oct 2011 16:31:28 +0100
Message-ID: <20111004153128.GN6934@opensource.wolfsonmicro.com>
References: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
	<1317728389-22062-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DAB2110399C
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 17:31:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317728389-22062-5-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 04, 2011 at 02:39:41PM +0300, Peter Ujfalusi wrote:
> The custom get_volsw does not need to call any core get_volsw calls,
> since we are returning the shadow values for the gains.
> Return -EINVAL in the unlikely event, if the function has been called
> for unhandled control. This way we can remove one check in the code.

This, and patch 5 also have an issue (they depend on patch 3 anyway).
