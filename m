From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH v2 2/3] ASoC: Documentation: Add google,
	cros-ec-codec
Date: Wed, 26 Dec 2018 15:17:10 +0800
Message-ID: <CAFv8NwLRDzJcSWyB444XwDqXAX-PknrV7N4V9KcT0NCVgiAXag@mail.gmail.com>
References: <20181224083724.75618-1-cychiang@chromium.org>
 <20181224083724.75618-2-cychiang@chromium.org>
 <CABXOdTdoz-sG3t0n3kKUd0ydJmnmMsoaOJ=yQzWOtT0A8Qp2kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com
 [209.85.222.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 4554D267A78
 for <alsa-devel@alsa-project.org>; Wed, 26 Dec 2018 08:17:38 +0100 (CET)
Received: by mail-ua1-f67.google.com with SMTP id u19so4876018uae.4
 for <alsa-devel@alsa-project.org>; Tue, 25 Dec 2018 23:17:37 -0800 (PST)
In-Reply-To: <CABXOdTdoz-sG3t0n3kKUd0ydJmnmMsoaOJ=yQzWOtT0A8Qp2kw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guenter Roeck <groeck@google.com>
Cc: alsa-devel@alsa-project.org, tzungbi@chromium.org, Benson Leung <bleung@chromium.org>, linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, Dylan Reid <dgreid@chromium.org>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 24, 2018 at 10:38 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Mon, Dec 24, 2018 at 12:39 AM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> >
> > Add documentation for Chrome EC codec driver.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  Change in v2: Fixed name of driver in MAINTAINERS.
> >
> >  .../bindings/sound/google,cros-ec-codec.txt   | 24 +++++++++++++++++++
>
> Since this is a devicetree binding, it will require an Ack from a DT
> maintainer. You might want to check the output of
> scripts/get_maintainer.pl to make sure you don't miss anyone
> important.
>
> Guenter
>

Thanks for the suggestion.
cc'ed Rob Herring in v3.

> >  MAINTAINERS                                   |  5 ++++
> >  2 files changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> >
> > diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> > new file mode 100644
> > index 0000000000000..57718382b3a36
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> > @@ -0,0 +1,24 @@
> > +* Audio codec controlled by ChromeOS EC
> > +
> > +Google's ChromeOS EC codec is a digital mic codec provided by the
> > +Embedded Controller (EC) and is controlled via a host-command interface.
> > +
> > +An EC codec node should only be found as a sub-node of the EC node (see
> > +Documentation/devicetree/bindings/mfd/cros-ec.txt).
> > +
> > +Required properties:
> > +- compatible: Must contain "google,cros-ec-codec"
> > +- #sound-dai-cells: Should be 1. The cell specifies number of DAIs.
> > +
> > +Example:
> > +
> > +cros-ec@0 {
> > +       compatible = "google,cros-ec-spi";
> > +
> > +       ...
> > +
> > +       cros_ec_codec: ec-codec {
> > +               compatible = "google,cros-ec-codec";
> > +               #sound-dai-cells = <1>;
> > +       };
> > +};
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5b9c6af98283b..05e1922624e58 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3636,6 +3636,11 @@ S:       Maintained
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
> >  F:     drivers/platform/chrome/
> >
> > +CHROMEOS EC CODEC DRIVER
> > +M:     Cheng-Yi Chiang <cychiang@chromium.org>
> > +S:     Maintained
> > +F:     Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> > +
> >  CIRRUS LOGIC AUDIO CODEC DRIVERS
> >  M:     Brian Austin <brian.austin@cirrus.com>
> >  M:     Paul Handrigan <Paul.Handrigan@cirrus.com>
> > --
> > 2.20.1.415.g653613c723-goog
> >
