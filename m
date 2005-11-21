From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 12/11] unpaged: fix sound Bad page states
Date: Mon, 21 Nov 2005 12:41:05 -0800
Message-ID: <20051121124105.1bf8090d.akpm@osdl.org>
References: <Pine.LNX.4.61.0511211801070.17464@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0511211801070.17464@goblin.wat.veritas.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hugh Dickins <hugh@veritas.com>
Cc: tiwai@suse.de, rmk+lkml@arm.linux.org.uk, wli@holomorphy.com, davem@davemloft.net, torvalds@osdl.org, nickpiggin@yahoo.com.au, airlied@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hugh Dickins <hugh@veritas.com> wrote:
>
>   arch/sparc/kernel/ioport.c |    2 +-
>   arch/sparc64/kernel/sbus.c |    2 +-
>   sound/core/memalloc.c      |    2 ++
>   3 files changed, 4 insertions(+), 2 deletions(-)

So with this, do you think everything is in place for a mainline merge?


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
