From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm5102: Initialize dac_comp_lock
	mutex
Date: Mon, 8 Dec 2014 09:11:55 +0000
Message-ID: <20141208091155.GC14516@opensource.wolfsonmicro.com>
References: <1417810119-7772-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8BBF2260450
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 10:11:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1417810119-7772-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 05, 2014 at 08:08:39PM +0000, Mark Brown wrote:
> Commit d74bcaaeb6682 (ASoC: wm5102: Move ultrasonic response settings
> lock to the driver level) created a driver local mutex for protecting
> the ultrasonic response settings but neglected to initialize that mutex,
> causing loud complaints from lockep and potential runtime failures. Fix
> this by initializing the mutex.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
