From: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 09/15] clk: sunxi-ng: h6: Allow I2S to
 change parent rate
Date: Wed, 21 Aug 2019 07:52:24 +0200
Message-ID: <CAEKpxBnxf=iejk887A7qFkzt3BXVxiRS1PeA45aZYR9DsBAU4Q@mail.gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-10-codekipper@gmail.com>
 <CAGb2v65+-OB4zEyW8f7hcWHkL7DtfEB1YK2B1nOKdgNdNqC0kQ@mail.gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBJFY6PVAKGQEKBXM4NA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v65+-OB4zEyW8f7hcWHkL7DtfEB1YK2B1nOKdgNdNqC0kQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>, Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Thanks....I've added to my next patch series but if you could add it
when applying that would be great.
BR,
CK

On Wed, 21 Aug 2019 at 06:07, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
>
> On Wed, Aug 14, 2019 at 2:09 PM <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > From: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> >
> > I2S doesn't work if parent rate couldn't be change. Difference between
> > wanted and actual rate is too big.
> >
> > Fix this by adding CLK_SET_RATE_PARENT flag to I2S clocks.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
>
> This lacks your SoB. Please reply and I can add it when applying.
>
> ChenYu
