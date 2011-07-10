From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 5/5] dbri: Add missing breaks in switch/case
Date: Sun, 10 Jul 2011 07:36:37 -0700
Message-ID: <1310308597.3848.21.camel@Joe-Laptop>
References: <cover.1310289795.git.joe@perches.com>
	 <5aa8ee111dd52768622e89c06440e1328f0d2247.1310289795.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5aa8ee111dd52768622e89c06440e1328f0d2247.1310289795.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2011-07-10 at 02:28 -0700, Joe Perches wrote:

defective patch, please ignore.

> diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
> index 73f9cba..ca978b1 100644
> --- a/sound/sparc/dbri.c
> +++ b/sound/sparc/dbri.c
> @@ -578,14 +578,19 @@ static __u32 reverse_bytes(__u32 b, int len)
>  	switch (len) {
>  	case 32:
>  		b = ((b & 0xffff0000) >> 16) | ((b & 0x0000ffff) << 16);
> +		break;

Maybe add a comment for fall through use instead.
