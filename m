From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [patch v2] ALSA: opl3: small array underflow
Date: Tue, 03 Mar 2015 21:59:17 +0100
Message-ID: <54F620A5.900@ladisch.de>
References: <20150303191318.GA7569@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20150303191318.GA7569@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Dan Carpenter wrote:
> We don't check for negatives so "pitchbend" can be SHRT_MIN here.  It
> means that we can read up to 6 elements before the start of the
> opl3_note_table[] array.
>
> There are several ways we could fix this.  I have gone with what is
> maybe the lazier approach of just changing negative values to zero.

The lower bound is not zero but -8192.


Regards,
Clemens
