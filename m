From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Proposed changes to soc core to allow multiple
 codecs bound together on a single bus
Date: Mon, 6 Jun 2011 11:51:15 +0100
Message-ID: <20110606105115.GB12783@opensource.wolfsonmicro.com>
References: <BANLkTimBmj+BROhu9b-+wQRXUQa6ABpOBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1790D24340
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 12:51:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTimBmj+BROhu9b-+wQRXUQa6ABpOBQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 03, 2011 at 05:04:12PM -0700, Caleb Crome wrote:

> static char *my_codec_dais[] = {
>      "tlv320aic3x-hifi.0",   <---- in this case, the '.0'
>      "tlv320aic3x-hifi.1",    ---- means that it's slot 0
>      "tlv320aic3x-hifi.2",    ---- on the TDM bus.
>      "tlv320aic3x-hifi.3",
> };
> static char *my_codec_names[] = {
>      "tlv320aic3x-codec.2-0018", <--- codec on i2c bus 2, addr 0x18
>      "tlv320aic3x-codec.2-0019", <--- codec on i2c bus 2, addr 0x19
>      "tlv320aic3x-codec.2-001a", <--- codec on i2c bus 2, addr 0x1a
>      "tlv320aic3x-codec.2-001b", <--- codec on i2c bus 2, addr 0x1b
> };

I don't like the need to line the two arrays up, and the DAI names
really ought to be enough anyway (this applies in general, not just
here).

> The core will parse the dai name for the slot order, and pass it on to the
> codec during hw_params.  Then the codec can properly set the TDM slot on the
> hardware interface.

No, the machine driver needs to own the TDM configuration.  We need to
have the flexibiltiy for the system to use arbatrary arrangements for
things like buses with more than two devices on them and we need to be
able to cope with random layouts of the channels (for example, all the
left channels on one device, all the right channels on another device).
We also need to be able to change this dynamically at runtime depending
on the current needs of the system.
