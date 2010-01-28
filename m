From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: TWL4030: Modify codec default
 settings
Date: Thu, 28 Jan 2010 14:14:05 +0000
Message-ID: <1264688045.3044.176.camel@odin>
References: <1264687024-7241-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f213.google.com (mail-ew0-f213.google.com
	[209.85.219.213])
	by alsa0.perex.cz (Postfix) with ESMTP id E1E1C243C1
	for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2010 15:14:06 +0100 (CET)
Received: by ewy5 with SMTP id 5so766973ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2010 06:14:06 -0800 (PST)
In-Reply-To: <1264687024-7241-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Thu, 2010-01-28 at 15:57 +0200, Peter Ujfalusi wrote:
> Change the legacy default register configuration, which left some
> internal components on.
> Now we have either DAPM, or other ways to control these bits,
> so there is no need to enable them by default.
> 
> The affected parts:
> Disable ADCL and ADCR
> Disable ARXL2 and ARXR2 analog PGA (playback)
> Disable APLL by default
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Btw, should we be expecting more of these or does the twl4030 have full
DAPM coverage now ?

Thanks

Liam 
