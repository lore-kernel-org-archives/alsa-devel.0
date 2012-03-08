From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Random process lockup on ARM board:
 alsa-lib-1.0.25, FUTEX_WAIT_PRIVATE
Date: Thu, 08 Mar 2012 09:53:03 +0100
Message-ID: <4F58736F.6010500@ladisch.de>
References: <1329393691.6830.20.camel@jonspc> <1329512682.29051.1.camel@jonspc>
	<1329570128.6670.0.camel@jonspc> <4F400BBF.9020707@ladisch.de>
	<1329603022.1089.57.camel@jonspc> <4F41FC28.1070605@ladisch.de>
	<1329926198.22918.10.camel@jonspc> <4F45167A.6080706@ladisch.de>
	<1329933773.24266.44.camel@jonspc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 4B19010B99A
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 09:49:49 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E744920549
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 03:49:45 -0500 (EST)
In-Reply-To: <1329933773.24266.44.camel@jonspc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jon@jonshouse.co.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jonathan Andrews wrote:
> On Wed, 2012-02-22 at 17:23 +0100, Clemens Ladisch wrote:
>> Now it doesn't use any pthread functions.
>
> Thanks, use or require ? Still complains if I static compile my
> application but don't link with pthreads.

Please try with the patch below; this should remove the last
occurence of pthreads in alsa-lib.


Regards,
Clemens


--- alsa-lib/configure.in
+++ alsa-lib/configure.in
@@ -512,6 +512,7 @@ if test "$HAVE_LIBDL" != "yes"; then
 fi

 if test "$HAVE_LIBPTHREAD" != "yes"; then
+  build_pcm_meter="no"
   build_pcm_share="no"
 fi
