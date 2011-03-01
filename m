From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2 2.6.38] ASoC: WM8994: Don't disable the
 AIF[1|2]CLK_ENA unconditionaly
Date: Tue, 01 Mar 2011 14:38:57 +0000
Message-ID: <1298990337.3345.16.camel@odin>
References: <1298913852-22766-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D2B9D103939
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 15:39:01 +0100 (CET)
Received: by wwf26 with SMTP id 26so5092082wwf.20
	for <alsa-devel@alsa-project.org>; Tue, 01 Mar 2011 06:39:01 -0800 (PST)
In-Reply-To: <1298913852-22766-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Mon, 2011-02-28 at 17:24 +0000, Dimitris Papastamos wrote:
> Since we began using the late clock disable functionality, ensure that
> we don't disable the clock if any of the ADC or DAC paths are still
> enabled.  This happens when we have simultaneous playback and recording.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
