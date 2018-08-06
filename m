From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm8994: Fix missing break in switch
Date: Mon, 6 Aug 2018 13:54:59 +0100
Message-ID: <20180806125459.GC32322@imbe.wolfsonmicro.main>
References: <20180806121451.GA14954@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 5472926770D
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 14:55:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180806121451.GA14954@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: alsa-devel@alsa-project.org, Valdis Kletnieks <valdis.kletnieks@vt.edu>, patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 06, 2018 at 07:14:51AM -0500, Gustavo A. R. Silva wrote:
> Add missing break statement in order to prevent the code from falling
> through to the default case.
> 
> Cc: stable@vger.kernel.org
> Addresses-Coverity-ID: 115050 ("Missing break in switch")
> Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
