From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 14/15] ASoC: hdac_hdmi: Add jack
 reporting for user space
Date: Tue, 8 Dec 2015 16:12:57 +0530
Message-ID: <20151208104256.GR1854@localhost>
References: <1449523469-4395-14-git-send-email-subhransu.s.prusty@intel.com>
 <s5hy4d6kzb5.wl-tiwai@suse.de> <20151208063135.GN1854@localhost>
 <s5htwnt1m2x.wl-tiwai@suse.de> <20151208074216.GO1854@localhost>
 <s5hio491iol.wl-tiwai@suse.de> <20151208083831.GP1854@localhost>
 <s5h7fkp1gda.wl-tiwai@suse.de> <20151208102059.GQ1854@localhost>
 <s5hio49kzen.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FD6426603B
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 11:40:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hio49kzen.wl-tiwai@suse.de>
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
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 08, 2015 at 11:28:16AM +0100, Takashi Iwai wrote:
> > Yes that was my thinking based on discussion and patches posted by Libin.
> > But one more question who does PCM assignment, looking at patches it seems
> > driver and no way to change that..
> > 
> > For example I have 10 devices connected  and we have 5 PCMs.
> > I would like to route to 7th device, how would that be done?
> 
> Manage xrandr to enable the target monitor.  Then one PCM stream will
> be switched to the corresponding audio, and it'll be notified to
> user-space.

Thanks, that helps..

Looking at RFC patches I do not see that implemented, so maybe Libin
and you will add that eventually

The question here is how will the switch be handled, can you please
elaborate on that. From xrandr selection how will audio driver be
notified and how will change be done?

-- 
~Vinod
