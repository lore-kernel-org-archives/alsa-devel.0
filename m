From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Frame-based access (via mmap) and
	cross-device	synchronisation
Date: Tue, 21 Jul 2009 15:49:25 +0200
Message-ID: <4A65C765.7040500@ladisch.de>
References: <1b270aae0907200703l50ddd108se3ad0f6801113540@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 38A60103815
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 15:49:11 +0200 (CEST)
In-Reply-To: <1b270aae0907200703l50ddd108se3ad0f6801113540@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Metathronius Galabant <m.galabant@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Metathronius Galabant wrote:
> At any given time x0, x1, ... xn I'd like to take some kind of
> "snapshot" of both devices, ask them "how many frame do you have?".
> This MUST NOT be restricted to the period, but it should be like
> device1 has 80 frames, device2 only has 78 frames.

Call snd_pcm_avail().  The granlarity of its return value is device
specific; e.g., chips like Emu10k1 or DS-1 move data in blocks of 256
or 512 samples, and USB uses 1-ms frames.  You are not guaranteed to
get a result that is more recent than the last period boundary,
although most devices can do better.


Best regards,
Clemens
