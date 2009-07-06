From: Guilherme Longo <grlongo.ireland@gmail.com>
Subject: snd_pcm_format_set_silence parameter
Date: Mon, 06 Jul 2009 10:26:44 -0300
Message-ID: <4A51FB94.80802@gmail.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>	<1246878557.3192.25.camel@linux-1lbu>
	<20090706115442.GA8925@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f192.google.com (mail-px0-f192.google.com
	[209.85.216.192])
	by alsa0.perex.cz (Postfix) with ESMTP id C0122245C3
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jul 2009 15:26:49 +0200 (CEST)
Received: by pxi30 with SMTP id 30so466683pxi.16
	for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2009 06:26:48 -0700 (PDT)
In-Reply-To: <20090706115442.GA8925@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Mates,

What exactly does snd_pcm_format_set_silence is useful for???


That is the code:

if (count < chunk_size)    {
        snd_pcm_format_set_silence(hwparams.format, data + count * 
bits_per_frame / 8, (chunk_size - count) * hwparams.channels);
        count = chunk_size;
    }

Could I get some help?
Thanks
