From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 05/12] ASoC: twl6040: Simplify custom
	put_volsw callback
Date: Tue, 4 Oct 2011 16:26:00 +0100
Message-ID: <20111004152559.GL6934@opensource.wolfsonmicro.com>
References: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
	<1317728389-22062-6-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 18E29103960
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 17:26:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317728389-22062-6-git-send-email-peter.ujfalusi@ti.com>
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

On Tue, Oct 04, 2011 at 02:39:42PM +0300, Peter Ujfalusi wrote:
> Return -EINVAL in the unlikely event, if the function has been called
> for unhandled control. This way we can remove one check in the code.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

I'll apply this but as with the discussion with the Maxim devices the
other day it'd be better if there were some sort of loud warning if we 
ever hit the error case as it means that the CODEC driver is disagreeing
with itself.
