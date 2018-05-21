From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [BUG] On Allwinner A20 Board Cubietruck distorted
 SPDIF opical output
Date: Mon, 21 May 2018 15:17:19 +0200
Message-ID: <20180521131719.eyrmikexh7jsjrnu@flea>
References: <CAJnOVskuR6WG5tBVNT30t+k3y4hPR6VnQ=p_QQdBe3fuTWEf_Q@mail.gmail.com>
 <CAEKpxB=0ahGP=bnFAKDZatLLphADMig4P2Bkpkao-jzE9ORkEg@mail.gmail.com>
 <CAJnOVskcERpto7ztKcCDWKG9NMcgSjcM867bCgkcxG86sZ2MFw@mail.gmail.com>
 <CAJnOVs=kK+nPOHfWzAU0q1Nzu7XLwY6HojaZLHXeW1n71YG2wg@mail.gmail.com>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mmbyusy5exqjrykt"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB24NRPMAKGQEKHHYKZQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAJnOVs=kK+nPOHfWzAU0q1Nzu7XLwY6HojaZLHXeW1n71YG2wg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Markus Mitsch <markusmitsch86-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Markus Mitsch <markusmitsch86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--mmbyusy5exqjrykt
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Mon, May 21, 2018 at 02:43:55PM +0200, Markus Mitsch wrote:
> 2018-05-21 11:43 GMT+02:00 Markus Mitsch <markusmitsch86-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>:
> >>> Hello,
> >>>
> >>> i have a new problem. if i want to output sound from optical i get
> >>> distorted sound. At 44.1 khz its like an old vinly, but at 48 khz and
> >>> higher it is very bad. thanks in advance for your time.
> >
> >> Hi Markus,
> >> I haven't tested it for a while but when I did it worked as high as
> >> 96K with no issues. Does it work ok with the original cubietruck
> >> software?,
> >> CK
> >
> > Hello,
> > i am using arch linux with mainline kernel 4.16.8. parhaps i can try
> > today with official image.
> > mfg
> 
> Hi.
> So, with debian image from 2014 with 3.4.79 kernel the sound is clear
> up to 96 khz.

You said that it is a new problem, when was it introduced? Could you
bisect the issue?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
--mmbyusy5exqjrykt--
