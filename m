From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re:
	=?utf-8?q?Period_time/size_in_adaptive_USB_-_alignme?=
	=?utf-8?q?nt_to=09nrpacks=3F?=
Date: Wed, 28 Dec 2011 14:00:55 +0100
Message-ID: <d230c209-78cd-4f34-bba4-b778eb88471e@email.android.com>
References: <4EF8D3FB.8090109@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 009BA10395B
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 13:58:53 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D9A1C20821
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 07:58:51 -0500 (EST)
In-Reply-To: <4EF8D3FB.8090109@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Pavel Hofman wrote:
>Each URB is issued always at nrpacks
>milliseconds. Each URB transfers 48 samples * 2 bytes * 2 channels *
>nrpacks milliseconds of bytes. The last URB of period keeps the same
>pace (nrpacks milliseconds), however holds only the remaining number of
>bytes.

No, the period's last URB uses only as many frames as needed.

>This creates ripples in the data stream bitrate, possibly
>leading
>to increased jitter of the PLL'd clock in the USB receiver.

Did you actually observe this?

>I am wondering if for the xx.000 Hz samplerates it made sense to offer
>only these aligned multiples in snd_pcm_hw_params_set_period_time_near.

Only for adaptive playback. And the URB length is also
derived from the period size, so I'd be interested in seeing
how this constraint would be implemented.


Regards,
Clemens
