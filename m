From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Fri, 4 Sep 2009 00:03:24 +0200
Message-ID: <7c5010d60909031503k36a30855h6115e4689d1dd0f4@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<s5h1vmoqc71.wl%tiwai@suse.de>
	<7c5010d60909030835n2d62756cr1e29de479b7a9d97@mail.gmail.com>
	<s5hws4gox1l.wl%tiwai@suse.de>
	<7c5010d60909031003l317d7325s9082a30c418a28f8@mail.gmail.com>
	<s5hzl9bc3mo.wl%tiwai@suse.de>
	<7c5010d60909031127m51a91cceqbe48f3115a0ef6d2@mail.gmail.com>
	<s5h1vmnde4b.wl%tiwai@suse.de>
	<7c5010d60909031252v25a71577s3655297e47aa6fa2@mail.gmail.com>
	<s5hfxb3k8v8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DA7A10385F
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 00:03:25 +0200 (CEST)
Received: by bwz25 with SMTP id 25so299293bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2009 15:03:24 -0700 (PDT)
In-Reply-To: <s5hfxb3k8v8.wl%tiwai@suse.de>
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

On Thu, Sep 3, 2009 at 11:37 PM, Takashi Iwai<tiwai@suse.de> wrote:

>
> BTW, looking through your numbers:
>
>> Sep  3 21:35:48 localhost kernel: giovanni line: 296,
>> dpcm->frac_buf_pos / HZ=0, jiffies=107166054, buffer_size=4096,
>> period_size=2048, rate=16000
>> Sep  3 21:35:48 localhost kernel: giovanni line: 296,
>> dpcm->frac_buf_pos / HZ=48, jiffies=107166057, buffer_size=4096,
>> period_size=2048, rate=16000
>> Sep  3 21:35:48 localhost kernel: giovanni line: 296,
>> dpcm->frac_buf_pos / HZ=48, jiffies=107166057, buffer_size=4096,
>> period_size=2048, rate=16000
>> Sep  3 21:35:48 localhost kernel: giovanni line: 296,
>> dpcm->frac_buf_pos / HZ=80, jiffies=107166059, buffer_size=4096,
>> period_size=2048, rate=16000
>> Sep  3 21:35:48 localhost kernel: giovanni line: 296,
>> dpcm->frac_buf_pos / HZ=80, jiffies=107166059, buffer_size=4096,
>> period_size=2048, rate=16000
>> Sep  3 21:35:48 localhost kernel: giovanni line: 296,
>> dpcm->frac_buf_pos / HZ=0, jiffies=107166133, buffer_size=4096,
>> period_size=2048, rate=16000
>
> Here, suddenly you get position 0.  Then...
>
>> Sep  3 21:35:48 localhost kernel: giovanni line: 296,
>> dpcm->frac_buf_pos / HZ=2048, jiffies=107166182, buffer_size=4096,
>> period_size=2048, rate=16000
>
> Returning to the right position again.  That can be an issue.

Yes, seems strange...


Takashi,

thanks for the new patch.

I'll test it and report back here.

Sincerely,

Giovanni Maruzzelli
Cell : +39-347-2665618
