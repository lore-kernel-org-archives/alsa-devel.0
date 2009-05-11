From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY on
 headsetl_event: POST_PMD
Date: Mon, 11 May 2009 15:03:20 +0300
Message-ID: <20090511150320.1e15014b.jhnikula@gmail.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<1242040465-10835-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 27994247C7
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 14:01:46 +0200 (CEST)
Received: by ewy23 with SMTP id 23so3699278ewy.32
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 05:01:45 -0700 (PDT)
In-Reply-To: <1242040465-10835-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, getarunks@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, 11 May 2009 14:14:25 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> This patch fixes the - agressive - 'tuck' sound heard when
> the codec goes to standby mode.
> 
> We need to wait for the ramp down completion in case of
> headsetl_event:POST_PMD.
> 
For my ears this sounds that the power-down pop is now even worse. I'm
listening with some 32 ohm headphones connected into Beagle.

Before it was kind of sharp snap but now it is snap + low-frequency
tuck/pop. Positive that this low-frequency pop sounds kind of same than
the power-up pop so there is now ramp in both events when coupling
capasitor is charging/discharging.

Do you know is the capacitor coupling configuration correct? TPS65950
is mentioning it but I don't find it at quick look where to configure it
for ac-coupled connection.


-- 
Jarkko
