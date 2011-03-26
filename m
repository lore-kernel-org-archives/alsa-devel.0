From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/3] ASoC: Add default
 snd_soc_default_writable_register() callback
Date: Sat, 26 Mar 2011 12:51:48 +0000
Message-ID: <1301143908.3455.47.camel@odin>
References: <1300974319-14423-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 3DD7224438
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 13:51:53 +0100 (CET)
Received: by wyg36 with SMTP id 36so1244765wyg.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 05:51:52 -0700 (PDT)
In-Reply-To: <1300974319-14423-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-03-24 at 13:45 +0000, Dimitris Papastamos wrote:
> By using struct snd_soc_reg_access for the read/write/vol attributes
> of the registers, we provide callbacks that automatically determine whether
> a given register is readable/writable or volatile.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

All

Acked-by: Liam Girdwood <lrg@ti.com>
