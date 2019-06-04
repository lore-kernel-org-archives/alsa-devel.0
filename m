From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: Re: [PATCH v4 2/9] ASoC: sun4i-i2s: Add offset to
 RX channel select
Date: Tue, 4 Jun 2019 15:39:44 +0800
Message-ID: <CAGb2v67ch3F23q-SSxU01Mvkt-x8LL5HfwnZb4NdJcMMkN2H+w@mail.gmail.com>
References: <20190603174735.21002-1-codekipper@gmail.com> <20190603174735.21002-3-codekipper@gmail.com>
 <20190604073651.gst57ki7ohzxcrqz@flea>
Reply-To: wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBTWA3DTQKGQEZHGDEEY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190604073651.gst57ki7ohzxcrqz@flea>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 4, 2019 at 3:37 PM Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:
>
> On Mon, Jun 03, 2019 at 07:47:28PM +0200, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> > From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > Whilst testing the capture functionality of the i2s on the newer
> > SoCs it was noticed that the recording was somewhat distorted.
> > This was due to the offset not being set correctly on the receiver
> > side.
> >
> > Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Acked-by: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>

Would be nice to have

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")

But otherwise,

Acked-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
