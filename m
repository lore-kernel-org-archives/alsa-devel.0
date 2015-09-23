From: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel][PATCH 0/3]Add SPDIF support for
 Allwinner SoCs
Date: Wed, 23 Sep 2015 20:41:15 +0200
Message-ID: <CAEKpxB=9nX6W7xpuQN5naqkkyEG-tkttfmFfs1JNgvpz=_UpEw@mail.gmail.com>
References: <1443031494-32469-1-git-send-email-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBS7EROYAKGQEQWZJSZI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1443031494-32469-1-git-send-email-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi All,
I'm getting a "fatal: 'send-email'" response with the last patch(even
though the dry run of the patch series worked) and I've not been able
to work around it. I'll post it as soon as I can work out what the
issue is,
BR,
CK

On 23 September 2015 at 20:04,  <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> This patch set adds support for the Allwinner SPDIF transceiver as present
> on the A10, A20 and A31 SoC boards.
>
> For now just the SPDIF transmitter has been tested on a Mele A2000.
>
> In order for this patch set to be functional we require audio clock patches
> which will be delivered separately. For those that are interested I've pushed
> the patches here with all the required changes to get SPDIF audio out of the
> device.
>
> https://github.com/codekipper/linux-sunxi/commits/spdif_delivery
>
> Thanks in advance,
> CK
>
> Marcus Cooper (3):
>   dt-bindings: add sunxi SPDIF transceiver bindings
>   dt-binding: Add sunxi SPDIF machine driver
>   ASOC: sunxi: Add support for the spdif block
>
>  .../devicetree/bindings/sound/sunxi,spdif.txt      |  49 ++
>  .../bindings/sound/sunxi-audio-spdif.txt           |  36 +
>  sound/soc/sunxi/Kconfig                            |  10 +
>  sound/soc/sunxi/Makefile                           |   4 +
>  sound/soc/sunxi/sunxi-machine-spdif.c              | 110 +++
>  sound/soc/sunxi/sunxi-spdif.c                      | 801 +++++++++++++++++++++
>  6 files changed, 1010 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sunxi,spdif.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt
>  create mode 100644 sound/soc/sunxi/sunxi-machine-spdif.c
>  create mode 100644 sound/soc/sunxi/sunxi-spdif.c
>
> --
> 2.5.3
>
