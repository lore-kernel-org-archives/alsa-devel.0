From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Modify mpc5200 AC97 driver to use V9 of
	spin_event_timeout()
Date: Tue, 26 May 2009 21:49:32 -0600
Message-ID: <fa686aa40905262049p10d16293r65340d9e70e6599d@mail.gmail.com>
References: <20090527002530.16740.62502.stgit@terra>
	<ed82fe3e0905261738u655f6f5at2351341a0a5e50d5@mail.gmail.com>
	<9e4733910905261744j3589ace8wd427ef8a5998eccf@mail.gmail.com>
	<ed82fe3e0905261753v1cb9c901i3b66cd903e4adda6@mail.gmail.com>
	<9e4733910905261801p130f50afie2c50d5723192d44@mail.gmail.com>
	<ed82fe3e0905262012r58f8a750lab9cb1bf3b9a989@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 4425324598
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 05:49:53 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so3113174ywq.2
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2009 20:49:52 -0700 (PDT)
In-Reply-To: <ed82fe3e0905262012r58f8a750lab9cb1bf3b9a989@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2009 at 9:12 PM, Timur Tabi <timur@freescale.com> wrote:
> On Tue, May 26, 2009 at 8:01 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>
>> Then why did you need to make your routine that calls cpu_relax()?
>
> That gets called only if delay =3D=3D 0. =A0udelay(0) is a no-op, so if t=
he
> caller specifies no delay, then I need to manually call cpu_relax().
>
>> I don't know what goes on in the guts of HMT_low() and cpu_relax(),
>> when you guys decide which one I should use let me know and I can
>> adjust the patch.
>
> Grant, I don't see any reason why "udelay(50)" is unacceptable.

It's not.  See my last email.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
