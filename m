From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [patch] ASoC: wm_adsp: memory leak in
	wm_adsp_create_control()
Date: Tue, 14 May 2013 13:34:18 +0100
Message-ID: <20130514123418.GA13656@opensource.wolfsonmicro.com>
References: <20130514120244.GA27826@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E126261B33
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 14:34:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130514120244.GA27826@elgon.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 14, 2013 at 03:02:44PM +0300, Dan Carpenter wrote:
> There are two return paths which don't kfree(name).
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks good.

Thanks,
Dimitris
