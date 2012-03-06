From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: When closing the port
 select PRCM source for CLKS signal
Date: Tue, 06 Mar 2012 14:44:08 +0000
Message-ID: <1331045048.16239.1.camel@odin>
References: <1330940332-16188-1-git-send-email-peter.ujfalusi@ti.com>
	<CANOLnOOzXycmiESekOz4s305KFV0SPLSJHQ5M2aFgBVwY-dJmQ@mail.gmail.com>
	<4F5608EC.9070406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75])
	by alsa0.perex.cz (Postfix) with ESMTP id F2F58103CC0
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 15:44:13 +0100 (CET)
Received: by wicr5 with SMTP id r5so2694126wic.31
	for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2012 06:44:10 -0800 (PST)
In-Reply-To: <4F5608EC.9070406@ti.com>
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
Cc: alsa-devel@alsa-project.org, Brown <broonie@opensource.wolfsonmicro.com>, Grazvydas Ignotas <notasas@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-03-06 at 14:54 +0200, Peter Ujfalusi wrote:
> Hi,
> 
> On 03/05/2012 02:51 PM, Grazvydas Ignotas wrote:
> > I guess this depends on mcbsp move series?
> > Do we have those queued somewhere, so I don't have to collect patches
> > from the list?
> 
> You can apply this patch on top of my for-3.4 branch which I have just
> updated on top of Liam's for-3.4 branch:
> 
> git@gitorious.org:omap-audio/linux-audio.git peter/topic/for-3.4
> 

I've now applied these patches on top of my for-3.4.

Regards

Liam
