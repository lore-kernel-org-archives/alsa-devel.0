From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: omap3beagle: Add dai link for McBSP2
 master configuration (CLKS source)
Date: Tue, 28 Feb 2012 11:36:52 +0200
Message-ID: <4F4CA034.20309@bitmer.com>
References: <1330415714-5136-1-git-send-email-peter.ujfalusi@ti.com>
	<4F4C920A.4090606@bitmer.com> <4F4C9A2D.1010807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id A04B02415A
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 10:36:29 +0100 (CET)
In-Reply-To: <4F4C9A2D.1010807@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Steve Sakoman <steve@sakoman.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/28/2012 11:11 AM, Peter Ujfalusi wrote:
> On 02/28/2012 10:36 AM, Jarkko Nikula wrote:
>> Is this something that is better to stay in list archives not under
>> version control? This looks to me as a developer debug feature.
> 
> Good question...
> Right now I'm not sure if this patch has practical use at the moment.
> It does not hurt to be in the tree since the default PCM does not
> change. But it might confuse users.
> Either way is good for me.
> 
Related useful reference knowledge is mux settings for other McBSP pins
that are routed to beagle extension port pins. Might be good to have
those documented somewhere for system builders reference.

-- 
Jarkko
