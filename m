From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Alsa-lib 'cancelability'
Date: Thu, 25 Aug 2016 20:31:17 +0100
Message-ID: <201608252031.18085.gineera@aspect135.co.uk>
References: <201608221741.21375.gineera@aspect135.co.uk>
 <5780ba02-e3b2-2cd6-e35e-a16fd77bc951@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 7.smtp.34sp.com (7.smtp.34sp.com [46.183.8.237])
 by alsa0.perex.cz (Postfix) with ESMTP id B2493265D22
 for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2016 21:28:57 +0200 (CEST)
Received: from smtpauth2.array1.smtp.34sp.com (lvs6.34sp.com [46.183.13.74])
 by 7.smtp.34sp.com (Postfix) with ESMTPS id 8AE52421517
 for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2016 20:28:48 +0100 (BST)
In-Reply-To: <5780ba02-e3b2-2cd6-e35e-a16fd77bc951@ladisch.de>
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
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

I missed replying to say thanks for the quick response - appreciated.

On Monday 22 August 2016 18:37, you wrote:
> Alan Horstmann wrote:
> > I am wondering if there is a policy on the thread 'cancelability' /
> > 'cancellability' of the functions in Alsa-lib?
>
> Yes.  The policy is "don't even think about it".

Too late - it's been happening for years!

> > The callback runs in it's own thread; when a user requests 'AbortStream'
> > a thread cancel is requested.
>
> Alsa-lib is not the only library with this 'policy'.  You cannot cancel
> threads over whose code you do not have complete control.

I was unsure whether libraries might disable cancelablility themselves as a 
defensive measure so as to protect the internal states - in this case to 
prevent the audio system from getting 'screwed-up', if only for other users.

We will have to ensure there is only limited opportunity for cancelling the 
thread during well-chosen sections.  Initial patches to do just that are 
proving effective.

Thanks again,

Alan
