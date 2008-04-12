From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sun, 13 Apr 2008 00:23:57 +0200
Message-ID: <4801367D.3090207@keyaccess.nl>
References: <20080411204610.GA32413@tango.0pointer.de>	<20080412133536.GC32491@tango.0pointer.de>	<4800FC14.3060804@superbug.co.uk>	<200804122025.57165.faber@faberman.de>	<48010CF9.4000600@superbug.co.uk>
	<20080412214143.GB2828@localhost>
	<48012FD7.6050904@superbug.co.uk> <48013316.80806@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id C59AA244C5
	for <alsa-devel@alsa-project.org>;
	Sun, 13 Apr 2008 00:21:16 +0200 (CEST)
In-Reply-To: <48013316.80806@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Florian Faber <faber@faberman.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 13-04-08 00:09, Rene Herman wrote:

> On 12-04-08 23:55, James Courtier-Dutton wrote:
> 
>> Most consumer distos do not agree with me and want the volume turned 
>> up already by default. The problem is deciding on a generally good 
>> level for
>> these distros.
> 
> I believe it can be concluded that there is no "generally good level". 
> ALSA should ship /usr/share/alsa/cards/<card>.state files which at least 
> lets a driver author decide on a sensible set of default mixer settings.

With a bit of alsa-lib help, distros can then call "amixer defaults" to get 
a card-specific set of defaults loaded. Would that be good thing?

Was looking, but I see the mixer API documentation is totally absent...

Rene.
