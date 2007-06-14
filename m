From: Robert Lemmen <robertle@semistable.com>
Subject: Re: hda-intel without headphone output
Date: Thu, 14 Jun 2007 20:27:03 +0200
Message-ID: <20070614182703.GA9443@sandbender>
References: <20070614083156.GB26945@sandbender> <s5h8xamk612.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d80-237-144-212.dds.hosteurope.de (debian.semistable.com
	[80.237.144.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 11A8B247BD
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jun 2007 20:32:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h8xamk612.wl%tiwai@suse.de>
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

On Thu, Jun 14, 2007 at 03:41:13PM +0200, Takashi Iwai wrote:
> The conexant codec is much better supported on ALSA 1.0.14.
> Give it a try first.

and i thought my alsa version was recent :P

this did the trick in combination with model=laptop, other models didn't
work. thanks for the help, and if there is any additional information
you need in order to make the driver autodetect the model in future
versions (if such a thing is possible), just tell me.

thanks again  robert

-- 
Robert Lemmen                               http://www.semistable.com 
