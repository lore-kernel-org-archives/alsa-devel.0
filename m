From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH][Trivial] Delete trailing whitespace from
 sound/soc/codecs/wm8994.c
Date: Mon, 9 Apr 2012 02:02:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204090201160.24006@pobox.suse.cz>
References: <alpine.LNX.2.00.1204090038270.11747@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1204090038270.11747@swampdragon.chaosbits.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Apr 2012, Jesper Juhl wrote:

> While reading through sound/soc/codecs/wm8994.c I noticed a fair
> amount of trailing whitespace. This patch gets rid of it.
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>

Jesper,

is it really worth it? The code should have been fixed before merging, 
yes, but once it's there, such fixups tend to only make people angry 
(because they have to do unnecessary extra steps during git blame).

-- 
Jiri Kosina
SUSE Labs
