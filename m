From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: [PATCH v5 0/1] A codec driver for the TI WL1273 FM
	Radio.
Date: Thu,  5 Aug 2010 13:43:12 +0300
Message-ID: <1281004993-15601-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FB2C2455F
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 12:43:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, peter.ujfalusi@nokia.com
Cc: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hello.

New in the fifth version:

> > > +/* codec private data */
> > > +struct wl1273_priv {
> > > +   struct snd_soc_codec codec;
> > > +   enum wl1273_mode mode;
> > > +   struct wl1273_core *core;
> > > +   unsigned int channels;
> > > +};
> > 
> > ...why would anything outside the driver be peering into this?
> 
> Well, I see no reason... So I'll move it from the header to the c -file
> and then it's fine?

OK... that's most probably what you mean. So I've moved the private
struct definition from the header to the code file. And following the same
logic I also moved the mode enum definition.

Cheers,
Matti A.

Matti J. Aaltonen (1):
  ASoC: TI WL1273 FM Radio Codec.

 sound/soc/codecs/wl1273.c |  552 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wl1273.h |   30 +++
 2 files changed, 582 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/wl1273.c
 create mode 100644 sound/soc/codecs/wl1273.h
