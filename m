From: Peter Ujfalusi <peter.ujfalusi@Nokia.com>
Subject: Re: [PATCH] ASoC: pandora: Add APLL supply to fix
	audio output
Date: Fri, 5 Feb 2010 08:50:56 +0200
Message-ID: <201002050850.56430.peter.ujfalusi@nokia.com>
References: <1265324133-23607-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 31177243D2
	for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2010 07:51:13 +0100 (CET)
In-Reply-To: <1265324133-23607-1-git-send-email-notasas@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Friday 05 February 2010 00:55:33 ext Grazvydas Ignotas wrote:
> Pandora's external DAC is using 256*Fs output from the TWL4030
> codec, and TWL4030 needs to have APLL enabled for it's 256*Fs
> output to function.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> I noticed this a bit late because TWL4030 codec used to have APLL
> enable hardcoded until that was clean up by not-so-old patch.
> Would be nice to see this in next -rc, as without this audio
> won't work completely on pandora (again)..

Yeah, when I made the changes to the twl4030 codec, I did missed the pandora 
setup..

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
