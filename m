From: Josh Buhl <uzs33d@uni-bonn.de>
Subject: Re: A simple question, Alsa on debian
Date: Thu, 13 Feb 2003 12:26:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E4B80F7.8060205@uni-bonn.de>
References: <1045131577003508@lycos-europe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1045131577003508@lycos-europe.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm running alsa-0.9rc7 just fine on a slightly modified Debian 3.0r1 
(I've upgraded a few packages to versions in sarge or sid)  with kernel 
2.4.20.

I did not use the regular alsa tarball, but rather the
alsa-source_0.9.0rc7-1_all.deb available in sid. I made it with

make-kpkg --revision spleen.030205.1 modules_image


After I installed the thus made alsa-modules-2.4.20_0.9.0rc7-1_i386.deb
it did "run out of the box."

Does this help?

-josh


Erik Welander wrote:
> A simple question, does the current Alsa release tarball work out of the box ?as is?, i.e. ./configure ;make install on Debian current release, compiled kernel 2.4.20. 
> 
> I am doing some work on the es18xx.c and don?t want to hit my head in the wall if there are any problems with respect to the package system that would hinder progress. (It seems to work but alas I want to make sure with you professionals.)
> 
> By the way I think I am getting the hang of this now :-), It does take some knowledge in bit manipulation and knowing about the issues such as one read inb() equals 1 microsecond and not getting 0x-ed in your brain.
> 
> Best regards from Erik
> 
> _____________________________________________________________
> Här börjar internet!
> Skaffa gratis e-mail och gratis internet på http://www.spray.se
> 
> Träffa folk från hela Sverige på ett och samma ställe - http://chat.spray.se/
> 
> 

-- 
"When you wake up in the morning, Pooh," said Piglet at last,
"what's the first thing you say to yourself?"

"What's for breakfast?" said Pooh.  "What do you say, Piglet?"

"I say, 'I wonder what's going to happen exciting today?'" said Piglet.

Pooh nodded thoughtfully.  "It's the same thing," he said.

	-- A.A. Milne

-----------------------------------------------------
http://www.nyfairuse.org/

WTO + WIPO = DMCA http://www.anti-dmca.org

Innovation vs Patent Inflation http://swpat.ffii.org/

120000 voices and 400 Firms against logic patents
http://www.noepatents.org/
-----------------------------------------------------




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
