From: "Breton M. Saunders" <breton.saunders@ntlworld.com>
Subject: Memory allocation problem using GFP_COMP?
Date: Fri, 12 Jan 2007 17:37:05 +0000
Message-ID: <45A7C741.6060904@ntlworld.com>
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

Folks,

  I've got a problem in allocating DMA memory on ARM for a driver on 2.6.19:

  The function snd_malloc_dev_pages requests memory using the 
dma_alloc_coherent function on line 222 of sound/core/memalloc.c.  This 
allocation is done with the bit __GFP_COMP set, which throws an oops in 
the ARM memory allocation __dma_alloc.  My understanding from speaking 
with Russell King is that __GFP_COMP should never be specified when 
calling dma_alloc_coherent.

  Is this a bug?

    Cheers,

       -Brett


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
