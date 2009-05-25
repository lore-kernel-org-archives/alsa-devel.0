From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V3 1/4] Main rewite of the mpc5200 audio
	DMA code
Date: Mon, 25 May 2009 07:22:37 -0600
Message-ID: <fa686aa40905250622h3c2076c2l21a5dd9f29e5f78e@mail.gmail.com>
References: <20090525013606.3073.86753.stgit@terra>
	<20090525013847.3073.55951.stgit@terra>
	<fa686aa40905242326y6a88af84n40f23759661a6cd0@mail.gmail.com>
	<20090525093439.GA18290@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id B4BC8243AA
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 15:22:58 +0200 (CEST)
Received: by gxk2 with SMTP id 2so6181150gxk.8
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2009 06:22:57 -0700 (PDT)
In-Reply-To: <20090525093439.GA18290@sirena.org.uk>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2009 at 3:34 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, May 25, 2009 at 12:26:27AM -0600, Grant Likely wrote:
>> On Sun, May 24, 2009 at 7:38 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>
>> > +/* ------------------------------------------------------------------=
---
>> > + * Sysfs attributes for error monitoring
>> > + */
>
>> All this sysfs stuff should be dropped from this patch. =A0It is an
>> abuse of sysfs and I never should have written it this way. =A0Feel free
>> to put it in a separate patch so others can use it if they really need
>> it, but I'd like it to not be kept in mainline.
>
> If this is going to be kept it should be in debugfs like I said in
> response to the v2 posting.

exactly.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
