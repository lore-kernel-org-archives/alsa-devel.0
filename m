From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: wm8741: Allow master
	clock	switching
Date: Mon, 8 Jun 2015 10:13:27 +0100
Message-ID: <20150608091327.GC32730@opensource.wolfsonmicro.com>
References: <1433582748-30086-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 95BFF26063F
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 11:13:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1433582748-30086-1-git-send-email-ce3a@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 06, 2015 at 11:25:48AM +0200, Sergej Sawazki wrote:
> The set of supported sample rates depends on the master clock supplied
> to the codec. Allow the machine driver to set the required master clock
> in hw_params().
> 
> Signed-off-by: Sergej Sawazki <ce3a@gmx.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
