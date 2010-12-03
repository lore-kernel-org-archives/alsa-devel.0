From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Don't oops in soc_probe_aux_dev in
 case of missing codec
Date: Fri, 03 Dec 2010 11:57:19 +0000
Message-ID: <1291377439.3271.39.camel@odin>
References: <1291360702-5709-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 009C52449D
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 12:57:22 +0100 (CET)
Received: by wwc33 with SMTP id 33so1141890wwc.20
	for <alsa-devel@alsa-project.org>; Fri, 03 Dec 2010 03:57:22 -0800 (PST)
In-Reply-To: <1291360702-5709-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-12-03 at 09:18 +0200, Jarkko Nikula wrote:
> Blind copy of codec finding algorithm from soc_bind_dai_link does not work
> in soc_probe_aux_dev if matching codec name is not found. In that case the
> code falls through and tries to start the probing procedure with invalid
> codec pointer.
> 
> Fix this and add an error print showing the codec name that cannot be found.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
