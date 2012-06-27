From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: periods_max initialization in snd_usb_hardware
Date: Wed, 27 Jun 2012 21:29:53 +0200
Message-ID: <4FEB5F31.8040809@ladisch.de>
References: <CA+F9FsDoX=X14qpzgoH+Fm8oEq8f36fwa02J1fQTD9eqbCnVSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 66B812447B
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 21:30:29 +0200 (CEST)
In-Reply-To: <CA+F9FsDoX=X14qpzgoH+Fm8oEq8f36fwa02J1fQTD9eqbCnVSw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Amit Nagal <helloin.amit@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Amit Nagal wrote:
> snd_usb_hardware is defined in sound/usb/pcm.c as ...
> periods_max is intialized with value = 1024 .
>
> but going by buffer_bytes_max and period_bytes_min value defined above ,
> periods_max = ( buffer_bytes_max / period_bytes_min ) = 16384 .
>
> why this upper cap of  1024 is maintained for  periods_max even though from
> calculation it comes as 16384 ?

The buffer is entirely handled by software; these limits are pretty much
arbitrary.

If there is a reason to change these limits, just send a patch.  :)


Regards,
Clemens
