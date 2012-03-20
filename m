From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
 protection mode
Date: Tue, 20 Mar 2012 15:47:31 -0400
Message-ID: <CA+7tXigvqY19SPCajY2awV9rJRkTh33H8cO+FZ+Un0uK1f9voA@mail.gmail.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
	<4F68AE51.808@bitmer.com>
	<CANOLnOMqK5-yWoEA=1x2a4-OQYy8xvBUwY_RVdqHeaz4TxL3eQ@mail.gmail.com>
	<4F68D898.5080606@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D930104376
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 20:47:33 +0100 (CET)
Received: by wibhq7 with SMTP id hq7so4599316wib.2
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 12:47:31 -0700 (PDT)
In-Reply-To: <4F68D898.5080606@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Grazvydas Ignotas <notasas@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 20, 2012 at 3:20 PM, Jarkko Nikula <jarkko.nikula@bitmer.com> wrote:
> On 03/20/2012 06:42 PM, Grazvydas Ignotas wrote:
>> This is what we have in pandora tree now:
>> http://git.openpandora.org/cgi-bin/gitweb.cgi?p=pandora-kernel.git;a=commitdiff;h=d494977441ac8f99d094b5e03398cb33a14e832a
>> Seems to work well for everything here.
>>
> To me this looks more like a correct fix. At quick test I got single
> xrun when starting up but not endless loop of them. Maybe need to tune a
> bit with CONFIG_SND_PCM_XRUN_DEBUG=y.

Does the ALSA API allow the driver to change start_threshold in the
prepare function?  It seems what is needed is a minimum
start_threshold constraint, but there aren't constaints for sw_params.

With that fix, you could have an app set start_threshold to 50 ms,
write 51 ms of audio, and expect the stream to start.  But it won't,
because the driver has increased start_threshold.  The app could have
read back start_threshold from the driver, but I doubt any apps do
this, since there is nothing in the documentation about that being
necessary.
