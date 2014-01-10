From: Patrick Welche <prlw1@cam.ac.uk>
Subject: alsa on non-linux
Date: Fri, 10 Jan 2014 15:37:00 +0000
Message-ID: <20140110153700.GC1173@quark.internal.precedence.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ppsw-52.csi.cam.ac.uk (ppsw-52.csi.cam.ac.uk [131.111.8.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 9193B265617
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:37:02 +0100 (CET)
Received: from gw.precedence.co.uk ([80.71.28.1]:57370
 helo=quark.internal.precedence.co.uk)
 by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:587)
 with esmtpsa (LOGIN:prlw1) (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
 id 1W1e8s-0003ec-Dg (Exim 4.82_3-c0e5623) for alsa-devel@alsa-project.org
 (return-path <prlw1@cam.ac.uk>); Fri, 10 Jan 2014 15:37:02 +0000
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am currently successfully running alsa-lib 1.0.22 with oss plugins on
a non-linux box. The advantage is that programs written to use libasound
work.

I just tried to update alsa-lib, and see that now alsa-lib directly
includes headers like linux/types.h, and all protection, such as

  #if defined(LINUX) || defined(__LINUX__) || defined(__linux__)

has been removed. This means that compilation on non-linux is
essentially impossible.

Is it that there is now a different way of obtaining that alsa lib
front end / oss back end layer?

Cheers,

Patrick
