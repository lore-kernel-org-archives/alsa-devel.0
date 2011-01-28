From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA mixer query
Date: Fri, 28 Jan 2011 14:00:23 +0100
Message-ID: <4D42BDE7.5000606@ladisch.de>
References: <16F32A3F9AF4E441B752BCD79C151ACA69CF0CF4EA@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 208012455C
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 14:00:07 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA69CF0CF4EA@EXGMBX01.sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan Shaikh <irfan.shaikh@sasken.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Irfan Shaikh wrote:
> I am rendering audio to a PCM playback device (hw:0,0). I also need
> to render the same audio data to second PCM playback device (hw:0,1).
> 
> 1) Can i use ALSA mixer APIs so that i give PCM audio data to 1
>    playback device or some common interface, but the PCM audio data
>    is rendered to both devices (hw:0,0 and hw:0,1)

The mixer API ist just an interface to the hardware, so this would
depend on the hardware's capabilities.

However, you could use the plugin mechanism to create a virtual PCM
device that routes its data to two actual devices.  See
<http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html#pcm_plugins_multi>.

> SASKEN BUSINESS DISCLAIMER: This message may contain bla bla bla ...

This e-mail contains public information intended for any subscriber of
this mailing list and for anybody else who bothers to read it; it will
be copied, disclosed and distributed to the public.  If you think you
are not the intended recipient, please commit suicide immediately.
These terms apply also to any e-mails quoted in, referenced from, or
answering this e-mail, and supersede any confidentiality notices in
those e-mails.  Additionally, confidentiality notices in those e-mails
will incur legal processing fees of $42 per line; you have agreed to
this by reading this confidentiality notice.



Regards,
Clemens
