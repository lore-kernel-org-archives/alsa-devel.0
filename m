From: "Christian Morales Vega" <cmorve69@yahoo.es>
Subject: Re: snd_pcm_avail_update() needed before
	snd_pcm_delay() with hda-intel
Date: Wed, 11 Jun 2008 20:07:28 +0200
Message-ID: <8235e6f40806111107h61e2853csde88ef9a7207d4c@mail.gmail.com>
References: <8235e6f40806061254v41604524l4e43647482602098@mail.gmail.com>
	<75b66ecd0806061746r1f542ed2i6c966465c1475152@mail.gmail.com>
	<8235e6f40806062325v974543bn35c4a40fcfdf2677@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.240])
	by alsa0.perex.cz (Postfix) with ESMTP id A6EA0248AF
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 20:07:29 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so2862902rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 11 Jun 2008 11:07:28 -0700 (PDT)
In-Reply-To: <8235e6f40806062325v974543bn35c4a40fcfdf2677@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/6/7 Christian Morales Vega <cmorve69@yahoo.es>:
>> Is this with the latest ALSA HG sources?
> openSUSE Build Service multimedia:audio packages:
> - alsa-1.0.16.hg20080510
> - libasound2-1.0.16.hg20080510
> - alsa-driver-kmp-default-1.0.16.20080606_2.6.22.17_0.1
Since there have been a big update (a month, from 05-10 to 06-10),
just note that with
- alsa-1.0.17rc1.git20080610-1.1
- libasound2-1.0.17rc1.git20080610-1.2
- alsa-driver-kmp-default-1.0.16.20080611_2.6.22.17_0.1-1.1
that now really is something similar to the latest sources, the
behavior is the same.
