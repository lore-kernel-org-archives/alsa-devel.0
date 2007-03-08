From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: pcm_multi broken in alsa-lib - no duplex mode with
	jackd
Date: Thu, 8 Mar 2007 19:02:31 +0000
Message-ID: <20070308190231.GA3066@localhost.localdomain>
References: <45F044D2.1060903@mnet-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <45F044D2.1060903@mnet-online.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 08, 2007 at 06:16:02PM +0100, Simon Lewis wrote:
> Dear ALSA Developers
> 
> When I attempted to combine several device drivers using the pcm_multi
> function in .asound.conf I learned the hardway that pcm_multi doesn't
> work in duplex mode with jackd. Apparently pcm_multi was broken in
> alsa-lib 1.0.9rc1 and has never been fixed.
> 
> Many JACK users have successfully used the following patch:
> 
> http://www.sound-man.co.uk/linuxaudio/pcm_multi-patch
> 
> I have since learned that many studio64 users have been bitten by this bug.
> 
> Please, please, please add the above patch to version 1.014 of ALSA libs
> before they are finally released as stable.

vote ++1

There are actually quite a few of us using multi-card setups
for high channel counts these days. The extra linking code
added to pcm_multi.c in 1.0.9rc1 stopped this from working
with jackd (which anybody using a Linux system as a serious
audio workstation will be using). I haven't noticed any problem
caused by removing it, and I've done many hours of multitrack
recording since then.

John

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
