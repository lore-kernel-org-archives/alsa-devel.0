From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: Re: Cross compiling alsa-lib (again)
Date: Mon, 7 Jan 2008 16:05:45 +0000
Message-ID: <8b67d60801070805x5755db9cva66b2187f1f236a0@mail.gmail.com>
References: <8b67d60801061542o2673384oad87e11bd56012d4@mail.gmail.com>
	<1199702857.17059.1229845735@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by alsa0.perex.cz (Postfix) with ESMTP id 3456C24602
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 17:05:47 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id w49so4019437pyg.36
	for <alsa-devel@alsa-project.org>; Mon, 07 Jan 2008 08:05:45 -0800 (PST)
In-Reply-To: <1199702857.17059.1229845735@webmail.messagingengine.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 07/01/2008, Clemens Ladisch <cladisch@fastmail.net> wrote:
> Adrian McMenamin wrote:
> > $ aplay -D hw:0,0 /aine-email.wav
> > Playing WAVE '/aine-email.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
> > aplay: set_params:895: Access type not available
>
> This error message indicates that:
> 1) the "hw" plugin was found, i.e., the configuration files are installed
>   correctly and are found by alsa-lib; and
> 2) the driver apparently didn't set the SNDRV_PCM_INFO_INTERLEAVED flag.
>
>
> HTH
> Clemens
>

Well this is from the driver:

 .info = (SNDRV_PCM_INFO_NONINTERLEAVED),

Is it required to set SNDRV_PCM_INFO_INTERLEAVED ? Even if the
hardware doesn't support it? Surely alsa-lib is supposed to handle the
conversion in any case?
