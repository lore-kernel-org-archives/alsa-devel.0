From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Random process lockup on ARM board:
 alsa-lib-1.0.25, FUTEX_WAIT_PRIVATE
Date: Thu, 08 Mar 2012 15:35:00 +0100
Message-ID: <4F58C394.3020200@ladisch.de>
References: <1329393691.6830.20.camel@jonspc> <1329512682.29051.1.camel@jonspc>
	<1329570128.6670.0.camel@jonspc> <4F400BBF.9020707@ladisch.de>
	<1329603022.1089.57.camel@jonspc> <4F41FC28.1070605@ladisch.de>
	<1329926198.22918.10.camel@jonspc> <4F45167A.6080706@ladisch.de>
	<1329933773.24266.44.camel@jonspc>
	<4F58736F.6010500@ladisch.de> <1331199625.22455.7.camel@jonspc>
	<4F588213.2030600@ladisch.de> <1331203724.22455.44.camel@jonspc>
	<4F589B58.6090203@ladisch.de> <1331214439.27232.12.camel@jonspc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 4526810BA92
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 15:31:46 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A3FEB20D28
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 09:31:42 -0500 (EST)
In-Reply-To: <1331214439.27232.12.camel@jonspc>
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
> Getting closer, alsalib now builds without the need for pthreads but
> seems to insist on dlopen dlclose even in static lib ?

Add --without-libdl.


Regards,
Clemens
