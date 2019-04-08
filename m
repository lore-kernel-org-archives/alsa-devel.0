From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] ALSA: hda - Add two more machines to the power_save_blacklist
Date: Mon, 08 Apr 2019 19:29:24 +0000
Message-ID: <20190408192925.756FE20880@mail.kernel.org>
References: <20190408013535.6423-1-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190408013535.6423-1-hui.wang@canonical.com>
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>, Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, tiwai@suse.de
Cc: stable@vger.kernel.orgstable@vger.kernel.orgstable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v5.0.7, v4.19.34, v4.14.111, v4.9.168, v4.4.178, v3.18.138.

v5.0.7: Build OK!
v4.19.34: Build OK!
v4.14.111: Failed to apply! Possible dependencies:
    721f1e6c1fd1 ("ALSA: hda - add Lenovo IdeaCentre B550 to the power_save_blacklist")
    dd6dd5365404 ("ALSA: hda: Add Intel NUC7i3BNB to the power_save blacklist")

v4.9.168: Failed to apply! Possible dependencies:
    721f1e6c1fd1 ("ALSA: hda - add Lenovo IdeaCentre B550 to the power_save_blacklist")
    dd6dd5365404 ("ALSA: hda: Add Intel NUC7i3BNB to the power_save blacklist")

v4.4.178: Failed to apply! Possible dependencies:
    721f1e6c1fd1 ("ALSA: hda - add Lenovo IdeaCentre B550 to the power_save_blacklist")
    dd6dd5365404 ("ALSA: hda: Add Intel NUC7i3BNB to the power_save blacklist")

v3.18.138: Failed to apply! Possible dependencies:
    1ba8f9d30817 ("ALSA: hda: Add a power_save blacklist")
    59ed1eade1d6 ("ALSA: hda - Move codec suspend/resume to codec driver")
    66797f36fd17 ("ALSA: hda - Pass printf argument directly to request_module()")
    721f1e6c1fd1 ("ALSA: hda - add Lenovo IdeaCentre B550 to the power_save_blacklist")
    95a962c36f6e ("ALSA: hda - More kerneldoc comments")
    a41d122449be ("ALSA: hda - Embed bus into controller object")
    b2a0bafa7582 ("ALSA: hda - Use shutdown driver ops instead of reboot notifier")
    d068ebc25e6e ("ALSA: hda - Move some codes up to hdac_bus struct")
    d8a766a16ed9 ("ALSA: hda - Bind codecs via standard bus")
    dd6dd5365404 ("ALSA: hda: Add Intel NUC7i3BNB to the power_save blacklist")
    dda42bd0c3a4 ("ALSA: hda - Add kerneldoc comments to hda_generic.c")
    e3d280fc6d42 ("ALSA: hda - Make snd_hda_bus_type public")


How should we proceed with this patch?
