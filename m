From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] hda-intel: reorder HDMI audio enabling
	sequence
Date: Mon, 17 Nov 2008 17:22:10 +0800
Message-ID: <20081117092210.GA21733@localhost>
References: <20081117085733.GA17334@localhost> <s5hy6ziyb6b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 72F3E2433C
	for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2008 10:22:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy6ziyb6b.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 17, 2008 at 11:05:48AM +0200, Takashi Iwai wrote:
> At Mon, 17 Nov 2008 16:57:33 +0800,
> Wu Fengguang wrote:
> > 
> > Reorder HDMI audio enabling sequence so that
> > 	1) the sink knows about the coming audio stream
> > 	2) unmute
> > 	3) start transferring audio samples
> > 
> > The theory is that in the path A=>B=>C, we first make C ready, and then
> > enable B, and lastly allow A to send audio samples.
> > 
> > Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
> 
> Looks good.  Applied this one, too.
> Thanks!

Thank you :-)

Fengguang
