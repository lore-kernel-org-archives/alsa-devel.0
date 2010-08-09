From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tlv320dac33: Fixes for
 multi-component
Date: Mon, 09 Aug 2010 11:18:20 +0100
Message-ID: <1281349100.3035.25.camel@odin>
References: <1281344158-3563-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id BA0F9245D8
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Aug 2010 12:18:22 +0200 (CEST)
Received: by wyb42 with SMTP id 42so9659940wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 09 Aug 2010 03:18:22 -0700 (PDT)
In-Reply-To: <1281344158-3563-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-08-09 at 11:55 +0300, Peter Ujfalusi wrote:
> Small changes int module load sequence.
> Keep the codec OFF when not active.
> Reading the DAC33 ID at probe time.
> In the private struct we need pointer for the codec.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
> 
> Hello Liam, Mark!
> 
> This patch is against the multi-comp branch, and makes the tlv320dac33
> driver working correctly (in a similar way as it used to work).
> I have tested the codec with this patch on top of the multi-comp
> branch, and works nicely.
> 
> Liam: You can squash this, if you think it's better..
> 

Yeah, squashed since it's fixes. I think we will make this the last
squashed patch as I'll do a multi-component patch series this evening
with a view to merge by the end of the week.

We can then deal with any fixes/updates incrementally.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
