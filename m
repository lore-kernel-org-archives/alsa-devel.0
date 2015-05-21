From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Assert in pcm_params.c
Date: Thu, 21 May 2015 19:10:30 +0100
Message-ID: <201505211910.30903.gineera@aspect135.co.uk>
References: <201504180908.47022.gineera@aspect135.co.uk>
 <201505211656.04334.gineera@aspect135.co.uk> <s5hpp5t4zae.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 3.array2.smtp.34sp.com (3.array2.smtp.34sp.com [46.183.9.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 9657626168C
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 20:10:12 +0200 (CEST)
Received: from smtpauth1.array1.smtp.34sp.com (lvs3.34sp.com [80.82.124.221])
 by 3.array2.smtp.34sp.com (Postfix) with ESMTP id 7D4F66C6E9
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 19:10:08 +0100 (BST)
In-Reply-To: <s5hpp5t4zae.wl-tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 21 May 2015 18:26, Takashi Iwai wrote:
> At Thu, 21 May 2015 16:56:04 +0100,
>
> Alan Horstmann wrote:
> > On Wednesday 20 May 2015 07:36, Takashi Iwai wrote:

<snip>

> > > In anyway, the fix would be simple, the patch like below.  Could you
> > > check whether it actually fixes your issue?
> >
> > I've had a positive confirmation that the patch removing the asserts does
> > fix the 'crash' in the reporter's system.  So instead it is simply a
> > failure of the snd_pcm_hw_params() call, which ultimately can be handled
> > in the users code.
>
> OK, I pushed the fix to git repo now.

Is this something that should go to stable so it is more likely to be 
backported to slower moving distros, eg Debian Jessie, or is that not how it 
works?

> > I do wonder (as does Raymond) why this fails.  Is 6-chans expected to
> > fail on 'front'?  In particular the earlier setting of
> > channels/rate/format does not fail?  Perhaps I will ask for RULES_DEBUG
> > enabled?
>
> Likely the alignment issue: 6 channels can't fit always with 128 byte
> constraint that are required by some hardware chips.

Hmm, it is only an issue with the pcms like front, surround though, not hw?

Regards

Alan
