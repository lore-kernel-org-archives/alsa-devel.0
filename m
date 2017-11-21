From: Matthias Reichl <hias@horus.com>
Subject: Re: [PATCH RFC] ARM: dts: bcm283x: Fix probing of
	bcm2835-i2s
Date: Tue, 21 Nov 2017 21:38:42 +0100
Message-ID: <20171121203842.z274detdxg3hgotq@camel2.lan>
References: <1511110827-2726-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
 by alsa0.perex.cz (Postfix) with ESMTP id C0CEC266F52
 for <alsa-devel@alsa-project.org>; Tue, 21 Nov 2017 21:38:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1511110827-2726-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Florian Fainelli <f.fainelli@gmail.com>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Eric Anholt <eric@anholt.net>, Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org, kernel@martin.sperl.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 19, 2017 at 06:00:27PM +0100, Stefan Wahren wrote:
> Since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
> the bcm2835-i2s requires a clock as DT property. Unfortunately
> the necessary DT change has never been applied. While we are at it
> also fix the first PCM register range to cover the PCM_GRAY register.
> 
> This patch also fixes the dt-bindings accordlingly.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Tested-by: Matthias Reichl <hias@horus.com>
