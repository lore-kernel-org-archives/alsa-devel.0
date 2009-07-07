From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Wrong sample rate user space -> kernel space?
Date: Tue, 07 Jul 2009 17:10:00 +0200
Message-ID: <4A536548.70300@ladisch.de>
References: <20090707142942.GV18340@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 050791037FB
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 17:10:05 +0200 (CEST)
In-Reply-To: <20090707142942.GV18340@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> On a PXA embedded board, the sample rate propagation from user space to
> kernel space seems to be wrong.
> 
> When I start aplay (v1.0.19) from userspace like this ...
> 
>     # aplay -f dat /dev/urandom 
>     Playing raw data '/dev/urandom' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
> 
> ... params_rate(params) in my snd_soc_ops .hw_params callback returns
> 88200, not 48000.

It might be possible that userspace converts the sample rate because it
thinks that the driver doesn't support 48 kHz.

Is there a converter plugin in the output of "aplay -f dat -v /dev/urandom"?


Best regards,
Clemens
