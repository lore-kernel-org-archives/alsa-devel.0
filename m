From: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Subject: Re: ham radio OSS duplex realtime mmap program.
Date: Fri, 26 Sep 2003 19:36:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030926183656.GA32451@ecs.soton.ac.uk>
References: <3F746479.5040805@libero.it> <200309261614.h8QGEQ3X011667@oud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200309261614.h8QGEQ3X011667@oud>
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

On Fri, Sep 26, 2003 at 12:14:26 -0400, Paul Davis wrote:
> >According to my measurement your belief is definitely false for add/sub, 
> >sometimes true for mul and very likely true for div.
> 
> my belief is based on measurements done by tomshardware, arstechnica
> and others. that doesn't mean it can't be wrong.

My belief is that its much more complex than that :)

It realy depends how much parellelism there is in your algorithm, PIV /
Athlon class cpus can perform more FP operations in parrallel that integer,
so, although each float operation can take longer than the equivalent
integer operation to execute, the whole inner loop may run in less cycles.

That before you even get into SIMD operations.

- Steve


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
