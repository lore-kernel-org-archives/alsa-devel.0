From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/8] ASoC: Initial audio support for
 Speyside on Cragganmore 6410
Date: Wed, 13 Apr 2011 08:47:18 +0100
Message-ID: <1302680838.3600.17.camel@odin>
References: <1302674771-17169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AB64410395C
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 09:47:22 +0200 (CEST)
Received: by wyg36 with SMTP id 36so289944wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2011 00:47:22 -0700 (PDT)
In-Reply-To: <1302674771-17169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-04-12 at 23:06 -0700, Mark Brown wrote:
> This is minimal code required to get audio out of the Speyside audio
> subsystem on the Wolfson Cragganmore 6410 reference platform.  It sets
> up the link between the CPU and AIF1 of the WM8915 on the system,
> enabling audio playback via the headphone and speaker outputs of the
> device (which require no further configuration except runtime).  It
> allows verification of basic functionality of the system.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
