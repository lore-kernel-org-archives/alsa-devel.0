From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [TINYCOMPRESS][v2 PATCH 0/7] Convert build system
 to autotools
Date: Tue, 24 Mar 2015 21:37:54 +0530
Message-ID: <20150324160754.GB32683@intel.com>
References: <1427193154-6753-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A6F2D26047F
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 17:12:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1427193154-6753-1-git-send-email-qais.yousef@imgtec.com>
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

On Tue, Mar 24, 2015 at 10:32:27AM +0000, Qais Yousef wrote:
> This series converts the build system to use autotools and splits the files into
> lib and utils.
> 
> Also patch 5 fixes error handling code.
> 
> I can't test Android builds but both cross and native compiling worked for me.
> 
> I left AUTHORS, ChangeLog and NEWS files empty. I used the license header to fill COPYING.
> 
> Changes in v2:
>  - Use -M option when generating the patches
>  - Add Makefile.am to include directory that exports tinycompress.h
>  - New patch (7) that fixes include dependency in tinycompress.h
This looks okay to me. I have two issue though:

1. So after applying tha patches, I did ./autogen.sh, that seems to have
updated INSTALL, do you know why?

2. For the fun part, I did make and then make install. Running cplay w/o
args should have printed the help menu, but that didnt ahppen

$ cplay
cplay: error while loading shared libraries: libtinycompress.so.0: cannot
open shared object file: No such file or directory

Not sure why...

I will try Android build possibly tomorrow

-- 
~Vinod
