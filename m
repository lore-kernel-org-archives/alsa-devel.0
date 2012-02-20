From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usb-audio: Correct way to do a mixer quirk?
Date: Mon, 20 Feb 2012 22:40:25 +0100
Message-ID: <4F42BDC9.4040605@ladisch.de>
References: <alpine.LNX.2.01.1202192059040.7408@stax.localdomain>
	<4F41FF5F.8040409@ladisch.de>
	<alpine.LNX.2.01.1202201945150.10992@stax.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id B46C0103DB4
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 22:41:06 +0100 (CET)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E2850211AC
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 16:41:03 -0500 (EST)
In-Reply-To: <alpine.LNX.2.01.1202201945150.10992@stax.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Hills <mark@pogo.org.uk>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Mark Hills wrote:
> On Mon, 20 Feb 2012, Clemens Ladisch wrote:
>> Mark Hills wrote:
>>> The Electrix Ebox-44 is a new USB interface, but the MIXER_UNIT descriptor
>>> is broken and refers to a non-existing unit_id.
>>
>> I'd suggest to change the code to not abort if a unit doesn't exist.
>
> It would seem a little strange to skip over the error for one specific
> condition to accomodate a specific device -- when the rest of the code
> does not generally do this?

It's still possible to complain about the broken firmware, but there is
no reason to prevent the user from accessing the PCM streams and all
other mixer controls just because one descriptors happens to be wrong.


Regards,
Clemens
