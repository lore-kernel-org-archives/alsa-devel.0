From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: ASoC: PCM formats for AC97
Date: Sun, 9 Aug 2009 16:58:16 -0400
Message-ID: <9e4733910908091358m206f6ba0u756c1e8a0da89d01@mail.gmail.com>
References: <9e4733910908081144s27f4b7fes1e22f838a203c3cf@mail.gmail.com>
	<20090809104830.GC4773@sirena.org.uk>
	<9e4733910908090632m1178daceya0269966fde54529@mail.gmail.com>
	<20090809143747.GA9121@sirena.org.uk>
	<9e4733910908090810r56b6fc19p2c671b728f13327@mail.gmail.com>
	<20090809190312.GB4390@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 33DA5244AD
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Aug 2009 22:58:18 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c37so836043anc.2
	for <alsa-devel@alsa-project.org>; Sun, 09 Aug 2009 13:58:17 -0700 (PDT)
In-Reply-To: <20090809190312.GB4390@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 9, 2009 at 3:03 PM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Aug 09, 2009 at 11:10:24AM -0400, Jon Smirl wrote:
>
>> We don't need to declare an endianess because it is fixed in the standar=
d.
>> Now the ifdefs in the h file make this work for both BE and LE.
>
> The ifdefs in the header file define only the native endianness.
> There's no reason why an AC97 controller can't do byte swapping for
> itself but if we use the non-specific constants only native endianness
> will be advertised by the CODEC.

So the BE/LE are there to support the case of an AC97 host that can
handle both endians.  I think the mpc5200 can do that for I2S but not
AC97.

>> This also hides another implicit conversion. The AC97 codecs only take
>> 24b. Again it is the host controller that is converting 8/16/32 to
>> 24b.
>
> This is exactly why we're defining this standard format for AC97
> devices. =A0The formats are just placeholders to make the standard
> matching stuff work without having to teach it about AC97, they have no
> influence on the behaviour of the CODEC.
>

-- =

Jon Smirl
jonsmirl@gmail.com
