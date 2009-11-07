From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/6] ASoC/mpc5200: get rid of the appl_ptr
	tracking nonsense
Date: Sat, 7 Nov 2009 11:53:30 -0700
Message-ID: <fa686aa40911071053s42428f9bi716a0efedb31c8f@mail.gmail.com>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083358.18908.10635.stgit@angua>
	<9e4733910911070451y28073dbeke6ced6246f5a5c24@mail.gmail.com>
	<9e4733910911070504g13bce539w92120b8124e3e8e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f190.google.com (mail-yw0-f190.google.com
	[209.85.211.190])
	by alsa0.perex.cz (Postfix) with ESMTP id B222624691
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 19:53:51 +0100 (CET)
Received: by ywh28 with SMTP id 28so1749877ywh.16
	for <alsa-devel@alsa-project.org>; Sat, 07 Nov 2009 10:53:51 -0800 (PST)
In-Reply-To: <9e4733910911070504g13bce539w92120b8124e3e8e9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, linuxppc-dev@lists.ozlabs.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 7, 2009 at 6:04 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Sat, Nov 7, 2009 at 7:51 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> On Sat, Nov 7, 2009 at 3:34 AM, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>>> Sound drivers PCM DMA is supposed to free-run until told to stop
>>> by the trigger callback. =A0The current code tries to track appl_ptr,
>>> to avoid stale buffer data getting played out at the end of the
>>> data stream. =A0Unfortunately it also results in race conditions
>>> which can cause the audio to stall.
>>
>> I leave in an hour and I will be off net for a week so I can't look at t=
hese.
>
> There is a surefire way to fix this but I have resisted doing it
> because it is fixing a symptom not a cause.
>
> Simply have the driver zero out the buffer in the completion interrupt
> before handing it back to ALSA. Then if ALSA lets us play invalid data
> the invalid data will be silence. I implemented this and it works
> every time.
>
> Downside is a big memset() in an IRQ handler.

... and then the driver may as well manually copy the audio data from
the buffer into the PSC FIFO.  No win here.

The other option (which I think is how ALSA is designed) is for
userspace to insert silence at the end of playback data so that the
stop trigger lands in a safe place.

g.
