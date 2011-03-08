From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Add DAPM widget and path data to
 CODEC driver structure
Date: Tue, 08 Mar 2011 17:57:42 +0000
Message-ID: <1299607062.3374.8.camel@odin>
References: <1299516086-23638-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A308103959
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 18:57:52 +0100 (CET)
Received: by wwi17 with SMTP id 17so1173760wwi.2
	for <alsa-devel@alsa-project.org>; Tue, 08 Mar 2011 09:57:48 -0800 (PST)
In-Reply-To: <1299516086-23638-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Mon, 2011-03-07 at 16:41 +0000, Mark Brown wrote:
> Allow a slight simplification of CODEC drivers by allowing DAPM routes and
> widgets to be provided in a table. They will be instantiated at the end of
> CODEC probe.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
