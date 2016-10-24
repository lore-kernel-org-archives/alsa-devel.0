From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 1/6] ASoC: cs42xx8: Mark chip ID as
 volatile and remove cache bypass
Date: Mon, 24 Oct 2016 07:55:52 -0500
Message-ID: <1ab9e989-7218-43d9-85f6-d50aa807170a@EX4.ad.cirrus.com>
References: <1477302949-28049-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A5D42667E7
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 14:55:55 +0200 (CEST)
In-Reply-To: <1477302949-28049-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Oct 2016, Charles Keepax wrote:

> Rather than manually enabling cache bypass when reading the ID registers
> simply mark them as volatile. The old code worked this is simply the
> more standard way to implement this. There is a comment included in the
> code that claims the chip ID register also contains the right input
> volume, however this is clearly not the case from the rest of the
> driver. Further investigation reveals exactly the same comment in the
> wm8962 driver, where this is the case, so this is almost certainly a
> copy and paste error from when the driver was created.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
For the series
<Acked-by: Brian Austin <brian.austin@cirrus.com>
