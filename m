From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: wm8903: Improve two size
 determinations in wm8903_i2c_probe()
Date: Fri, 24 Nov 2017 10:10:43 +0000
Message-ID: <20171124101043.mtsf6rcza3b4eews@localhost.localdomain>
References: <d4ce14fa-42a4-c911-3e0a-f2dd5cde6c14@users.sourceforge.net>
 <013d9ad7-a8ff-6fad-ba82-40e68cf0a601@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id B1ABA266DE5
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 11:10:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <013d9ad7-a8ff-6fad-ba82-40e68cf0a601@users.sourceforge.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Linus Walleij <linus.walleij@linaro.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 24, 2017 at 10:55:31AM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 24 Nov 2017 10:40:43 +0100
> 
> Replace the specification of two data structures by pointer dereferences
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
