From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: wm0010: fix error path
Date: Fri, 18 Sep 2015 12:40:35 +0100
Message-ID: <20150918114035.GH7694@ck-lbox>
References: <1442572341-28201-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1442572341-28201-3-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442572341-28201-3-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 18, 2015 at 04:02:21PM +0530, Sudip Mukherjee wrote:
> Fix the error path so that we can free the allocated memory on the error
> path instead of releasing them individually on each error.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
