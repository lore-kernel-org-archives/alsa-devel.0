From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v2] pinctrl: madera: Fix uninitialized variable bug in
 madera_mux_set_mux
Date: Fri, 12 Oct 2018 11:04:54 +0200
Message-ID: <21341de8-c9b2-7408-9b91-74c73cb5bc13@embeddedor.com>
References: <20181010151313.GA16854@embeddedor.com>
 <CACRpkda8Fo6ubO9XuDXC9tcLWPNp_6TMf6-g9DUxdU6JXa0Veg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkda8Fo6ubO9XuDXC9tcLWPNp_6TMf6-g9DUxdU6JXa0Veg@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, patches@opensource.cirrus.com, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On 10/11/18 10:40 AM, Linus Walleij wrote:

>> Changes in v2:
>>  - Initialize variable ret to 0 instead of -1. Thanks to Charles Keepax
>>    for pointing this out.
>>  - Update subject and commit log.
> 
> Patch applied with Charles' ACK.
> 

Thanks, Linus.
--
Gustavo
