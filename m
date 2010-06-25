From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Detecting if a pcm device is a digital or analog
 one
Date: Fri, 25 Jun 2010 10:21:33 +0200
Message-ID: <4C24670D.4010501@ladisch.de>
References: <AANLkTinFnfXXikPmn1vGmt2WHQQnhGAzav9nYOvB4Vda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id F280D1039A3
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 10:21:42 +0200 (CEST)
In-Reply-To: <AANLkTinFnfXXikPmn1vGmt2WHQQnhGAzav9nYOvB4Vda@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean-Yves Avenard <jyavenard@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jean-Yves Avenard wrote:
> I was wondering if there was any way to accurately distinguish between
> audio device, if it has an analog or a digital output.

Not really.  There are devices where the same stream is routed to both
analog and digital outputs, and sometimes the driver cannot know if
there is a DAC further down the line.  In any case, this would be very
hardware specific.

What do you need this for?


Regards,
Clemens
