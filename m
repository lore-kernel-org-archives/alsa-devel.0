From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: SGI/HAL2 architecture detection
Date: Fri, 3 Oct 2003 17:10:42 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031003221042.GB28811@dbz.icequake.net>
References: <20031003212654.GA28811@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20031003212654.GA28811@dbz.icequake.net>
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


Ok, I fixed this, and then discover that a Makefile is not generated in
/hal2 directory, so the build dies at that point.  What should I use for
a Makefile template for this directory?  Has anyone built this successfully?

Ryan

On Fri, Oct 03, 2003 at 04:26:54PM -0500, Ryan Underwood wrote:
> 
> In latest kernels, the file /usr/src/linux/include/asm/sgi/sgihpc.h
> has become /usr/src/linux/include/asm/sgi/hpc3.h.  Both files need to
> be checked in configure.in now to determine SGI architecture.
> 
> -- 
> Ryan Underwood, <nemesis at icequake.net>, icq=10317253
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
