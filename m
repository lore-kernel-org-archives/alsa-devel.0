From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: get two mono channel from stereo line
Date: Tue, 28 Jul 2009 09:29:17 +0200
Message-ID: <4A6EA8CD.7060205@ladisch.de>
References: <c697747b0907232107k749c413bx2a88ccc97505447b@mail.gmail.com>	
	<4A697A4F.6000809@ladisch.de>	
	<c697747b0907272008m291a97ach6b7cfbab4e2da50d@mail.gmail.com>
	<c697747b0907272239w379d52cew5c31d285b1552f10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C24ED245B9
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jul 2009 09:29:14 +0200 (CEST)
In-Reply-To: <c697747b0907272239w379d52cew5c31d285b1552f10@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: arif setiawan <n.arif.setiawan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

arif setiawan wrote:
> It worked now. thank you. Apparently we changed something in your
> plugin sample.

Sorry, that was my error; I wrote a wrong number for the right dshare
plugin.

> The ipc_key for dshare in both left and right is supposed to be same
> right?, also for dsnoop.

Yes; the two processes that are to share the device use this to
communicate with each other.


Best regards,
Clemens
