From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 2/2] ALSA: au88x0: pr_* replaced with
 dev_*
Date: Sat, 11 Oct 2014 11:22:59 -0700
Message-ID: <1413051779.22149.8.camel@joe-AO725>
References: <1412930199-24797-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1412930199-24797-2-git-send-email-sudipm.mukherjee@gmail.com>
 <CAN8ccibSw_85wdnxbNSKfjXQ-7Lg3C6_5fhKQJJi5xMi8pMabA@mail.gmail.com>
 <20141011090903.GC8231@sudip-PC> <1413024491.16385.10.camel@joe-AO725>
 <20141011113349.GA9962@sudip-PC> <1413041569.16385.20.camel@joe-AO725>
 <CADVatmPiWEm9wBENVVytUqCOV_Yv9HojmHYJGDAmyGpwhcCU8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0043.hostedemail.com
 [216.40.44.43]) by alsa0.perex.cz (Postfix) with ESMTP id F0DFE260614
 for <alsa-devel@alsa-project.org>; Sat, 11 Oct 2014 20:23:02 +0200 (CEST)
In-Reply-To: <CADVatmPiWEm9wBENVVytUqCOV_Yv9HojmHYJGDAmyGpwhcCU8A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2014-10-11 at 23:40 +0530, Sudip Mukherjee wrote:
> now in this case what will you suggest - shutdown and done both
> terminated by \n or some thing like : "shutdown process started" and then
> "shutdown done"....

I think it doesn't matter one way or another as
it's only useful when there's a hang in the init
or shutdown.

It is better though to have complete messages
terminated with newlines so that it is not possible
for other threads to confusingly interleave output.
