From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Random process lockup on ARM board:
 alsa-lib-1.0.25, FUTEX_WAIT_PRIVATE
Date: Wed, 22 Feb 2012 17:23:22 +0100
Message-ID: <4F45167A.6080706@ladisch.de>
References: <1329393691.6830.20.camel@jonspc> <1329512682.29051.1.camel@jonspc>
	<1329570128.6670.0.camel@jonspc> <4F400BBF.9020707@ladisch.de>
	<1329603022.1089.57.camel@jonspc> <4F41FC28.1070605@ladisch.de>
	<1329926198.22918.10.camel@jonspc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 1BAFF1040D1
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 17:20:45 +0100 (CET)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id F19EB21EEC
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 11:20:41 -0500 (EST)
In-Reply-To: <1329926198.22918.10.camel@jonspc>
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
> On Mon, 2012-02-20 at 08:54 +0100, Clemens Ladisch wrote:
>> Jonathan Andrews wrote:
>>> I've tried building alsalib in many ways, at the moment its :
>>> $ ./configure --target=arm-linux --host=i686-linux --enable-shared --disable-static --without-pthread
>>
>> Try adding --disable-ucm and --disable-python.
>
> Err ok, alsa-lib still builds ok.

Now it doesn't use any pthread functions.

> My application runs for longer, but still freezes in the end. With the
> same futex locking problem.

I'd guess that this is not an alsa-lib problem.
Now you really need a stack trace.


Regards,
Clemens
