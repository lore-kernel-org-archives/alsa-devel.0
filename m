From: Liam Girdwood <lrg@ti.com>
Subject: Re: ASoC: dpcm: Add debugFS support for DPCM
Date: Mon, 30 Apr 2012 11:05:07 +0100
Message-ID: <1335780307.6161.0.camel@odin>
References: <20120429135125.GA19737@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id C3C26104066
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 12:05:11 +0200 (CEST)
Received: by werm13 with SMTP id m13so2060383wer.40
	for <alsa-devel@alsa-project.org>; Mon, 30 Apr 2012 03:05:09 -0700 (PDT)
In-Reply-To: <20120429135125.GA19737@elgon.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2012-04-29 at 16:51 +0300, Dan Carpenter wrote:
> Hello Liam Girdwood,
> 
> The patch f86dcef87b77: "ASoC: dpcm: Add debugFS support for DPCM" 
> from Apr 25, 2012, leads to the following Smatch warning:
> sound/soc/soc-core.c:1221 soc_post_component_init()
> 	 error: potential null derefence 'dai_link'.
> 

Fix sent to list.

Thanks

Liam
