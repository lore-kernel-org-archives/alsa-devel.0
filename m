From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: hda_intel: SPDIF not detected on Asus P7P55D PRO
Date: Mon, 21 Sep 2009 18:09:28 -0600
Message-ID: <51f3faa70909211709q344656edj98add3dffdc9abf3@mail.gmail.com>
References: <4AB3009C.1090605@gmail.com> <s5hiqfg6aj5.wl%tiwai@suse.de>
	<51f3faa70909180738y6c8d1ecevb7ce90b3de6699b0@mail.gmail.com>
	<s5hzl8owh8k.wl%tiwai@suse.de>
	<20090921135433.GH3910@prithivi.gnumonks.org>
	<s5htyywwg0t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EA8124650
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 02:09:29 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 13so745569eye.16
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2009 17:09:29 -0700 (PDT)
In-Reply-To: <s5htyywwg0t.wl%tiwai@suse.de>
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
Cc: Alsa-Devel <alsa-devel@alsa-project.org>, Harald Welte <HaraldWelte@viatech.com>, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 21, 2009 at 8:04 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > Thanks. =A0This looks really incompatible with the existing VIA codecs.
>> > So, no wonder that you didn't get it working by a simple hack.
>>
>> Yes, I agree.
>>
>> > Harald, do you know anyone who can help the development for this new
>> > codec chip?
>>
>> VIA already has code for supporting this chip, and they were about to su=
pport
>> one big monster patch (15000 lines of code) containing what looks like s=
everal
>> months of code for several codecs.
>
> OK, good to know.
>
>> =A0I've asked them to split this up and create
>> and submit per-feature patches.
>
> Ah, thanks, that'll be really helpful!
>
>> I don't know how long it will take them to do this. =A0Maybe Lydia can g=
ive
>> some comment on this.
>>
>> Also, in case you want to see the big monster patch just for reference, I
>> can see if it can be posted to alsa-devel. =A0It should be no problem, I=
MHO.
>
> Heh, who wants it? ;)
> The logically split patches are really appreciated, especially in such
> a case.

If it's possible, I'd say it would be nice to have the big patch
posted now even if it's not in mergeable condition yet, just for
testing and for people to use temporarily..
