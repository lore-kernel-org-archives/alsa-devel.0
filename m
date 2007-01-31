From: Daniel Yek <dyek@real.com>
Subject: 32-bit ALSA application ABI-compatible on 64-bit
	Fedora Core 6?
Date: Wed, 31 Jan 2007 07:51:43 -0800
Message-ID: <6.2.1.2.2.20070131072922.58b0fc90@mailone.real.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

Hi,

I installed 64-bit Fedora Core 6, hoping to be able to use 32-bit chroot 
environment on 64-bit OS, so that I can develop for both architectures on 
the same dev. machine.

So far, the compilation, etc., went well in the chroot environment. 
However, I have a problem playing audio clips from a 32-bit application on 
the 64-bit OS, making it less ideal as my 32-bit dev. machine. I heard 
fast-paced audio (with channels data mixed up, I believe, causing noise.) 
We somehow ended with 2-bit sample-width output (supposed to be 16-bit.)

At this point, I just want to gather some information, until I have time to 
delve further into it.

Is 32-bit ALSA application supposed to be able to play on a 64-bit OS (with 
parallel 32-bit + 64-bit libraries installed)? Is 32-bit alsa-lib 
ABI-compatible with the 64-bit ALSA module in the kernel?

As always, appreciate your insights! Thank you.


-- 
Daniel Yek


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
