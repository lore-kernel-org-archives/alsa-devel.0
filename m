From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [TINYCOMPRESS][PATCH 0/6] Convert build system to
	autotools
Date: Mon, 23 Mar 2015 22:10:55 +0530
Message-ID: <20150323164055.GA32683@intel.com>
References: <1427116145-519-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A03B260439
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 17:44:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1427116145-519-1-git-send-email-qais.yousef@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 23, 2015 at 01:08:59PM +0000, Qais Yousef wrote:
> This series converts the build system to use autotools and splits the files into
> lib and utils.
> 
> Also patch 5 fixes error handling code.
> 
> I can't test Android builds but both cross and native compiling worked for me.
> 
> I left AUTHORS, ChangeLog and NEWS files empty. I used the license header to fill COPYING.
Thanks :)

I was planning to do this after my current SKL work but this is welcome too.
Just one advise, pls generate patches using -M option, that shows code moves
nicely...

-- 
~Vinod

> 
> Qais Yousef (6):
>   Convert the build system to autotools
>   add .gitignore file
>   makefile.linux: delete as no longer necessary/used
>   Android.mk: Update to use the new location of source files
>   compress.c: fix check for errors from poll(), read() and write()
>   src/lib/utils.c: remove this empty file
> 
>  .gitignore            |  39 ++++
>  AUTHORS               |   0
>  Android.mk            |   6 +-
>  COPYING               |  51 ++++
>  ChangeLog             |   0
>  INSTALL               | 365 +++++++++++++++++++++++++++++
>  Makefile.am           |   3 +
>  NEWS                  |   0
>  autogen.sh            |   6 +
>  compress.c            | 632 -------------------------------------------------
>  configure.ac          |  31 +++
>  cplay.c               | 330 --------------------------
>  crec.c                | 489 --------------------------------------
>  m4/.place_holder      |   0
>  makefile.linux        |  41 ----
>  src/Makefile.am       |   1 +
>  src/lib/Makefile.am   |   5 +
>  src/lib/compress.c    | 634 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/utils/Makefile.am |  11 +
>  src/utils/cplay.c     | 330 ++++++++++++++++++++++++++
>  src/utils/crec.c      | 489 ++++++++++++++++++++++++++++++++++++++
>  utils.c               |  62 -----
>  22 files changed, 1968 insertions(+), 1557 deletions(-)
>  create mode 100644 .gitignore
>  create mode 100644 AUTHORS
>  create mode 100644 COPYING
>  create mode 100644 ChangeLog
>  create mode 100644 INSTALL
>  create mode 100644 Makefile.am
>  create mode 100644 NEWS
>  create mode 100755 autogen.sh
>  delete mode 100644 compress.c
>  create mode 100644 configure.ac
>  delete mode 100644 cplay.c
>  delete mode 100644 crec.c
>  create mode 100644 m4/.place_holder
>  delete mode 100644 makefile.linux
>  create mode 100644 src/Makefile.am
>  create mode 100644 src/lib/Makefile.am
>  create mode 100644 src/lib/compress.c
>  create mode 100644 src/utils/Makefile.am
>  create mode 100644 src/utils/cplay.c
>  create mode 100644 src/utils/crec.c
>  delete mode 100644 utils.c
> 
> -- 
> 2.1.0
> 

-- 
