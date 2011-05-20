From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: core: Don't set "(null)" as a driver
	name
Date: Fri, 20 May 2011 15:40:00 +0300
Message-ID: <20110520154000.663e50a4.jhnikula@gmail.com>
References: <1305894086-9851-1-git-send-email-jhnikula@gmail.com>
	<4DD65F5F.9060908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 793D1103855
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 14:38:34 +0200 (CEST)
Received: by ewy6 with SMTP id 6so1272217ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 20 May 2011 05:38:34 -0700 (PDT)
In-Reply-To: <4DD65F5F.9060908@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 20 May 2011 13:32:31 +0100
Liam Girdwood <lrg@ti.com> wrote:

> This looks good but we may want to make the default driver name (if no driver name is specified) to be the card->name instead of " " and should return an error if card->name is NULL.
> 
Sounds better and card->name is already tested in
snd_soc_register_card. I'll update the patch.

-- 
Jarkko
