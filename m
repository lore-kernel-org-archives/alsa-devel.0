From: Madhu Pavan <kmp@linux.vnet.ibm.com>
Subject: alsa-lib-1.0.27.2 not compatible with ppc64le
	architecture
Date: Thu, 28 Nov 2013 11:17:26 +0530
Message-ID: <5296D8EE.7070104@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 by alsa0.perex.cz (Postfix) with ESMTP id B88A72651B4
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 06:47:37 +0100 (CET)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <alsa-devel@alsa-project.org> from <kmp@linux.vnet.ibm.com>;
 Thu, 28 Nov 2013 11:17:31 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 83DD81258051
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 11:18:27 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAS5lK9F1769972
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 11:17:21 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAS5lQF1020578
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 11:17:26 +0530
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
Cc: deepakcs@linux.vnet.ibm.com, athunugu@linux.vnet.ibm.com
List-Id: alsa-devel@alsa-project.org

Hi,

We are in the process of adding support for new arch (ppc64le) and as 
part of that we wanted to send patches for config.guess and configure as 
appropriate.

alsa-lib-1.0.27.2 could not be built on ppc64le because it had an 
outdated configure/config.guess/libtool.m4. Since your pkg uses libtool 
and the latest tarball of your pkg didn't build on ppc64le due to 
outdated libtool present on your system. We wanted to request you to 
upgrade your libtool to the alpha release of libtool which has all the 
bits and pieces needed for ppc64le support.

In that context, I wanted to confirm the below

1) Should we send patches to this mailing list or there is some other 
mailing list ?

2) New libtool alpha release which supports ppc64le arch is available, 
you may  pick up the alpha release from either of the below :

ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.gz (1.6MB)

ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.xz (920KB)

It would be great if you can install this new libtool which supports 
ppc64le, and spin the pkg and let us know the new tar availability. We 
can test it on ppc64le architecture for you.
Please let me know if you are planning to release or spin newer version.

Currently I used

http://www.alsa-project.org/main/index.php/Main_Page

Which does not have ppc64le support.

Your response is highly appreciated.

Thanks in advance,
Madhu Pavan Kothapally
