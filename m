From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Thu, 3 Sep 2009 17:35:43 +0200
Message-ID: <7c5010d60909030835n2d62756cr1e29de479b7a9d97@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<s5heiqoqfh4.wl%tiwai@suse.de>
	<7c5010d60909030723l44055b5au84a487d78ef6252f@mail.gmail.com>
	<s5hbplsqeye.wl%tiwai@suse.de>
	<7c5010d60909030747n55b6f48r2322aabf47f17171@mail.gmail.com>
	<7c5010d60909030803h1c354c79ob774683d764ea062@mail.gmail.com>
	<s5h4orkqd22.wl%tiwai@suse.de>
	<7c5010d60909030812k5f865622i5cddcd978788c338@mail.gmail.com>
	<7c5010d60909030826k122fa855t153458431cd18909@mail.gmail.com>
	<s5h1vmoqc71.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id BB73610386D
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 17:35:46 +0200 (CEST)
Received: by bwz25 with SMTP id 25so19189bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2009 08:35:43 -0700 (PDT)
In-Reply-To: <s5h1vmoqc71.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 3, 2009 at 5:29 PM, Takashi Iwai<tiwai@suse.de> wrote:
>> Sep =A03 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
>> HZ=3D0, jiffies=3D91837395
>> Sep =A03 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
>> HZ=3D48, jiffies=3D91837398
>> Sep =A03 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
>> HZ=3D48, jiffies=3D91837398
>> Sep =A03 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
>> HZ=3D80, jiffies=3D91837400
>> Sep =A03 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
>> HZ=3D80, jiffies=3D91837400
>
> So, this is a kernel with the variable HZ. =A0That's the whole problem.
> My patch also doesn't take it into account but assumes the constant HZ.
> We'll need to convert the stuff to msecs_to_jiffies() and co...

Ah! I was struggling since days on this, you're fast!!!

Also, I saw you made various modifications that I tried to make (in a
messy way), to a custom version of snd-dummy made to support 128
subdevices and use less irq and context switches.
As soon as you looked into the variable HZ problem, I will see if my
modifications still make some sense, and in case I will forward it to
you.

Thanks again for your prompt reaction and for taking care of this,

-giovanni
