From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio device syncpipe error
Date: Thu, 09 Sep 2010 09:50:42 +0200
Message-ID: <4C8891D2.1020300@ladisch.de>
References: <AANLkTinzHSVgsUocCMBTW=+A=b2qc6vzKuq7t9jzgojX@mail.gmail.com>
	<AANLkTi=EXqFDPn+a1K+OeLA+G5pnh0yMt6nX2VA_wQDD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 7F8D124552
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Sep 2010 09:50:19 +0200 (CEST)
In-Reply-To: <AANLkTi=EXqFDPn+a1K+OeLA+G5pnh0yMt6nX2VA_wQDD@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 6275 kson <6275.kson@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

6275 kson wrote:
> cannot submit syncpipe for urb 0, error -90: internal error

Documentation/usb/error-codes.txt says:
| -EMSGSIZE       (a) endpoint maxpacket size is zero; it is not usable
|                     in the current interface altsetting.
|                 (b) ISO packet is larger than the endpoint maxpacket.
|                 (c) requested data transfer length is invalid: negative
|                     or too large for the host controller.

So, what is the sync packet size?


Regards,
Clemens
