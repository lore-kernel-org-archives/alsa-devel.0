From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: GIT: something wrong with sound-2.6/devel?
Date: Mon, 21 Jul 2008 12:39:05 +0200
Message-ID: <48846749.7070906@keyaccess.nl>
References: <48844CA9.9060408@keyaccess.nl>
	<20080721095119.GD7083@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 87B8C245E5
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 12:36:51 +0200 (CEST)
In-Reply-To: <20080721095119.GD7083@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 21-07-08 11:51, Mark Brown wrote:

> On Mon, Jul 21, 2008 at 10:45:29AM +0200, Rene Herman wrote:
> 
>> rene@7ixe4:~/src/linux/7ixe4$ git fetch tiwai
>>  From git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
>>   ! [rejected]        devel      -> tiwai/devel  (non fast forward)
>>   ! [rejected]        dma-fix    -> tiwai/dma-fix  (non fast forward)
>>   ! [rejected]        master     -> tiwai/master  (non fast forward)
> 
>> I'll go ask on the GIT list what this might be about...
> 
> This means that the git remote is configured to only pull fast forwards
> from that repository.  Add a + to the 'fetch =' for it in .git/config
> and it'll track non-linear updates like you get when the remote rebases.

I see.... thanks. I'll wait a bit with doing that then since it appears 
that this rejection might be the behaviour I want from it -- am using 
the devel branch specifically due to it only being rebased at releases.

Okay, thanks again, I get it. Things work again without anything special 
after a "git remote rm tiwai, git remote add tiwai <url>" cycle. That's 
ofcourse pretty horrible though. Really convinced by now that public 
repos that downstream users might have pulled should just not be 
rebased. Okay, the once per cycle as with that devel branch is probably 
okay but in essence any tree you rebase becomes a throw away tree that 
noone other than your upstream has any use for longer than once.

I'll keep the question on the GIT list outstanding due to the difference 
with "git pull" which I do still find unexpected.

Rene.
