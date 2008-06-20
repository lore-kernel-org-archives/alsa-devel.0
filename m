From: "Vince Negri" <vince.negri@gmail.com>
Subject: Hoping to enhance cs5535 driver - initial question
Date: Fri, 20 Jun 2008 16:14:26 +0100
Message-ID: <765c72c70806200814v73445478w279da2064dc7608b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DFFE10386A
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jun 2008 17:14:28 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so272504and.80
	for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2008 08:14:27 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi All,

I'm looking to enhance the cs5535 driver (Geode companion device) so
that it can support 5.1 operation when used with an appropriate AC97
codec. AFAIK, the existing ALSA driver only supports 2-channel
operation.

Having looked at the existing driver, and Takashi Iwai's guide, there
is still something I'm not too clear on - I hope you can set me
straight.

According to the AMD datasheet, when used in 5.1 mode the cs5535 makes
use of 4 distinct DMAs - the first (BM0) is the main L/R pair, and
this is the one used by the existing driver. There is another DMA for
L/R surround, another for the centre channel, and the fourth DMA feeds
the LFE channel. Two stereos and two monos.

I'm comfortable with the low-level bit bashing: what I'm unsure of is
what is necessary to represent all of this to the upper layers so that
the ALSA clients see me as a 6-channel device.
Do I need to represent the 4 DMAs as substreams of the playback pcm,
for example? Or have I completely misunderstood what a substream is?

Alternatively, pointers to an existing driver that faces the same
issue would be very welcome.

Vince
