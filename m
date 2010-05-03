From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv3 0/2] ASoC: TWL4030: APLL/AIF ordering and
 DAPM updates
Date: Mon, 03 May 2010 13:19:19 +0100
Message-ID: <1272889160.3000.17.camel@odin>
References: <1272527889-22447-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id B03CF24572
	for <alsa-devel@alsa-project.org>;
	Mon,  3 May 2010 14:19:31 +0200 (CEST)
Received: by wya21 with SMTP id 21so221099wya.38
	for <alsa-devel@alsa-project.org>; Mon, 03 May 2010 05:19:29 -0700 (PDT)
In-Reply-To: <1272527889-22447-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Thu, 2010-04-29 at 10:58 +0300, Peter Ujfalusi wrote:
> Hello,
> 
> Changes since v2:
> apll_enable logic cleaned up.
> aif refcounting has been removed, aif handling simplified
> The new DAPM_OUTPUT and DAPM_INPUT widgets renamed
> 
> 
> Correct the APLL/AIF powering sequence.
> Also introducing DAPM outputs and input for keeping APLL/AIF
> enabled in case when no valid DAPM route selected during audio
> activity.
> 
> The second patch removes the legacy OUTL/R.
> 
> As a note:
> The APLL/AIF patch replaces the same patch in Liam's series.
> The OUTL/R removal can be applied after the OUTL/R reference
> has been removed from machine drivers (as in Lima's series).
> 
> ---
> Peter Ujfalusi (2):
>   ASoC: TWL4030: AIF/APLL fix in DAPM domain
>   ASoC: TWL4030: Remove OUTL/R outputs
> 
>  sound/soc/codecs/twl4030.c |   86 ++++++++++++++++++++++++++++++-------------
>  1 files changed, 60 insertions(+), 26 deletions(-)
> 

Applied.

Thanks

Liam
