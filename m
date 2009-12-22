From: "Brian Welch" <Brian-Welch@cox.net>
Subject: Re: Installing a "different" version of Alsa
Date: Tue, 22 Dec 2009 14:50:42 -0700
Message-ID: <3DE0C4BC819942189FD9EA0AB2630C68@brianoffice>
References: <mailman.3791.1261331960.2074.alsa-devel@alsa-project.org>
	<69F4A42643E24687BFFD4D3D0F485DEA@brianoffice>
	<20091222125847.GB8522@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao107.cox.net (fed1rmmtao107.cox.net [68.230.241.39])
	by alsa0.perex.cz (Postfix) with ESMTP id C79C6245F9
	for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2009 22:50:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


----- Original Message ----- 
From: "Mark Brown" <broonie@opensource.wolfsonmicro.com>
To: "Brian Welch" <Brian-Welch@cox.net>
Cc: <alsa-devel@alsa-project.org>
Sent: Tuesday, December 22, 2009 5:58 AM
Subject: Re: [alsa-devel] Installing a "different" version of Alsa


> On Sun, Dec 20, 2009 at 11:34:03PM -0700, Brian Welch wrote:
>
>> I guess I don't understand exactly what you mean by "toolchain."  I've
>> already
>> contacted the people that package up the SDK and they said I should solve 
>> it
>
> I mean the people who produce whatever embedded Linux distribution you
> are using (you didn't mention?), or the user community surrounding it.
> If you're having trouble getting support from them there's other
> distributions out there such as the OpenEmbedded based ones which do
> have more of an active user community around them:
>
> http://openembedded.net/
>
>> myself.  I originally hoped that I could just re-build the kernel without
>> Alsa
>> built-in, then add my new version of Alsa, but they claim that causes 
>> other
>> issues (i.e. no sound at all).
>
> If it's just the drivers you need to update it's probably easier to
> merge the newer ALSA version into the kernel rather than trying to keep
> an out of tree version as well, it will hopefully reduce the level of
> confusion within the toolchain.

Hmmm, yeah, problems all the way around.  Maybe I should explain in
more detail.  This SDK is for a platform (silicon/software/dev-board) still
very much under development and I can't say too much without violating NDA,
etc.  The SDK is currently supported by the silicon manufacturer.  It 
includes a
vanilla Linux distribution directly from kernel.org and a small kernel 
patch.
In addition to the Linux distrubution there are drivers in the SDK for 
dozens of
custom devices including custom sound hardware.  Basically, they're rolling 
their
own toolchain and supporting it (for now).

I've written an Alsa-compatible sound driver layer to go between Alsa and
their custom driver and it's been working for a few months, but they 
recently
decided to start supporting two versions of the SDK, each having a different
version of Linux.  The version of Alsa built-in to Linux in each version of 
the
SDK is different, and they would like to supply a version of Alsa 
"out-of-tree"
so that both SDKs are the same and so that customers can theoretically
swap out to any version of Alsa they want.

This change has caused my driver to not build correctly/reliably on both
SDK versions.  The reason is that the symbols in linux/include/sound are
different than the out-of-tree include files that I need to build against. 
I can
make it work by hacking the SDK directory structure but they want to
eventually integrate everything into the SDK so minimizing hacks is 
desirable.

Merging the correct version of Alsa into the kernel will fix my immediate
problem but they don't want to do it because it won't satisfy the desire to
be able to swap in any version of Alsa (assuming that's actually possible).

Another thing I thought of was to fix up the kernel/include/sound directory
structure with soft links when "installing" the out-of-tree version of Alsa 
into
the SDK, but I didn't get a positive reaction when I suggested it.

Brian 
