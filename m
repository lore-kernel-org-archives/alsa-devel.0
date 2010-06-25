From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: AndreaElectronics PureAudio USB-SA
Date: Fri, 25 Jun 2010 10:25:00 +0200
Message-ID: <4C2467DC.9020302@ladisch.de>
References: <4C23E611.9040309@l2f.inesc-id.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E630D1039A7
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 10:25:01 +0200 (CEST)
In-Reply-To: <4C23E611.9040309@l2f.inesc-id.pt>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: rmfc <rmfc@l2f.inesc-id.pt>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

rmfc wrote:
> I'm trying to use any USB sound card with some DSP processing that
> allows a microphone array to capture audio and use in speech recognition
> (mostly applied in noisy environments). The best device that I found so
> far is AndreaElectronics PureAudio USB-SA but unfortunately it isn't
> properly supported in Linux/Alsa. The device is recognized as an USB
> Audio device (snd_usb_audio) and I can record audio in Audacity. The
> problem is that none of DSP features is explicitly activated in USB
> configuration so it works almost like any other microphone.
> I then tried Asus Xonar U1 but the problem is the same, no configuration
> is done in such devices, so they record audio without enough quality to
> be used by a speech recognizer (not enough energy, audio DC components
> when software gain is applied in Sound Preferences...).

Neither of these device has a DSP; any processing is done in software
in the Windows driver.


Regards,
Clemens
