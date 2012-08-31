From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: correct the check for NULL
	dma_buffer pointer
Date: Fri, 31 Aug 2012 14:24:36 -0700
Message-ID: <20120831212435.GB5495@opensource.wolfsonmicro.com>
References: <1346383521-2990-1-git-send-email-prasadjoshi.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DB29A26648E
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 23:24:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1346383521-2990-1-git-send-email-prasadjoshi.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Prasad Joshi <prasadjoshi.linux@gmail.com>
Cc: alsa-devel@alsa-project.org, rajeev-dlh.kumar@st.com, tiwai@suse.de, linux-kernel@vger.kernel.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 31, 2012 at 08:55:21AM +0530, Prasad Joshi wrote:
> The if condition
> 	if (!buf && !buf->area)
> 
> checks if the buf pointer is NULL and then dereferences it again to
> check if the buffer area is NULL, resulting in possible NULL
> dereference.

Applied, thanks.
