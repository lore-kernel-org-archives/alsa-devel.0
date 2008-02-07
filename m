From: Rene Herman <rene.herman@keyaccess.nl>
Subject: GIT submodules
Date: Thu, 07 Feb 2008 22:24:44 +0100
Message-ID: <47AB771C.8020402@keyaccess.nl>
References: <s5hwspjzbt0.wl%tiwai@suse.de>	<Pine.LNX.4.61.0802061437190.8113@tm8103.perex-int.cz>	<Pine.LNX.4.61.0802061505470.8113@tm8103.perex-int.cz>	<47AA1361.7070201@keyaccess.nl>
	<s5h7ihhknez.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 14DAC24655
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 22:23:28 +0100 (CET)
In-Reply-To: <s5h7ihhknez.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, git@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 07-02-08 12:37, Takashi Iwai wrote:

(sorry, that's not git-devel@, but simply git@)

>> I believe the git submodule stuff would also nicely allow all of ALSA to be 
>> one giant repo basically, with kernel, lib, ..., as submodules.
> 
> Just out of curiosity, what could be a merit of submodules in the case
> of ALSA?

Given that they're used for larger projects, I can't say I've used them but
I read about them when Linus mentioned them in the context of KDE maybe
switching:

http://lwn.net/Articles/246381/

Basically, submodules are the  actual git repositories with one organizing
superproject. This seems to be a fairly nice description of the submodule
support:

http://www.ishlif.org/blog/linux/git-submodules/

What they provide is stitching the parts together nicely into one coherent
release. In this case, you'd have alsa-driver, alsa-lib, alsa-utils and so
on repos, and an "alsa-project" superproject tying them together, where you
could do checkouts of a complete coherent release off all the modules for
example.

As said, I haven't actually used them, so I've added the git list (*) to see
if anyone has something to add, correct or explain (please do!). Submodules
seem to be intended exactly for the kind of setup that ALSA is using with
the many semi-independent parts...

(*) git list: alsa-devel is moderated for non-subscribers but you'll be
whitelisted after landing in the queue once if you're not a subscriber

Rene.
