From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: core: On resume also check the soc
 device state
Date: Mon, 22 Feb 2010 11:32:12 +0000
Message-ID: <1266838332.3159.10.camel@odin>
References: <1266838033-8087-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 232181037F7
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 12:32:17 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 3so479637eyh.16
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 03:32:16 -0800 (PST)
In-Reply-To: <1266838033-8087-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Mon, 2010-02-22 at 13:27 +0200, Peter Ujfalusi wrote:
> Check the card->codec on soc_resume to detect if the soc
> device is properly initialized.
> If the card->codec is NULL, than do not continue the resume
> operation, since the device is not initialized properly.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
> 
> The soc_susbend code is checking, if the soc device is properly
> initialized, but on soc_resume the check is missing, and it is
> unlikely that the soc device is actually initialized between these
> two calls.
> This fixes a crash, when doing suspend on a system where a soc
> device is not properly initialized.
> The crash happens on resume path, since the suspend has been protected
> against such a scenario.
> 
>  sound/soc/soc-core.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>


-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
