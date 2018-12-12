From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] ALSA: emux_hwdep: Fix potential Spectre v1
	vulnerabilities
Date: Wed, 12 Dec 2018 21:39:26 +0000
Message-ID: <20181212213926.ED0D120851@mail.kernel.org>
References: <20181212172049.GA22723@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E0EF267C38
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2018 22:39:28 +0100 (CET)
In-Reply-To: <20181212172049.GA22723@embeddedor>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sasha Levin <sashal@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v4.19.8, v4.14.87, v4.9.144, v4.4.166, v3.18.128, 

v4.19.8: Build OK!
v4.14.87: Build OK!
v4.9.144: Build OK!
v4.4.166: Build OK!
v3.18.128: Build failed! Errors:
    sound/synth/emux/emux_hwdep.c:27:10: fatal error: linux/nospec.h: No such file or directory


How should we proceed with this patch?

--
Thanks,
Sasha
