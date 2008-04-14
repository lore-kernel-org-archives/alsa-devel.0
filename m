From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Mon, 14 Apr 2008 19:00:35 +0200
Message-ID: <48038DB3.8060301@keyaccess.nl>
References: <20080411204610.GA32413@tango.0pointer.de>
	<20080412133536.GC32491@tango.0pointer.de>
	<4800FC14.3060804@superbug.co.uk>
	<200804122025.57165.faber@faberman.de>
	<48010CF9.4000600@superbug.co.uk> <48010F76.1070209@keyaccess.nl>
	<20080414164843.GD22115@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BAA8245AB
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 18:58:00 +0200 (CEST)
In-Reply-To: <20080414164843.GD22115@tango.0pointer.de>
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

On 14-04-08 18:48, Lennart Poettering wrote:

> On Sat, 12.04.08 21:37, Rene Herman (rene.herman@keyaccess.nl) wrote:
> 
>>> For the master we could select say minimum dB + 12.
>>> So, if the Master ranged from -70 to 0 dB, we would set Master to -70 + 
>>> 12 = -58dB.
>>>
>>> Would that suit everyone better.
>> On the aforementioned cs4236 which has a master -94.5 to +12 dB, 0dB 
>> actually is the sane default (and the value I keep it at). It is an idea to 
>> also init master to 0 dB iff master isn't just attenuation?
> 
> Maybe this should be considered a driver bug?

No. It's a straighforward export of the hardware. If ALSA were to start 
hiding the hardware I were to start hiding ALSA -- in a dumpster.

And do not set Reply-To. You turn all CCs into To's for one and make others 
go through the troubl;e of fixing it again. If you can't be bothered with 
mail to your inbox stop posting to linux lists.

Rene.
