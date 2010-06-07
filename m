From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tlv320dac33: Add support for
 changing upper threshold
Date: Mon, 07 Jun 2010 10:48:37 +0100
Message-ID: <1275904117.3045.0.camel@odin>
References: <1275897039-7577-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 54D581037FF
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jun 2010 11:48:41 +0200 (CEST)
Received: by wyg36 with SMTP id 36so2245487wyg.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Jun 2010 02:48:40 -0700 (PDT)
In-Reply-To: <1275897039-7577-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Mon, 2010-06-07 at 10:50 +0300, Peter Ujfalusi wrote:
> Upper threshold is used in mode7 of DAC33.
> Instead of hard wired UTHR, add control to change the upper threshold
> value.
> Changing upper threshold is not allowed when the playback is already
> running, since wrongly timed change in the UTHR can cause problems
> with the codec.
> With this control the length of the burst in mode7 can be changed.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/codecs/tlv320dac33.c |   57 +++++++++++++++++++++++++++++++++------
>  1 files changed, 48 insertions(+), 9 deletions(-)
> 

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
