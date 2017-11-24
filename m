From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/4] ASoC: wm2000: One function call less
 in wm2000_i2c_probe() after error detection
Date: Fri, 24 Nov 2017 08:34:25 +0000
Message-ID: <20171124083425.jwjdppt4mpl55r4p@localhost.localdomain>
References: <cd76c876-81a5-3cf6-e7d9-52037729fb98@users.sourceforge.net>
 <e09f6361-8d58-c534-4aaa-cafb7f801726@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 3326F26726B
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 09:34:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <e09f6361-8d58-c534-4aaa-cafb7f801726@users.sourceforge.net>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 24, 2017 at 08:37:41AM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 24 Nov 2017 07:45:59 +0100
> 
> The release_firmware() function was called in a few cases by the
> wm2000_i2c_probe() function during error handling even if
> the passed variable contained a null pointer.
> 
> * Adjust jump targets according to the Linux coding style convention.
> 
> * Delete the label "out" and an initialisation for the variable "fw"
>   at the beginning which became unnecessary with this refactoring.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
