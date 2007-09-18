From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
 initial load
Date: Tue, 18 Sep 2007 08:50:59 +0200
Message-ID: <46EF7553.3020400@gmail.com>
References: <46E58D01.9080809@gmail.com>
	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>
	<46EF18FF.7070906@gmail.com>
	<Pine.LNX.4.58.0709171757500.27377@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id CB14924450
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 08:51:55 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.58.0709171757500.27377@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Takashi Iwai <tiwai@suse.de>, Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/18/2007 04:32 AM, Trent Piepho wrote:

> You can see the version in Hg after your patch was applied, and it uses
> schedule_timeout()

Yes, as said, that was a mismatch between the 2.6.22.x I was looking at and 
the patch that removed the _interruptible() from a few months go already. 
Also explains some of the mis-communication with Krzysztof earlier...

> I seem to have deleted the necessary unlock call before I sent the patch.
> One of the tests is inverted too. Here is a new version which fixes all 
> that. The other problem you pointed at out in the current code about 
> mistaken timeouts is fixed as well.

Yes, I agree with this, looking much better now. The removal of that last 
INIT checking loop _might_ cause a timing difference if earlier we just 
timed out in snd_ad1848_wait() but in that case, we're sol already anyway 
and who cares. Comment is good as well. Maybe s/should/could/ in:

+ * has in fact not begun. It should take 128 (no AC) or 384 (AC) cycles
+ * for ACI to drop. This gives a wait of at most 70 ms with a more
+ * typical value of 3-9 ms.

By the way, as to the cs4231 mirror image -- the CS4248 was the only chip 
that I didn't experience the autocalibration "(1)" timeout on using 
cs4231_lib which seems to indicate that for the CS423x chips, ACI never 
comes up at all when not auto-calibrating. Just for info, this same code 
handles that just fine.

I just now tested this on a CS4231A driven by ad1848_lib -- is working fine.

Acked-by: Rene Herman <rene.herman@gmail.com>

Rene.
