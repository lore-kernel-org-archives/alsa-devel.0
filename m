From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [TINYCOMPRESS][v2 PATCH 1/7] Convert the build
 system to autotools
Date: Mon, 30 Mar 2015 22:20:08 +0530
Message-ID: <20150330165008.GE7192@intel.com>
References: <1427193154-6753-1-git-send-email-qais.yousef@imgtec.com>
 <1427193154-6753-2-git-send-email-qais.yousef@imgtec.com>
 <55197399.9070202@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id D8420260559
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2015 18:54:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <55197399.9070202@imgtec.com>
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

On Mon, Mar 30, 2015 at 05:02:33PM +0100, Qais Yousef wrote:
> On 03/24/2015 10:32 AM, Qais Yousef wrote:
> >Hopefully this should make tinycompress a more robust package.
> >This change splits the source into utils and lib.
> >No functional changes was introduced.
> >
> >diff --git a/src/utils/Makefile.am b/src/utils/Makefile.am
> >new file mode 100644
> >index 000000000000..0a3fc43c92cb
> >--- /dev/null
> >+++ b/src/utils/Makefile.am
> >@@ -0,0 +1,11 @@
> >+bin_PROGRAMS = cplay crecord
> >+
> >+cplay_SOURCES = cplay.c
> >+crecord_SOURCES = cplay.c
> >+
> 
> This should be crec.c :-/
> 
> Can you fix when you apply or do you want me to send v3?
No issues I can fix it up

I am running few more stuff, I will merge this shortly

-- 
~Vinod
