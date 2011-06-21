From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: Re: [PATCH] ASoC: codecs: Max98095: Fix logging of
 hardware revision.
Date: Mon, 20 Jun 2011 17:43:58 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40DDEC16D42@ITSVLEX06.it.maxim-ic.internal>
References: <1308596072-17158-1-git-send-email-thutt@chromium.org>
	<20110621002322.GE1905@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maxim-ic.com (antispam01.maxim-ic.com
	[205.153.101.182])
	by alsa0.perex.cz (Postfix) with ESMTP id C7AE5244F9
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 02:45:20 +0200 (CEST)
In-Reply-To: <20110621002322.GE1905@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Taylor Hutt <thutt@chromium.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Olof Johansson <olofj@chromium.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011, Mark Brown wrote:
> On Mon, Jun 20, 2011 at 11:54:32AM -0700, Taylor Hutt wrote:
> > The base hardware revision of the Maxim 98095 part is 0x40; the code
> > which outputs the revision of the hardware has been updated to
> > properly use uppercase alphabetic values for the revision numbers.
> 
> Are you sure that this is true for all devices that might be supported
> by the driver (I'm guessing there may be other variants)?  There's
> often a drift between silicon and package revisions which gets papered 
> over by datasheets and ignored by drivers.

I checked with hardware engineering and was told 0x40=RevA, 0x41=RevB..

Would a raw value or the use of a 0x3F bit mask be more acceptable?

Peter
