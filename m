From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/9] ALSA: usb-audio: UAC2: clean up
 parsing of bmaControls
Date: Mon, 31 May 2010 18:47:16 +0200
Message-ID: <20100531164716.GM2695@buzzloop.caiaq.de>
References: <1275305744-6590-1-git-send-email-daniel@caiaq.de>
	<s5hmxvgt4fp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 761DE244B9
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 18:47:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hmxvgt4fp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, gregkh@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Mon, May 31, 2010 at 06:35:22PM +0200, Takashi Iwai wrote:
> At Mon, 31 May 2010 13:35:36 +0200,
> Daniel Mack wrote:
> > 
> > Introduce two new static inline functions for a more readable parsing
> > of UAC2 bmaControls.
> > 
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> 
> Thanks!  Now I applied all patches for 2.6.35-rc2.
> 
> But, basically I don't want to touch too much after this.
> So, please avoid refactoring patches for 2.6.35.  If any, prepare a
> separate one for 2.6.36, and let's concentrate on fixes during
> 2.6.35-rc.

Yes, I'm aware of this, and I'm not planning to move this code around
much in the next weeks, except for bug fixing.

In general, UAC2 devices are now almost fully supported. There are some
special controllers missing like graphical equalizers, but that can be
done when devices appear which really implement such things.

Happy testing :)

Thanks,
Daniel
