From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Random process lockup on ARM board:
 alsa-lib-1.0.25, FUTEX_WAIT_PRIVATE
Date: Sat, 18 Feb 2012 21:36:15 +0100
Message-ID: <4F400BBF.9020707@ladisch.de>
References: <1329393691.6830.20.camel@jonspc> <1329512682.29051.1.camel@jonspc>
	<1329570128.6670.0.camel@jonspc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 8E55C24366
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2012 21:36:55 +0100 (CET)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1064B20982
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2012 15:36:52 -0500 (EST)
In-Reply-To: <1329570128.6670.0.camel@jonspc>
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
> On Fri, 2012-02-17 at 21:04 +0000, Jonathan Andrews wrote:
>> # strace -p 443
>>> futex(0x4030e144, FUTEX_WAIT_PRIVATE, 2, NULL
>>
>> locks up.  Stops, stalls ... fails to continue ....
>>
>> Now tried several alsa-lib versions.  A clue would be nice?
>> What do I replace to fix this ?
>>
> Now tried 2 kernels, 3 versions of alsalib still stalls.

The synchronization calls in alsa-lib shouldn't block unless you're
actually using several threads, and even then you wouldn't be able
to reproduce it so reliably.

Do you have a stack trace to find out where this is called from?

Can you confirm that pthread mutexes work on your board?


Regards,
Clemens
