From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: GIT: something wrong with sound-2.6/devel?
Date: Mon, 21 Jul 2008 11:47:46 +0100
Message-ID: <20080721104744.GA24668@rakim.wolfsonmicro.main>
References: <48844CA9.9060408@keyaccess.nl>
	<20080721095119.GD7083@sirena.org.uk>
	<48846749.7070906@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 47C3A103858
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 12:47:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48846749.7070906@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 21, 2008 at 12:39:05PM +0200, Rene Herman wrote:
> On 21-07-08 11:51, Mark Brown wrote:
>> On Mon, Jul 21, 2008 at 10:45:29AM +0200, Rene Herman wrote:

>> This means that the git remote is configured to only pull fast forwards
>> from that repository.  Add a + to the 'fetch =' for it in .git/config
>> and it'll track non-linear updates like you get when the remote rebases.

> I see.... thanks. I'll wait a bit with doing that then since it appears  
> that this rejection might be the behaviour I want from it -- am using  
> the devel branch specifically due to it only being rebased at releases.

It probably doesn't hurt to track the current state of the remote anyway
- even if the remote is rebased that won't affect the history of your
development branch and I can't off-hand think of a reason why it'd be
best to have the old status hanging around for a repo like this.

> ofcourse pretty horrible though. Really convinced by now that public repos
> that downstream users might have pulled should just not be rebased.  Okay,

Yes, that's the strongly expressed recommendation for things people
might want to base work on.
