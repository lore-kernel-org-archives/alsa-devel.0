From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2.6.37] ASoC: Fix bias power down of
 non-DAPM codec
Date: Fri, 10 Dec 2010 23:02:01 +0000
Message-ID: <1292022121.3422.25.camel@odin>
References: <20101210174227.GH3200@rakim.wolfsonmicro.main>
	<1292007235-22090-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A9F024638
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 00:02:04 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id 15so4034979wwe.20
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 15:02:03 -0800 (PST)
In-Reply-To: <1292007235-22090-1-git-send-email-jhnikula@gmail.com>
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

On Fri, 2010-12-10 at 20:53 +0200, Jarkko Nikula wrote:
> Currently bias of non-DAPM codec will be powered down (standby/off) whenever
> there is a stream stop. This is wrong in simultaneous playback/capture since
> the bias is put down immediately after stopping the first stream.
> 
> Fix this by using the codec->active count when figuring out the needed bias
> level after stream stop.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
