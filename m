From: arne <sp113438@telfort.nl>
Subject: conflict between alsa-lib and libasound2-data
 regarding alsa.conf file:
Date: Mon, 23 Oct 2017 18:58:24 +0200
Message-ID: <20171023185824.38c4566e@fx4100>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cpsmtpb-ews02.kpnxchange.com (cpsmtpb-ews02.kpnxchange.com
 [213.75.39.5]) by alsa0.perex.cz (Postfix) with ESMTP id B5A0A266A0C
 for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2017 18:58:25 +0200 (CEST)
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
Cc: sp113438@telfort.nl
List-Id: alsa-devel@alsa-project.org

Hi,

Debian conflicts between alsa-lib_1.1.4 and libasound2-data 1.1.3:

in the source tree of alsa-lib I do:

./configure && make && sudo checkinstall

and the result is:

Unpacking alsa-lib (1.1.4.1-1) ...
dpkg: error processing
archive /home/temp/alsa-lib-1.1.4.1/alsa-lib_1.1.4.1-1_amd64.deb
(--install): trying to overwrite '/usr/share/alsa/alsa.conf', which is
also in package libasound2-data 1.1.3-5


This is on a Debian amd64 stable computer

Thanks!
