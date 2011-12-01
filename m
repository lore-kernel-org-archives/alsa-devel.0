From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/3] ASoC: Add signal generator widget type
Date: Thu, 01 Dec 2011 15:27:00 +0000
Message-ID: <1322753220.4712.2.camel@odin>
References: <1322686625-16488-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 90E5D1039C0
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2011 16:27:07 +0100 (CET)
Received: by mail-ey0-f180.google.com with SMTP id c11so3632687eaa.39
	for <alsa-devel@alsa-project.org>; Thu, 01 Dec 2011 07:27:05 -0800 (PST)
In-Reply-To: <1322686625-16488-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-11-30 at 20:57 +0000, Mark Brown wrote:
> A signal generator behaves as an input would but is not considered for
> any of the special behaviour associated with external input pins. This
> is especially useful when automatically working out not connected widgets.
> 

Would this not be an output type ?

Regards

Liam
