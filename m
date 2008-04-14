From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Mon, 14 Apr 2008 18:50:16 +0200
Message-ID: <20080414165016.GE22115@tango.0pointer.de>
References: <20080411204610.GA32413@tango.0pointer.de>
	<20080412133536.GC32491@tango.0pointer.de>
	<4800FC14.3060804@superbug.co.uk>
	<200804122025.57165.faber@faberman.de>
	<48010CF9.4000600@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id EEA8A244FB
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 18:50:16 +0200 (CEST)
Content-Disposition: inline
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

On Sat, 12.04.08 20:26, James Courtier-Dutton (James@superbug.co.uk) wrote:

> Thats not very helpful really.
> What value should we set it to then?
> Another alternative could be to leave everything at 0dB except the master.
> For the master we could select say minimum dB + 12.
> So, if the Master ranged from -70 to 0 dB, we would set Master to -70 + 
> 12 = -58dB.
> 
> Would that suit everyone better.

I am not so sure about this scheme. There are a couple of devices
around where the minimal volume is still pretty high (like these
Logitech USB speakers of mine). With them the default volume would
then be very, very loud.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
