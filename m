From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] ALSA: pcm: Fix potential Spectre v1
	vulnerability
Date: Wed, 12 Dec 2018 22:25:16 +0000
Message-ID: <20181212222517.961072084E@mail.kernel.org>
References: <20181212213628.GA29911@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F6D9267C3D
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2018 23:35:27 +0100 (CET)
In-Reply-To: <20181212213628.GA29911@embeddedor>
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
v4.9.144: Failed to apply! Possible dependencies:
    2c4842d3b6b3 ("ALSA: pcm: add local header file for snd-pcm module")

v4.4.166: Failed to apply! Possible dependencies:
    2c4842d3b6b3 ("ALSA: pcm: add local header file for snd-pcm module")

v3.18.128: Failed to apply! Possible dependencies:
    2c4842d3b6b3 ("ALSA: pcm: add local header file for snd-pcm module")
    90bbaf66ee7b ("ALSA: timer: add config item to export PCM timer disabling for expert")
    9bc889b4ba88 ("ALSA: pcm: Update the state properly before notification")
    f5914908a5b7 ("ALSA: pcm: Replace PCM hwptr tracking with tracepoints")


How should we proceed with this patch?

--
Thanks,
Sasha
