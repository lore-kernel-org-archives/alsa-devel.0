From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tlv320dac33: Restore L/R DAC power
 control register
Date: Sat, 26 Mar 2011 15:53:07 +0000
Message-ID: <1301154787.3455.53.camel@odin>
References: <1300949885-12978-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C6A6103844
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 16:53:11 +0100 (CET)
Received: by wyg36 with SMTP id 36so1323128wyg.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 08:53:11 -0700 (PDT)
In-Reply-To: <1300949885-12978-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-03-24 at 08:58 +0200, Peter Ujfalusi wrote:
> Register 0x40, 0x41 need to be restored after power up, since
> it contains gain related fields, which affects playback volume.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/codecs/tlv320dac33.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 

Applied.

Thanks

Liam
