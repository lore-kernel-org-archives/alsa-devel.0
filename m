From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Hold client_mutex while calling
 snd_soc_instantiate_cards()
Date: Mon, 06 Dec 2010 12:36:42 +0000
Message-ID: <1291639002.3281.30.camel@odin>
References: <1291625283.11404.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2901C24154
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 13:36:46 +0100 (CET)
Received: by wwc33 with SMTP id 33so3784791wwc.20
	for <alsa-devel@alsa-project.org>; Mon, 06 Dec 2010 04:36:45 -0800 (PST)
In-Reply-To: <1291625283.11404.2.camel@mola>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-12-06 at 16:48 +0800, Axel Lin wrote:
> As the comments of snd_soc_instantiate_cards() said,
> snd_soc_instantiate_cards() must be called with client_mutex.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
