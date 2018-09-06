From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] ASoC: sgtl5000: avoid division by zero if
	lo_vag is zero
Date: Thu, 6 Sep 2018 14:58:14 +0300
Message-ID: <20180906115814.a5woyhfc5sczxksa@mwanda>
References: <20180906104152.17977-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BF5426779A
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 13:58:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180906104152.17977-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 06, 2018 at 11:41:52AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where lo_vag <= SGTL5000_LINE_OUT_GND_BASE, lo_vag
> is set to zero and later vol_quot is computed by dividing by
> lo_vag causing a division by zero error.  Fix this by avoiding
> a zero division and set vol_quot to zero in this specific case
> so that the lowest setting for i is correctly set.
> 

This is a very clever patch.  How did you find the bug?

regards,
dan carpenter
