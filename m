From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2] Add support for tlv320aic3007 to
 tlv320aic3x codec.
Date: Fri, 20 Aug 2010 11:39:06 +0100
Message-ID: <1282300746.3084.138.camel@odin>
References: <1282279673-27319-1-git-send-email-rchung42@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DFB8B1038D4
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 12:39:10 +0200 (CEST)
Received: by ewy21 with SMTP id 21so1928766ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 03:39:10 -0700 (PDT)
In-Reply-To: <1282279673-27319-1-git-send-email-rchung42@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randolph Chung <rchung42@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-08-20 at 12:47 +0800, Randolph Chung wrote:
> This patch adds support for the tlv320aic3007 codec to the tlv320aic3x
> driver.
> 
> The tlv320aic3007 is similar to the aic31, but has an additional class-D
> speaker amp. The speaker amp control register overlaps with the mono
> output register of other codecs in this family, so we add logic to
> identify the actual codec being registered to set things up accordingly.
> 
> Signed-off-by: Randolph Chung <tausq@parisc-linux.org>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
