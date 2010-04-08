From: Valentin Longchamp <valentin.longchamp@epfl.ch>
Subject: Re: [PATCH 3/3] imx-ssi: Use a hrtimer in FIQ mode
Date: Thu, 08 Apr 2010 17:29:29 +0200
Message-ID: <4BBDF659.1080407@epfl.ch>
References: <1270719086-23453-1-git-send-email-s.hauer@pengutronix.de>
	<1270719086-23453-4-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.epfl.ch (smtp3.epfl.ch [128.178.224.226])
	by alsa0.perex.cz (Postfix) with SMTP id D1052103968
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 17:29:33 +0200 (CEST)
In-Reply-To: <1270719086-23453-4-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Sascha Hauer wrote:
> Using a regular timer results in poll times < 1 jiffie with small
> buffers, so we loaded the timer with the actual jiffie value. We can
> be more accurate using a hrtimer. Also, we have to call
> snd_pcm_period_elapsed after playing period_bytes and not
> runtime->period_size (which is in samples and not in bytes).
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  sound/soc/imx/imx-pcm-fiq.c |   45 ++++++++++++++++++++----------------------
>  1 files changed, 21 insertions(+), 24 deletions(-)
> 

Sorry to bother you guys in your discussion (most of which I don't 
understand because of my poor alsa knowledge).

I just wanted to tell that I have given this patch a spin on a 
mx31moboard system. imx-ssi now works much better (the audio does not 
loop on one buffer anymore as it did with the earlier timer version) in 
various configuration (speaker-test with various rates up to 48 kHz as 
well as aplay with a wav file, which had never worked for me) and the 
CPU usage is much lower BUT I have experienced some deadlocks completely 
hanging the system looping on what should be the last buffer of the wave 
file.

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp@epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEB3494, Station 9, CH-1015 Lausanne
