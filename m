From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sat, 12 Apr 2008 21:37:26 +0200
Message-ID: <48010F76.1070209@keyaccess.nl>
References: <20080411204610.GA32413@tango.0pointer.de>	<20080412133536.GC32491@tango.0pointer.de>	<4800FC14.3060804@superbug.co.uk>	<200804122025.57165.faber@faberman.de>
	<48010CF9.4000600@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id DFDE424432
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Apr 2008 21:34:49 +0200 (CEST)
In-Reply-To: <48010CF9.4000600@superbug.co.uk>
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

On 12-04-08 21:26, James Courtier-Dutton wrote:

> Another alternative could be to leave everything at 0dB except the master.
> For the master we could select say minimum dB + 12.
> So, if the Master ranged from -70 to 0 dB, we would set Master to -70 + 
> 12 = -58dB.
> 
> Would that suit everyone better.

On the aforementioned cs4236 which has a master -94.5 to +12 dB, 0dB 
actually is the sane default (and the value I keep it at). It is an idea to 
also init master to 0 dB iff master isn't just attenuation?

Rene.
