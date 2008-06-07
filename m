From: "Christian Morales Vega" <cmorve69@yahoo.es>
Subject: Re: snd_pcm_avail_update() needed before
	snd_pcm_delay() with hda-intel
Date: Sat, 7 Jun 2008 08:25:37 +0200
Message-ID: <8235e6f40806062325v974543bn35c4a40fcfdf2677@mail.gmail.com>
References: <8235e6f40806061254v41604524l4e43647482602098@mail.gmail.com>
	<75b66ecd0806061746r1f542ed2i6c966465c1475152@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.225])
	by alsa0.perex.cz (Postfix) with ESMTP id EDC87245F2
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Jun 2008 08:25:38 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id h30so1031890wxd.23
	for <alsa-devel@alsa-project.org>; Fri, 06 Jun 2008 23:25:37 -0700 (PDT)
In-Reply-To: <75b66ecd0806061746r1f542ed2i6c966465c1475152@mail.gmail.com>
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

2008/6/7 Lee Revell:
>> 2- Is snd_pcm_avail_update() really useless when not using mmap?
>
> The pcm.c example referenced right below that comment would indicate otherwise:
snd_pcm_delay() was added after that example was created?

>> I have a SB Live! where snd_pcm_delay() always returns the correct
>> value, without any need for snd_pcm_avail_update(). But the same code
>> in the same machine with an hda-intel AD1988 needs a call to
>> snd_pcm_avail_update() before snd_pcm_delay() to give the correct
>> result. Without it snd_pcm_delay() always returns the value that *was*
>> correct in the last snd_pcm_writei() call.
>>
>> So should the "application frame position" be always updated, or only
>> in read/write operations? In the first case AD1988 fails, in the
>> second case perhaps SB Live! is making too mucho work ;-)
Rereading this...  "application frame position" only is updated in
read/write operations since is the only moment were it changes :-p The
problem would be with the update of the "sound frame position".

> Is this with the latest ALSA HG sources?
openSUSE Build Service multimedia:audio packages:
- alsa-1.0.16.hg20080510
- libasound2-1.0.16.hg20080510
- alsa-driver-kmp-default-1.0.16.20080606_2.6.22.17_0.1
