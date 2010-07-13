From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Compiler errors in alsa-lib-1.0.22/test/*.c
Date: Tue, 13 Jul 2010 08:18:40 +0200
Message-ID: <4C3C0540.6020506@ladisch.de>
References: <AANLkTin75qlRIEXwE8_12m3GcGXagKY0lQhQ4hN9h_co@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6C08824600
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 08:18:44 +0200 (CEST)
In-Reply-To: <AANLkTin75qlRIEXwE8_12m3GcGXagKY0lQhQ4hN9h_co@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: john@swajime.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John Simpson wrote:
> I've been trying to use the alsa-lib API, but I haven't been able to
> get anything to compile.
> 
> ~/alsa/alsa-lib-1.0.22/test$ for f in *.c; do echo; cc $f 2>&1 | head -n2; done
> ...
> Did I miss something?

The makefile.

If alsa-lib is installed correctly, the only option you need for your
own programs is -lasound.


Regards,
Clemens
