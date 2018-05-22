From: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [BUG] On Allwinner A20 Board Cubietruck distorted
 SPDIF opical output
Date: Tue, 22 May 2018 21:27:54 +0200
Message-ID: <CAEKpxB=pLzAH0-c4VCUYAa6EbvswfGGz3nxGez5fj6_hJ8mKQg@mail.gmail.com>
References: <CAJnOVskuR6WG5tBVNT30t+k3y4hPR6VnQ=p_QQdBe3fuTWEf_Q@mail.gmail.com>
 <CAEKpxB=0ahGP=bnFAKDZatLLphADMig4P2Bkpkao-jzE9ORkEg@mail.gmail.com>
 <CAJnOVskcERpto7ztKcCDWKG9NMcgSjcM867bCgkcxG86sZ2MFw@mail.gmail.com>
 <CAJnOVs=kK+nPOHfWzAU0q1Nzu7XLwY6HojaZLHXeW1n71YG2wg@mail.gmail.com>
 <20180521131719.eyrmikexh7jsjrnu@flea> <CAJnOVske_kAmib1eKhkJJouYZE_1M4uwM-VVuBfThHvwVRmMrQ@mail.gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBO66SHMAKGQE6REGZYQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAJnOVske_kAmib1eKhkJJouYZE_1M4uwM-VVuBfThHvwVRmMrQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Markus Mitsch <markusmitsch86-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Markus Mitsch <markusmitsch86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Markus,
I've been able to reproduce this on my A31 board with linux-next(plays
at 44100 but not at 96K)so it is an issue. I also tested the same code
on my A64 and it worked fine, The blocks are very similar so it maybe
a clocking issue, I'll look into this.
BR,
CK

On 21 May 2018 at 20:17, Markus Mitsch <markusmitsch86-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> 2018-05-21 15:17 GMT+02:00 Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>:
>> On Mon, May 21, 2018 at 02:43:55PM +0200, Markus Mitsch wrote:
>>> 2018-05-21 11:43 GMT+02:00 Markus Mitsch <markusmitsch86-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>:
>>> >>> Hello,
>>> >>>
>>> >>> i have a new problem. if i want to output sound from optical i get
>>> >>> distorted sound. At 44.1 khz its like an old vinly, but at 48 khz and
>>> >>> higher it is very bad. thanks in advance for your time.
>>> >
>>> >> Hi Markus,
>>> >> I haven't tested it for a while but when I did it worked as high as
>>> >> 96K with no issues. Does it work ok with the original cubietruck
>>> >> software?,
>>> >> CK
>>> >
>>> > Hello,
>>> > i am using arch linux with mainline kernel 4.16.8. parhaps i can try
>>> > today with official image.
>>> > mfg
>>>
>>> Hi.
>>> So, with debian image from 2014 with 3.4.79 kernel the sound is clear
>>> up to 96 khz.
>>
>> You said that it is a new problem, when was it introduced? Could you
>> bisect the issue?
>>
>> Maxime
>
> Hello.
> I dont know since when this problem appears. When saying "new" i
> refered to my older post. I tried to look into the dts file and the
> code
> but i am afraid this is a bit too high for me. I can say that the
> analog output works, even at high sampling rates.
> And I have read something about a clock source could be the problem.
> I'm sorry I can't tell you any more.
>
> mfg
> Markus
