From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: wm8731: Use the preferred form
	for passing a	size of a struct
Date: Wed, 29 Oct 2014 09:48:37 +0000
Message-ID: <20141029094837.GI23178@opensource.wolfsonmicro.com>
References: <1414162887-14279-1-git-send-email-festevam@gmail.com>
 <1414162887-14279-3-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 476EB2604AC
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 10:48:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1414162887-14279-3-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 24, 2014 at 01:01:27PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> According to Documentation/CodingStyle - Chapter 14:
> 
> "The preferred form for passing a size of a struct is the following:
> 
> 	p = kmalloc(sizeof(*p), ...); 
> 
> The alternative form where struct name is spelled out hurts readability and
> introduces an opportunity for a bug when the pointer variable type is changed
> but the corresponding sizeof that is passed to a memory allocator is not."
> 
> So do it as recommeded.
> 
> Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
