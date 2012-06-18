From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 2.6.18 unknown symbol ksize error
Date: Mon, 18 Jun 2012 10:25:06 +0200
Message-ID: <4FDEE5E2.70604@ladisch.de>
References: <28300.101.169.127.232.1339918064.squirrel@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 9AEB8245A1
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2012 10:25:10 +0200 (CEST)
In-Reply-To: <28300.101.169.127.232.1339918064.squirrel@boosthardware.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> I have compiled the latest stable alsa drivers against 2.6.18 kernel with
> gcc-4.1.
>
> I am getting an error when I insert the sound card modules.
>
>     snd_rawmidi: Unknown symbol ksize
>
> As far as I can tell 2.6.18 has support for ksize so I am not sure where
> this error is coming from.

That kernel didn't export ksize.

Try --with-debug=memory to get a separate allocator implementation.


Regards,
Clemens
