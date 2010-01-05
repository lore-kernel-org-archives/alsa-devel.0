From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
	is exceptionally large: 349696 bytes (1821 ms).
Date: Tue, 5 Jan 2010 10:32:51 +0800
Message-ID: <4f3252891001041832t60acdbd6rc46e408c9f5ef3c7@mail.gmail.com>
References: <1261191766.18070.10.camel@localhost.localdomain>
	<4f3252890912191547x1996cf7es190e8dac71dacaae@mail.gmail.com>
	<1261352484.18070.47.camel@localhost.localdomain>
	<1261869811.30924.69.camel@localhost.localdomain>
	<4f3252890912261739x372fb678yde8a8e0edb93fe6e@mail.gmail.com>
	<1261947691.24632.29.camel@localhost.localdomain>
	<4f3252890912272114t6dcfa58bj4d5b5e6e606c5004@mail.gmail.com>
	<1262058553.20808.15.camel@localhost.localdomain>
	<4f3252890912292307qc3c4b29m98c7d6e4c8fd6a7d@mail.gmail.com>
	<hhi2m3$26b$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 33BA910380B
	for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2010 03:32:53 +0100 (CET)
Received: by pwi18 with SMTP id 18so39265355pwi.32
	for <alsa-devel@alsa-project.org>; Mon, 04 Jan 2010 18:32:52 -0800 (PST)
In-Reply-To: <hhi2m3$26b$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/12/31 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 30/12/09 07:07 did gyre and gimble:
> > Why do PA server try to open an non-existing device iec958 so many times
> ?
>
> It has to try and open the device several times to probe for available
> profiles. This is only done at startup and then cached for the duration
> of the run in the form of a list of available profiles.
>
> Col
>
>

D: alsa-mixer.c: Checking for recording on Digital Surround 4.0 (IEC958)
(iec958-surround-40)
D: alsa-util.c: Trying iec958:0 with SND_PCM_NO_AUTO_FORMAT ...


Refer to http://thread.gmane.org/gmane.linux.alsa.devel/53004/focus=53038

SPDIF is limited to 2 channels when using PCM. DTS/AC3 is the only way
to get multi-channel out of SPDIF.


Have any PA developers really tested the "iec958-surround-40"  profile on
any machines ?
