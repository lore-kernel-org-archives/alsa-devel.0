From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: IEC958 / SPDIF raw capture
Date: Thu, 11 Feb 2010 08:26:34 +0100
Message-ID: <4B73B12A.7030508@ladisch.de>
References: <325dd9ac1002101514u73929570l51a12d28ecddd7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 07579243CA
	for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2010 08:26:37 +0100 (CET)
In-Reply-To: <325dd9ac1002101514u73929570l51a12d28ecddd7b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Donald Tournier <d.tournier@brain.org.au>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Donald Tournier wrote:
> We have an application in our institute that will require recording of
> a digital signal via an optical cable. We have to be able to guarantee
> perfect bitwise reproduction of the signal (the odd bit error is not a
> problem). We're thinking of using SPDIF and ALSA to capture the signal
> (obviously we'll have to make sure the signal is properly encoded to
> begin with).
> 
> However, after some initial attempts, it's becoming clear that ALSA
> can't necessarily guarantee bitwise perfect capture. ALSA might change
> the format, or resample the signal after capture (although I've heard
> that can be turned off with "snd_pcm_hw_params_set_rate_resample
> (capture_handle, hw_params, 0)").

If you open the device as "hw:x", ALSA will not do any conversions and
will give you the data exactly as it comes from the sound card.

> can this be done? If so, which card/driver would be recommended?

PCI(-E) cards based on C-Media chips (CMI87x8, CMI8770, AV200) are known
to allow bit-perfect digital capture.

> Ideally, we would like to capture the raw SPDIF subframes.

Some very old revisions of the CMI8738 did this, because proper decoding
of subframes wasn't implemented, but these aren't sold anymore.


HTH
Clemens
