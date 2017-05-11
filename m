From: Christoph Hellwig <hch@lst.de>
Subject: Re: future of sounds/oss
Date: Thu, 11 May 2017 11:15:11 +0200
Message-ID: <20170511091511.GA21055@lst.de>
References: <20170511082133.GA20304@lst.de> <s5hh90rhjbc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F496266BF2
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 11:15:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hh90rhjbc.wl-tiwai@suse.de>
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
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 11, 2017 at 10:46:47AM +0200, Takashi Iwai wrote:
> Yeah, I also started looking at it after reading the LWN article.
> The removal of set_fs() in ALSA part was already finished, and I'm
> currently brushing up the patches.  It'll be in 4.13 at latest.

Great!

> That said, I'd love to drop that legacy stuff; or maybe as a
> soft-landing, begin with disabling the build of sound/oss in Kconfig.
> 
> The latter can be done even for 4.12, if Linus doesn't mind.

I'd be absolutely in favor of trying that and seeing if anyone
screams.
