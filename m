From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: davinci-mcasp: Set rule constraints if
 implicit BCLK divider is used
Date: Mon, 13 Apr 2015 16:58:20 +0300
Message-ID: <20150413135820.GY10964@mwanda>
References: <20150410093336.GA5779@mwanda> <552BAADA.5060401@ti.com>
 <20150413121639.GU16501@mwanda> <552BC568.7070907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 5626C261A95
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 15:59:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <552BC568.7070907@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 13, 2015 at 04:32:24PM +0300, Jyri Sarha wrote:
> On 04/13/15 15:16, Dan Carpenter wrote:
> >Thanks for looking at this.  I haven't double checked your analysis, but
> >512 means the stack is 2k and that's too high.  I think there is
> >supposed to be a build warning if we use more than 1k of stack in a
> >function?
> >
> >It's better to allocate it with kmalloc() and free it at the end.
> >
> >regards,
> >dan carpenter
> >
> 
> The function may get called hundreds or even thousands of times when
> an audio stream is started. How heavy is kmalloc/free cycle?
> 
> Using kmalloc just feels a bit stupid since in any remotely feasible
> case the maximum number of channels is 8. But maybe I just should
> not care.

I'm a total newbie to this specific so I can't really advise you.  I
did find the limit where GCC prints a warning:

home/kisskb/slave/src/net/rds/iw_rdma.c: warning: the frame size of 1052 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 200:1 =>

Since this could go up to 2k that's pretty huge.  One idea is to just
say:

	int small_buffer[64];
	int size = ci->max - ci->min + 1;
	int *list = &small_buffer;

	if (size > 64)
		list = kmalloc();

	...

free:
	if (size > 64)
		kfree(list);

If you've looked at the call trees which call this function and we can't
actually run out of space then that's probably fine too.  I don't think
there are any arches which still use 4k stacks.

regards,
dan carpenter
