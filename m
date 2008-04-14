From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Mon, 14 Apr 2008 19:28:49 +0200
Message-ID: <48039451.9020301@keyaccess.nl>
References: <20080411204610.GA32413@tango.0pointer.de>
	<20080412133536.GC32491@tango.0pointer.de>
	<4800FC14.3060804@superbug.co.uk>
	<200804122025.57165.faber@faberman.de>
	<48010CF9.4000600@superbug.co.uk> <20080412214143.GB2828@localhost>
	<48012FD7.6050904@superbug.co.uk> <48013316.80806@keyaccess.nl>
	<20080414165811.GG22115@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EEC52457A
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 19:25:59 +0200 (CEST)
In-Reply-To: <20080414165811.GG22115@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: mznyfn@0pointer.de
Cc: Florian Faber <faber@faberman.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 14-04-08 18:58, Lennart Poettering wrote:

> On Sun, 13.04.08 00:09, Rene Herman (rene.herman@keyaccess.nl) wrote:

>> I believe it can be concluded that there is no "generally good level". ALSA 
>> should ship /usr/share/alsa/cards/<card>.state files which at least lets a 
>> driver author decide on a sensible set of default mixer settings.
> 
> Yet another file that needs to be maintained.

I don't believe this would be a huge problem, but yes, it's a downside.

> Why not export this data like all the other data from the kernel? That
> way other apps (not just alsactl) could make use of this information. 

While I'm not particularly up on the issue, I believe controls which may be 
implemented completely in userspace means you definitely need to go through 
alsa-lib to get _possibly_ sensible results.

Rene.
