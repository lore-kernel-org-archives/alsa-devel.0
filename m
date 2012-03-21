From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
 protection mode
Date: Wed, 21 Mar 2012 09:57:54 +0200
Message-ID: <4F698A02.1070306@ti.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
	<4F68AE51.808@bitmer.com>
	<CANOLnOMqK5-yWoEA=1x2a4-OQYy8xvBUwY_RVdqHeaz4TxL3eQ@mail.gmail.com>
	<4F68D898.5080606@bitmer.com>
	<CA+7tXigvqY19SPCajY2awV9rJRkTh33H8cO+FZ+Un0uK1f9voA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog108.obsmtp.com (na3sys009aog108.obsmtp.com
	[74.125.149.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 6005E1043D8
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 08:58:02 +0100 (CET)
Received: by lbbgi11 with SMTP id gi11so832991lbb.37
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 00:57:57 -0700 (PDT)
In-Reply-To: <CA+7tXigvqY19SPCajY2awV9rJRkTh33H8cO+FZ+Un0uK1f9voA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <tpiepho@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Grazvydas Ignotas <notasas@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 03/20/2012 09:47 PM, Trent Piepho wrote:
>> To me this looks more like a correct fix. At quick test I got single
>> xrun when starting up but not endless loop of them. Maybe need to tune a
>> bit with CONFIG_SND_PCM_XRUN_DEBUG=3Dy.
> =

> Does the ALSA API allow the driver to change start_threshold in the
> prepare function?  It seems what is needed is a minimum
> start_threshold constraint, but there aren't constaints for sw_params.

I did as well looked at the start_threshold, and came to the same
conclusion. It is sw_param, and the driver should not modify it.
The OSS emulation layer sets the start_threshold to 1, most application
sets the start threshold to the size of the buffer. Some legacy
application might not care about this at all. Others might want specific
threshold to start the actual playback.

> With that fix, you could have an app set start_threshold to 50 ms,
> write 51 ms of audio, and expect the stream to start.  But it won't,
> because the driver has increased start_threshold.  The app could have
> read back start_threshold from the driver, but I doubt any apps do
> this, since there is nothing in the documentation about that being
> necessary.

True, it is a sw_param, and the applications does not expect it to be
changed by the driver (since the driver should not change it).

-- =

P=E9ter
