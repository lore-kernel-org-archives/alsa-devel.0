From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2 v2] ASoC: Fix codec device id format
 used by some dai_links
Date: Tue, 25 Jan 2011 11:55:12 +0000
Message-ID: <1295956512.3322.74.camel@odin>
References: <1295903363-4433-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C2BC0103929
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 12:55:16 +0100 (CET)
Received: by wwe15 with SMTP id 15so4710928wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 03:55:16 -0800 (PST)
In-Reply-To: <1295903363-4433-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-24 at 22:09 +0100, Lars-Peter Clausen wrote:
> The id part of an I2C device name is created with the "%d-%04x" format string.
> 
> So for example for an I2C device which is connected to the adapter with the id 0
> and has its address set to 0x1a the id part of the devices name would be
> "0-001a".
> 
> Currently some sound board drivers have the id part the codec_name field of
> their dai_link structures set as if it had been created by a "%d-0x%x" format
> string. For example "0-0x1a" instead of "0-001a".
> 
> As a result there is no match between the codec device and the dai_link and no
> sound card is instantiated.
> 
> This patch fixes it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
