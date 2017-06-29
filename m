From: James Cameron <quozl@laptop.org>
Subject: Re: [PATCH] ASoC: rt5645: Add quirk override by module
 option
Date: Fri, 30 Jun 2017 09:40:25 +1000
Message-ID: <20170629234025.GC24570@us.netrek.org>
References: <20170629160833.28413-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swan.laptop.org (swan.media.mit.edu [18.85.44.157])
 by alsa0.perex.cz (Postfix) with ESMTP id 041DC2673ED
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 01:40:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170629160833.28413-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 29, 2017 at 06:08:33PM +0200, Takashi Iwai wrote:
> For making the development easier, add quirk module option to override
> the platform data setup.  For example, a platform with inverted jack
> detection with jd_mode=2, pass the value 0x21 (0x1 = inv_jd1_1, 0x20 =
> jd_mode=2).  It overrides the whole pdata fields, so pass it
> carefully.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Tested-by: James Cameron <quozl@laptop.org>

Now I've a working internal digital microphone, using
snd_soc_rt5645.quirk=0x1031

-- 
James Cameron
http://quozl.netrek.org/
