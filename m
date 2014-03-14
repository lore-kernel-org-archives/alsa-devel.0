From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs: Replace instances of
	rtd->codec with	dai->codec
Date: Fri, 14 Mar 2014 09:11:46 +0000
Message-ID: <20140314091146.GB1665@opensource.wolfsonmicro.com>
References: <1394742294-14698-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5F7E2264FF9
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 10:11:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1394742294-14698-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, Mark Brown <broonie@kernel.org>, M R Swami Reddy <mr.swami.reddy@ti.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 13, 2014 at 09:24:54PM +0100, Lars-Peter Clausen wrote:
> With CODEC to CODEC links rtd->codec does not necessarily point to the driver's
> CODEC. CODEC drivers should always use dai->codec and never even look at the PCM
> runtime.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

For the Wolfson bit:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
