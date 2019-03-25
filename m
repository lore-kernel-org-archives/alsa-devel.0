From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] ALSA: hda - add Lenovo IdeaCentre B550 to
	the power_save_blacklist
Date: Mon, 25 Mar 2019 00:38:30 +0000
Message-ID: <20190325003831.C9A8A20989@mail.kernel.org>
References: <20190318124543.30944-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F343F801DA
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2019 01:38:34 +0100 (CET)
In-Reply-To: <20190318124543.30944-1-perex@perex.cz>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Sasha Levin <sashal@kernel.org>, Jaroslav Kysela <perex@perex.cz>, ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v5.0.3, v4.19.30, v4.14.107, v4.9.164, v4.4.176, v3.18.136.

v5.0.3: Build OK!
v4.19.30: Build OK!
v4.14.107: Failed to apply! Possible dependencies:
    dd6dd5365404 ("ALSA: hda: Add Intel NUC7i3BNB to the power_save blacklist")

v4.9.164: Failed to apply! Possible dependencies:
    dd6dd5365404 ("ALSA: hda: Add Intel NUC7i3BNB to the power_save blacklist")

v4.4.176: Failed to apply! Possible dependencies:
    dd6dd5365404 ("ALSA: hda: Add Intel NUC7i3BNB to the power_save blacklist")

v3.18.136: Failed to apply! Possible dependencies:
    1ba8f9d30817 ("ALSA: hda: Add a power_save blacklist")
    59ed1eade1d6 ("ALSA: hda - Move codec suspend/resume to codec driver")
    66797f36fd17 ("ALSA: hda - Pass printf argument directly to request_module()")
    95a962c36f6e ("ALSA: hda - More kerneldoc comments")
    a41d122449be ("ALSA: hda - Embed bus into controller object")
    b2a0bafa7582 ("ALSA: hda - Use shutdown driver ops instead of reboot notifier")
    d068ebc25e6e ("ALSA: hda - Move some codes up to hdac_bus struct")
    d8a766a16ed9 ("ALSA: hda - Bind codecs via standard bus")
    dd6dd5365404 ("ALSA: hda: Add Intel NUC7i3BNB to the power_save blacklist")
    dda42bd0c3a4 ("ALSA: hda - Add kerneldoc comments to hda_generic.c")
    e3d280fc6d42 ("ALSA: hda - Make snd_hda_bus_type public")


How should we proceed with this patch?

--
Thanks,
Sasha
