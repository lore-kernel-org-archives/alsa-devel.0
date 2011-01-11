From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] [v2] ASoC: let snd_soc_update_bits()
 return an error code
Date: Tue, 11 Jan 2011 10:51:21 +0000
Message-ID: <1294743081.3338.0.camel@odin>
References: <1294696693-4602-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id C4E42245E9
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 11:51:24 +0100 (CET)
Received: by wyi11 with SMTP id 11so20421763wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 02:51:24 -0800 (PST)
In-Reply-To: <1294696693-4602-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-10 at 15:58 -0600, Timur Tabi wrote:
> Update snd_soc_update_bits() so that it returns a negative error code if the
> the read or write operation fails.
> 
> Note that currently, a lot of the lower-level read functions have an unsigned
> integer return type (and some of them even try to return a negative number),
> but this code still appears to work in those cases.
> 
> An examination of the code shows that all current callers are compatible with
> this change.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
