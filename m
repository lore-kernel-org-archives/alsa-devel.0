From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASoC: cs4265: Add a MIC pre. route
Date: Tue, 25 Sep 2018 09:07:56 +0100
Message-ID: <20180925080756.GO1653@imbe.wolfsonmicro.main>
References: <20180925064018.5484-1-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A746267736
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2018 10:07:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180925064018.5484-1-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, brian.austin@cirrus.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 25, 2018 at 04:40:18PM +1000, Matt Flax wrote:
> The cs4265 driver is missing a microphone preamp enable.
> This patch enables/disables the microphone preamp when mic
> selection is made using the kcontrol.
> 
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> 
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
