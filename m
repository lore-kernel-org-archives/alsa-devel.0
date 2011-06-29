From: David Henderson <dhenderson@digital-pipe.com>
Subject: additional problem
Date: Wed, 29 Jun 2011 09:57:59 -0400
Message-ID: <4E0B2F67.3070304@digital-pipe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 55D631038F4
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 15:59:50 +0200 (CEST)
Received: by yxm34 with SMTP id 34so545237yxm.38
	for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2011 06:59:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi gang!  I've successfully been able to compile the alsa-utils package 
with the "--with-alsa-inc-prefix=/opt/staging/alsa/var/share/include 
--with-alsa-prefix=/opt/staging/alsa/lib", but the problem I'm having 
now is that the compiled binaries are looking for those directories 
during run-time and not just compile-time.  Does anyone have any 
thoughts on using those directories for package creation, but that the 
software doesn't use the '/opt/staging/alsa' prefix during run-time?

Thanks,
Dave
