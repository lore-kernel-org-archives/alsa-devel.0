From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 3/3 - RESEND] ASoC: SDP3430: Connect
	twl4030 voice DAI to McBSP3
Date: Tue, 19 May 2009 08:27:39 +0300
Message-ID: <200905190827.39426.peter.ujfalusi@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F69E8406@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 61890245FE
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 07:28:46 +0200 (CEST)
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705F69E8406@dlee07.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Monday 18 May 2009 19:53:04 ext Lopez Cruz, Misael wrote:
> Connect twl4030 voice DAI to McBSP3 in sdp3430 machine driver.
> Voice DAI init function enables corresponding interface by
> writting directly to VOICE_IF codec register.
>
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> ---
>  sound/soc/omap/sdp3430.c |   87
> ++++++++++++++++++++++++++++++++++++++++----- 1 files changed, 77
> insertions(+), 10 deletions(-)

Looks good.

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
