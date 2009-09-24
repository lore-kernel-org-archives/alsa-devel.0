From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 1/2] ASoC: DaVinci: Fix divide
 by	zero	error during 1st execution
Date: Wed, 23 Sep 2009 18:44:15 -0700
Message-ID: <4ABACEEF.8080000@boundarydevices.com>
References: <1252704543-25580-1-git-send-email-troy.kisky@boundarydevices.com>
	<20090923171039.GB3457@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EF7C243BF
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Sep 2009 03:44:28 +0200 (CEST)
In-Reply-To: <20090923171039.GB3457@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Sep 11, 2009 at 02:29:02PM -0700, Troy Kisky wrote:
>> When both playback and capture stream were open
>> davinci_i2s_hw_params was setting parameters for
>> the wrong stream. The fix for davinci_i2s_hw_params
>> is sufficient, but it looks like a race still happens
>> in davici_pcm_open. This patch also makes the race smaller
>> but the next patch provides a better fix.
> 
>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> 
> Applied both, thanks.  Sorry about the delay in applying these - not
> sure what I was waiting for there.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

I think you were waiting for me to remove the need for the
comment:

+	/*
+	 * dma_params must be first because rtd->dai->cpu_dai->private_data
+	 * is cast to a pointer of an array of struct davinci_pcm_dma_params in
+	 * davinci_pcm_open.
+	 */

Which is doable.

Do you still want this fixed?

Thanks
Troy
