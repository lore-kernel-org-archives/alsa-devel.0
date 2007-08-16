From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Noisy audio - ALSA Configuration
Date: Thu, 16 Aug 2007 09:05:40 +0200
Message-ID: <1187247940.16551.1205659251@webmail.messagingengine.com>
References: <28FEEE653F330C4FA01F6C799E7BBA5E01CDD7D7@dlee10.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 44831243C2
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Aug 2007 09:05:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <28FEEE653F330C4FA01F6C799E7BBA5E01CDD7D7@dlee10.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Iovescu, Magdalena" <m-iovescu1@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Iovescu, Magdalena wrote:
> Does anyone have examples or documentation on how to configure periods,
> frames and buffers for various sample rates?

Frames don't need configuration; they are dependent on the sample format
only.  In your case (S16_LE, 2 channels), one frame = four bytes.

The buffer size determines latency.  Low latency is only important when
the audio data is generated from user input in real time; when you can
read (and decode) ahead, you should better use a rather large buffer to
reduce the possibility of underruns.

Periods aren't that important.  A period is the interval between two
interrupts, so it might be better to have more small periods than fewer
large ones (unless the interrupt overhead gets too high) so that your
application can get woken up more often, but there isn't much difference
in practice.

> [...] With a buffer this big, I do not get underruns, but all the
> writes are short writes. I have not been able to find the right
> configuration to avoid short writes,

Short writes happen where there is less free space in the buffer than
you are trying to write.  This is the normal case, there's nothing wrong
with that.  Is there a reason why you want to avoid them?


Regards,
Clemens
