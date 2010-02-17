From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: safe support for rewind in ALSA
Date: Wed, 17 Feb 2010 16:36:32 +0100
Message-ID: <20100217153632.GC6891@tango.0pointer.de>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<20100201180139.GC15509@sirena.org.uk>
	<alpine.LNX.2.00.1002011903330.25340@eeebox2.perex-int.cz>
	<alpine.DEB.1.10.1002012239220.3125@ecabase.localdomain>
	<alpine.DEB.1.10.1002012328440.3125@ecabase.localdomain>
	<4f3252891002081459q29f02414hf168a596ab641995@mail.gmail.com>
	<alpine.DEB.1.10.1002092242540.3125@ecabase.localdomain>
	<4f3252891002100519h132fddb8t1f2bc56e97bf5c40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 70CA2103899
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 16:36:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4f3252891002100519h132fddb8t1f2bc56e97bf5c40@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 10.02.10 21:19, Raymond Yau (superquad.vortex2@gmail.com) wrote:

> most of the motherboard which have ISA bus for the ISA sound card did not
> have high resolution timer ( PA glitch free mode require high resolution
> timer )
> 
> The rest of those sound cards which have period_mins = 1 are regarded as
> broken by PA developer  (e.g. intel8x0 ,emu10k1 , ens1371 , ... ) and aplay
> did not work with one period per buffer too.

Actually most of these drivers work fine these days with PA.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
