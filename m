From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/6] ASoC/mpc5200: get rid of the appl_ptr
	tracking nonsense
Date: Wed, 11 Nov 2009 12:24:45 -0700
Message-ID: <fa686aa40911111124i12b72196xdba7000b13b3bdc@mail.gmail.com>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083358.18908.10635.stgit@angua>
	<9e4733910911070451y28073dbeke6ced6246f5a5c24@mail.gmail.com>
	<fa686aa40911071051y3cf63e55ibe7fbc65c30bd15e@mail.gmail.com>
	<20091107201233.GC31789@sirena.org.uk>
	<9e4733910911110838w6010cf3atcfcd30c85f0764a1@mail.gmail.com>
	<20091111183753.GA31815@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f190.google.com (mail-yw0-f190.google.com
	[209.85.211.190])
	by alsa0.perex.cz (Postfix) with ESMTP id E6C3524597
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 20:25:06 +0100 (CET)
Received: by ywh28 with SMTP id 28so1279289ywh.16
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 11:25:06 -0800 (PST)
In-Reply-To: <20091111183753.GA31815@rakim.wolfsonmicro.main>
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
Cc: John Bonesio <bones@secretlab.ca>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 11, 2009 at 11:37 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Nov 11, 2009 at 11:38:06AM -0500, Jon Smirl wrote:
>> > Providing a final valid data point to the driver would possibly even
>> > make things worse since if it were used then you'd have the equivalent
>> > race where the application has initialized some data but not yet manag=
ed
>> > to update the driver to tell it it's being handed over; if the driver
>
>> That's an under run condition.
>
> Yes, of course - the issue is that this approach encourages them, making
> the system less robust if things are on the edge. =A0The mpc5200 seems to
> be not just on the edge but comfortably beyond it for some reason.

I can't reproduce the issue at all as long at the dev_dbg() statement
in the trigger stop path is disabled.  With it enabled, I hear the
problem every time.  The 5200 may not be a speedy beast, but it is
plenty fast enough to shut down the audio stream before stale data
starts getting played out.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
