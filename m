From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: MMAP in ALSA
Date: Tue, 25 May 2010 00:35:19 -0500
Message-ID: <AANLkTimglbiTg8jnpuOsJKt3BDuk4LALHicAVlp3AW68@mail.gmail.com>
References: <BCF80163639E9F4296FC4B208F99BA47013899D48F@orsmsx504.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A81824762
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 07:35:21 +0200 (CEST)
Received: by iwn1 with SMTP id 1so3906345iwn.38
	for <alsa-devel@alsa-project.org>; Mon, 24 May 2010 22:35:19 -0700 (PDT)
In-Reply-To: <BCF80163639E9F4296FC4B208F99BA47013899D48F@orsmsx504.amr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Varadarajan, Srikanth" <srikanth.varadarajan@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> Also, why are mmap and munmap operations required in ALSA?
> Right now, we do not have mmap and munmap operations exposed. Though the hardware constraints have "SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID" defined. Looks like, if we have to PulseAudio on top, mmap operations are required in ALSA.

mmap operations are not required by PulseAudio. Look at
pulseaudio/src/modules/alsa/alsa*.c, there's a mmap_write and a
unix_write.
