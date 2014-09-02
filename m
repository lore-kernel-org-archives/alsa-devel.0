From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/2] ALSA: pcm: Allow nonatomic trigger
	operations
Date: Tue, 02 Sep 2014 15:27:47 +0300
Message-ID: <5405B7C3.7020603@linux.intel.com>
References: <1409572832-32553-1-git-send-email-tiwai@suse.de>
 <1409572832-32553-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 125F32651EE
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 14:28:25 +0200 (CEST)
In-Reply-To: <1409572832-32553-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/01/2014 03:00 PM, Takashi Iwai wrote:
> Currently, many PCM operations are performed in a critical section
> protected by spinlock, typically the trigger and pointer callbacks are
> assumed to be atomic.  This is basically because some trigger action
> (e.g. PCM stop after drain or xrun) is done in the interrupt handler.
> If a driver runs in a threaded irq, however, this doesn't have to be
> atomic.  And many devices want to handle trigger in a non-atomic
> context due to lengthy communications.
>
> This patch tries all PCM calls operational in non-atomic context.
> What it does is very simple: replaces the substream spinlock with the
> corresponding substream mutex when pcm->nonatomic flag is set.  The
> driver that wants to use the non-atomic PCM ops just needs to set the
> flag and keep the reset as is.  (Of course, it must not handle any PCM
>
I guess "s/reset/rest/"?

-- 
Jarkko
