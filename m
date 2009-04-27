From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH v2 4/4] Rename exports in mpc5200_dma.c
Date: Mon, 27 Apr 2009 17:43:16 -0400
Message-ID: <9e4733910904271443n6d0ab00emdbc1e33d6b7d1ee0@mail.gmail.com>
References: <20090427164108.18211.44680.stgit@terra>
	<20090427164447.18211.42851.stgit@terra>
	<20090427193534.GA23567@rakim.wolfsonmicro.main>
	<9e4733910904271305h171f5e9dybdd560ae2c22c9bf@mail.gmail.com>
	<20090427200910.GC14626@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id D755310391B
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 23:43:17 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so144228qwk.56
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2009 14:43:16 -0700 (PDT)
In-Reply-To: <20090427200910.GC14626@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 27, 2009 at 4:09 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Mon, Apr 27, 2009 at 04:05:10PM -0400, Jon Smirl wrote:
>> On Mon, Apr 27, 2009 at 3:35 PM, Mark Brown
>> <broonie@opensource.wolfsonmicro.com> wrote:
>
>> > Why are you exporting these? ?They should all be accessed via...
>
>> This is part of what is broken in the driver. I have later patches
>> that fix it but those patches are more complex.
>
> Could you go into more detail on this, please? =A0Why aren't you just
> moving them directly to the vtable of the DMA driver?

The vtable for DMA driver doesn't have startup/shutdown entry points.
It takes a more complicated change to fix this,

The intention was to mechanically split the driver into two files in
order to remove the noise of the reorg from the subsequent patch
series.  These patches don't fix anything, they just break the driver
in two. I need the exports in order to keep it building so that it
will be bisectable.

These entry points get fixed in later patches.

-- =

Jon Smirl
jonsmirl@gmail.com
