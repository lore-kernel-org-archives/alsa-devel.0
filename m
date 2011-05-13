From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: Fix wrong data type access in a few
	codec drivers
Date: Fri, 13 May 2011 19:05:08 +0300
Message-ID: <20110513190508.562ef6a7.jhnikula@gmail.com>
References: <1305296663-8284-1-git-send-email-jhnikula@gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AA584@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E3DD243B3
	for <alsa-devel@alsa-project.org>;
	Fri, 13 May 2011 18:05:12 +0200 (CEST)
Received: by eyg5 with SMTP id 5so802264eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2011 09:05:11 -0700 (PDT)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04986AA584@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 13 May 2011 08:54:34 -0700
Stephen Warren <swarren@nvidia.com> wrote:

> Crap, sorry about that.
> 
> I think this needs to be fixed in a few more places:
> wm8994_put_hp_enum
> wm8994_put_class_w
> wm8995_put_class_w
> 
> based on: cd sound/soc && grep -HrnI snd_kcontrol_chip .
> ... and finding all those that look up widgets not a codec.
> 
Thanks, I managed to not notice those. Will update shortly.

-- 
Jarkko
