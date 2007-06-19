From: Robert Lemmen <robertle@semistable.com>
Subject: Re: hda-intel without headphone output
Date: Tue, 19 Jun 2007 13:35:25 +0200
Message-ID: <20070619113525.GA4477@sandbender>
References: <20070614083156.GB26945@sandbender> <s5h8xamk612.wl%tiwai@suse.de>
	<20070614182703.GA9443@sandbender>
	<1181874374.12385.203.camel@razman.gruemaster.com>
	<s5hhcp4i711.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d80-237-144-212.dds.hosteurope.de (debian.semistable.com
	[80.237.144.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 06E99243A1
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2007 13:41:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hhcp4i711.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 19, 2007 at 12:16:10PM +0200, Takashi Iwai wrote:
> > This patch adds support for the Fujitsu Seimens Amilo Pro v3515 notebook.
> > 
> > Signed off by:  Tobin Davis <tdavis@dsl-only.net>
> 
> Applied to HG tree.  Thanks.

perhaps you want to hold it for a while. i tried the patch on my
machine, and it does change the behaviour a bit (when i plug in
headphones both the headphones and the loudspeakers work, before only
the loudspeakers did), but it does not mute the speakers. model=laptop
fixes this. i wasn't 100% sure that i did apply the patch correctly and
did not by accident use the old module, so i didn't report it
immediately. didn't have time to look into it yet, but promise to do so
soonish

cu  robert

-- 
Robert Lemmen                               http://www.semistable.com 
