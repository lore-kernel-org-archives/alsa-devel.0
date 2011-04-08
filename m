From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Add data based control
 initialisation for CODECs and cards
Date: Fri, 08 Apr 2011 18:22:38 +0100
Message-ID: <1302283358.3315.106.camel@odin>
References: <1302171840-22041-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 82E5810382C
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 19:22:43 +0200 (CEST)
Received: by wyg36 with SMTP id 36so3560452wyg.38
	for <alsa-devel@alsa-project.org>; Fri, 08 Apr 2011 10:22:43 -0700 (PDT)
In-Reply-To: <1302171840-22041-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-04-07 at 19:24 +0900, Mark Brown wrote:
> Allow CODEC and card drivers to point to an array of controls from their
> driver structure rather than explicitly calling snd_soc_add_controls().
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
