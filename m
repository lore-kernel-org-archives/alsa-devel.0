From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm2000: Remove wm2000_read helper
 function
Date: Sun, 21 Oct 2018 08:31:06 +0100
Message-ID: <20181021073106.GP1653@imbe.wolfsonmicro.main>
References: <20181019164422.26234-1-tanureal@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id C0F992677D0
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2018 09:31:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20181019164422.26234-1-tanureal@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lucas Tanure <tanureal@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 19, 2018 at 05:44:22PM +0100, Lucas Tanure wrote:
> The return type "unsigned int" was used by the wm2000_read()
> function despite of the aspect that it will eventually return
> a negative error code.
> The resulting function doesn't add much to the code, so replace
> wm2000_read with regmap_read.
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
