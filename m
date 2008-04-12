From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH] snd_usb_caiaq: use likely()/unlikely()
Date: Sun, 13 Apr 2008 00:38:08 +0300
Message-ID: <20080412213808.GC8849@cs181133002.pp.htv.fi>
References: <20080412201331.GA13041@buzzloop.caiaq.de>
	<20080412202127.GB8849@cs181133002.pp.htv.fi>
	<20080412210119.GB13041@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 4130224492
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Apr 2008 23:39:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080412210119.GB13041@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 12, 2008 at 11:01:19PM +0200, Daniel Mack wrote:
> Hi,
> 
> On Sat, Apr 12, 2008 at 11:21:27PM +0300, Adrian Bunk wrote:
> > Does it bring any measurable advantage?
> > 
> > Otherwise it's usually better to let the compiler decide how to optimize 
> > the code.
> 
> I didn't really measure, but how should the compiler know how likely a
> certain condition in hardware state is? I thought, in such cases it's
> generally a good idea to give the compiler some hints.

gcc's heuristics often tends to guess better than programmers on how to 
optimize code since most people who think they know better how code 
should get optimized than the compiler do not actually know better...

And what you call "some hints" _forces_ the compiler to optimize for a 
certain condition (even if this e.g. results in bigger code or 
omitting some optimization).

Considering the lines of code and the number of contributors to the 
Linux kernel some annotations are always wrong and might cause more
harm than the correct ones gain.

If it's some hotpath and a current gcc does generate measurably faster 
code with a likely/unlikely it's justified, but otherwise it's better to 
leave gcc all freedom on how to optimize it.

> Daniel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
