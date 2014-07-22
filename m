From: David Henningsson <david.henningsson@canonical.com>
Subject: Alsa-info.sh is never released
Date: Tue, 22 Jul 2014 08:03:34 +0200
Message-ID: <53CDFEB6.5070600@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id F09C72654EC
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 08:03:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: adconrad@0c3.net, luke.yelavich@canonical.com
List-Id: alsa-devel@alsa-project.org

Hi,

Since ~two years back Ubuntu ships alsa-info.sh on new installations, in 
order to have bug reports that are upstream compatible.

However, alsa-info.sh seems to be a part of the alsa-driver git tree, 
and the alsa-driver package is not released anymore, since we think that 
is a part of the Linux kernel. As a result, alsa-info.sh is no longer 
part of an upstream tarball that we can package in the usual way.

So maybe we should move alsa-info somewhere else, e g alsa-utils? What 
do you think?



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
