From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] ALSA: rme9652: Fix potential Spectre v1
	vulnerability
Date: Tue, 18 Dec 2018 23:48:00 +0000
Message-ID: <20181218234801.2C4E3218A6@mail.kernel.org>
References: <20181218171834.GA14211@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id DE272267946
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 01:07:14 +0100 (CET)
In-Reply-To: <20181218171834.GA14211@embeddedor>
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

The bot has tested the following trees: v4.19.10, v4.14.89, v4.9.146, v4.4.168, v3.18.130, 

v4.19.10: Build OK!
v4.14.89: Build OK!
v4.9.146: Build OK!
v4.4.168: Build OK!
v3.18.130: Failed to apply! Possible dependencies:
    6cbbfe1c8ddb ("ALSA: Include linux/io.h instead of asm/io.h")


How should we proceed with this patch?

--
Thanks,
Sasha
