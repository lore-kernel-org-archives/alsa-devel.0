From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: LSI HDA Modem is not working on HP new Laptop
 which has IDT 7605 HDA codec and REDHAT installed on it with ALSA ver
 1.0.24.
Date: Sat, 1 Oct 2011 10:56:55 +0800
Message-ID: <CAN8cciaUNP=mk=7=u+HpMVdwRJ-fRUR1OGS5p9zmfDsMfofqHw@mail.gmail.com>
References: <B2FD678A64EAAD45B089B123FDFC3ED70166618A4C@inbmail01.lsi.com>
	<s5hipobc1it.wl%tiwai@suse.de>
	<B2FD678A64EAAD45B089B123FDFC3ED70166618A6E@inbmail01.lsi.com>
	<s5h8vp7by4m.wl%tiwai@suse.de> <s5h62kbbx1g.wl%tiwai@suse.de>
	<CAJTbaX3OiLNcL2hwJOROK4jLeLhAJKJE-zO5t=VYcP4sP03oUA@mail.gmail.com>
	<s5hy5x7ag8l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AA3D103823
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Oct 2011 04:56:56 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so2425986bkb.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2011 19:56:56 -0700 (PDT)
In-Reply-To: <s5hy5x7ag8l.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/29 Takashi Iwai <tiwai@suse.de>:
> At Thu, 29 Sep 2011 14:01:40 +0530,
> suresh gupta wrote:
>>
>> Sorry for delay, I was out for Lunch.
>>
>> I believe we are in sink now, I seen the purity_inactive_streams part of
>> code and found this is totally new logic in 1.0.24 ver. Can you please
>> answer some question for my proper understanding?
>>
>> 1. Why this marking stream dirty come into picture and why ALSA code do =
not
>> directly clear the AC_VERB_SET_CHANNEL_STREAMID while closing?
>
> For keeping the same stream tag for the same device.
> A device is often shortly closed and reopened. =A0It'd be better to keep
> the same stream tag for such a case.

I have doubt about this since hw_free() can also cleanup the stream tag too

http://thread.gmane.org/gmane.linux.alsa.devel/89420

>
>> 2. Why Analog devices codec (patch_analog.c) clear
>> AC_VERB_SET_CHANNEL_STREAMID on close? (if (do_now)
>> =A0 =A0really_cleanup_stream(codec, p);
>
> It's because AD codecs (according to bug reports) don't like the
> sticky-tag feature by some reason. =A0It'll be removed, once when the
> real culprit is found.
>
>

http://thread.gmane.org/gmane.linux.alsa.devel/78379

Can the converters can retrain the stream tag after suspend/resume ?
