From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: fix deemphasis control in
	wm8904/55/60 codecs
Date: Thu, 09 Dec 2010 10:04:38 +0000
Message-ID: <1291889078.3271.16.camel@odin>
References: <1291840577-23908-1-git-send-email-mad_soft@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 22FA7103855
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 11:04:41 +0100 (CET)
Received: by wwe15 with SMTP id 15so2120792wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 09 Dec 2010 02:04:40 -0800 (PST)
In-Reply-To: <1291840577-23908-1-git-send-email-mad_soft@inbox.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Artamonow <mad_soft@inbox.ru>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-12-08 at 23:36 +0300, Dmitry Artamonow wrote:
> Deemphasis control's .get callback should update control's value instead
> of returning it - return value of callback function is used for indicating
> error or success of operation.
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
