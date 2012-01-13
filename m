From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Read and write different buffer sizes
Date: Fri, 13 Jan 2012 16:01:28 +0100
Message-ID: <4F104748.2000900@ladisch.de>
References: <B927995C-7CD1-46DF-9B58-A4E62574A688@upatras.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 1CD0D24360
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 16:00:04 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3936423BAE
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 10:00:01 -0500 (EST)
In-Reply-To: <B927995C-7CD1-46DF-9B58-A4E62574A688@upatras.gr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Elias Kokkinis <ekokkinis@upatras.gr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Elias Kokkinis wrote:
> I would like to ask if it is possible in ALSA to define different
> buffer sizes in the input and output streams.

Yes.  (But which buffer sizes are allowed always depends on the
hardware's capabilities.)

> I am using PCM sound and I want to read 2048 samples, do some
> processing involving overlap-add and then keep 1024 of them and put
> them to the output. And so on...
>
> So I want to have the same sample rate and everything but different
> buffer sizes. Is this possible? I have tried an implementation of
> this, but I think the output for some reason still outputs 2048
> samples and the audio is choppy, like having 1024 samples of audio and
> 1024 of silence.

Regardless of the buffer size, when both devices run at the same rate,
you must output, on the average, as many samples as you have read.


Regards,
Clemens
