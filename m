From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V5 1/5] powerpc: introduce macro
	spin_event_timeout()
Date: Tue, 26 May 2009 09:12:10 -0400
Message-ID: <9e4733910905260612v40a70ad8haeb4c916a1a758b5@mail.gmail.com>
References: <20090526123235.17472.73912.stgit@terra>
	<20090526123406.17472.79948.stgit@terra>
	<20090526130301.GE8969@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D3571038E1
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 15:12:11 +0200 (CEST)
Received: by qyk1 with SMTP id 1so5027392qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2009 06:12:10 -0700 (PDT)
In-Reply-To: <20090526130301.GE8969@sirena.org.uk>
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
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2009 at 9:03 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, May 26, 2009 at 08:34:06AM -0400, Jon Smirl wrote:
>> The macro spin_event_timeout() takes a condition and timeout value
>> (in microseconds) as parameters. =A0It spins until either the condition =
is true
>> or the timeout expires. =A0It returns the result of the condition when t=
he loop
>> was terminated.
>
> As previously mentioned you need to submit any changes you want to make
> here as incremental patches against the PowerPC tree rather than as an
> entire new patch. =A0If you are forwarding on copies of the patch you
> really ought to preserve Timur's authorship too with a From line in the
> mail.

I have reverted back to TImur's original patch  so you can just drop
this patch if that is easier for you.
You'll just need to coordinate the landing so that things land in the
right order.

-- =

Jon Smirl
jonsmirl@gmail.com
