From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [patch 1/2] ALSA: oxfw: some signedness bugs
Date: Sat, 13 Dec 2014 14:06:59 +0900
Message-ID: <548BC973.3090004@sakamocchi.jp>
References: <20141212192703.GA22234@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20141212192703.GA22234@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Dec 13 2014 04:27, Dan Carpenter wrote:
> This code tends to use unsigned variables by default and it causes
> signedness bugs when we use negative variables for error handling.
> The "i" and "j" variables are used to iterated over small positive
> values and so they should be type "int".  The "len" variable doesn't
> *need* to be signed but it should be signed to make the code easier to
> read and audit.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, but I prefer to use 'unsigned int' for loop counter, like the
other drivers. Would you give 'int' type just for err variables?


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

