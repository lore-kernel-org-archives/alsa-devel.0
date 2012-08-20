From: Andrew Eikum <aeikum@codeweavers.com>
Subject: Re: [alsa-plugins PATCH] pulse: Support 24-bit formats
Date: Mon, 20 Aug 2012 07:42:05 -0500
Message-ID: <20120820124204.GW2424@foghorn.codeweavers.com>
References: <20120817204107.GV2424@foghorn.codeweavers.com>
 <s5hd32lrjui.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 1076F265D67
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2012 14:42:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd32lrjui.wl%tiwai@suse.de>
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
Cc: Andrew Eikum <aeikum@codeweavers.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 20, 2012 at 11:30:45AM +0200, Takashi Iwai wrote:
> At Fri, 17 Aug 2012 15:41:07 -0500,
> Andrew Eikum wrote:
> > These formats were introduced in PulseAudio 0.9.15. There aren't any
> > new formats supported since then, so this also brings the PulseAudio
> > plugin in sync with current PulseAudio.
> > 
> > Signed-off-by: Andrew Eikum <aeikum@codeweavers.com>
> > ---
> > 
> > There was a problem once before with a patch I submitted. This is
> > using format-patch and imap-send, so hopefully it goes through better
> > than it did before :)
> 
> Well, unfortunately it's not a preferred form of the patch.
> The patch commit log must be embedded in the patch itself.  That is,
> the text above including your sign-off must be in the git commit log,
> then generate the patch via git-format-patch or git show --pretty=email.
> 
> In anyway, I applied your patch manually now.
> Please try the right way at the next time.
> 

I guess I'm used to how the Git project and the Wine maintainer do it.
They import the entire mbox file with 'git am'. This works properly
for the mail I sent, including putting the message and S-o-b line into
the commit log and ignoring the bit between the --- and the patch.

I'll make sure the attachment itself contains all of those details
next time.

Thanks for applying,
Andrew
