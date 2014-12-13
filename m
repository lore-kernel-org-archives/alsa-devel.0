From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch 1/2] ALSA: oxfw: some signedness bugs
Date: Sat, 13 Dec 2014 14:38:52 +0300
Message-ID: <20141213113852.GB4911@mwanda>
References: <20141212192703.GA22234@mwanda>
 <548BC973.3090004@sakamocchi.jp>
 <20141213070414.GA4973@mwanda>
 <548C1196.4010503@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <548C1196.4010503@sakamocchi.jp>
Sender: kernel-janitors-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Think about a for loop:

	for (i = 0; i < xxx; i++) {

If "i" is really so high that it goes negative you have a very serious
issue whether it's signed or unsigned.  If it's signed then the loop is
a no-op but if it's unsigned then it corrupts memory.

That's not a win.

regards,
dan carpenter

