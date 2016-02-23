From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH 2/2] ASoC: max9867: fix type of variable containing error codes
Date: Tue, 23 Feb 2016 14:50:42 +0800
Message-ID: <CAFRkauCyU5MBS8gVRo1we+VEDzKrZZnCbCV4XWAdDYFq3OFKhA@mail.gmail.com>
References: <1456209914-13375-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456209914-13375-1-git-send-email-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, anish kumar <yesanishhere@gmail.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

2016-02-23 14:45 GMT+08:00 Andrzej Hajda <a.hajda@samsung.com>:
> value variable can contain error values and is compared with zero.
> Its type must be signed.
Reviewed-by: Axel Lin <axel.lin@ingics.com>
