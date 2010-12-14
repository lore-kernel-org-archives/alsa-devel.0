From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv2.1 0/3] ASoC: Extend DAPM to handle
 cross-device paths
Date: Tue, 14 Dec 2010 15:57:48 +0000
Message-ID: <1292342268.3316.18.camel@odin>
References: <1292321912-24765-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6872B2463F
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 16:57:52 +0100 (CET)
Received: by wwe15 with SMTP id 15so600026wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 07:57:52 -0800 (PST)
In-Reply-To: <1292321912-24765-1-git-send-email-jhnikula@gmail.com>
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

On Tue, 2010-12-14 at 12:18 +0200, Jarkko Nikula wrote:
> Hi
> 
> Just updated set, i.e. no code changes other than updated to current tree and
> some comment clarifications.
> 
> Last time there were discussion about special n_widgets casing for
> non-DAPM codecs. Mark suggested to drop them but they are still here as I
> don't want to break boards having non-DAPM codec with bias control and that
> casing is trivial to drop when not needed anymore.
> 
> 

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
