From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: soc-core: Fix null pointer
 dereference
Date: Wed, 08 Dec 2010 12:04:38 +0000
Message-ID: <1291809878.3260.176.camel@odin>
References: <1291739438-4696-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 95D13103C0E
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 13:04:41 +0100 (CET)
Received: by wwe15 with SMTP id 15so1024043wwe.20
	for <alsa-devel@alsa-project.org>; Wed, 08 Dec 2010 04:04:41 -0800 (PST)
In-Reply-To: <1291739438-4696-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-12-07 at 16:30 +0000, Dimitris Papastamos wrote:
> In case the codec driver did not provide a read/write function,
> codec->driver->read|write will be NULL.  Ensure that we use the one
> specified in codec->read|write to avoid oopsing when we access
> the debugfs entries.  This is achieved by using snd_soc_read() and
> snd_soc_write().
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
