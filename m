From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/7] Asoc: sti: add CPU DAI driver for
	playback
Date: Mon, 27 Apr 2015 20:46:51 +0100
Message-ID: <20150427194651.GA22845@sirena.org.uk>
References: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
 <1429018531-29025-4-git-send-email-arnaud.pouliquen@st.com>
 <20150424181528.GF22845@sirena.org.uk> <553E40A0.4030904@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8490300906261838346=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D0EB26041C
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 21:46:59 +0200 (CEST)
In-Reply-To: <553E40A0.4030904@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8490300906261838346==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+Wh9JuUmCe2LsTPM"
Content-Disposition: inline


--+Wh9JuUmCe2LsTPM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2015 at 03:58:56PM +0200, Arnaud Pouliquen wrote:
> On 04/24/2015 08:15 PM, Mark Brown wrote:
> >On Tue, Apr 14, 2015 at 03:35:27PM +0200, Arnaud Pouliquen wrote:

Please delete unneeded context from your mails and fix your mailer to
format things normally.  I'm not entirely sure what it's doing, it seems
to be be that it's not leaving blanks between paragraphs and wrapping at
odd and inconsistent places.  It is very hard to read your messages as a
result.

> >There's a lot of very coarse grained spinlock usage in this driver which
> >I'm having a hard time understanding, at the very least the decisions
> >about locking need to be documented much more clearly and I suspect that
> >either things need to be finer grained, we should be using mutexes more
> >or both.

> This part is linked to the standby mode described in binding ( patch[1/7])
> it manage a runtime suspend, because ASOC runtime suspend is dedicated to
> DAPM.
> As you recommend i will try to change it by a DAPM linked to CPU_DAI. Just
> need to find a wait
> to retrieve CPU_DAI context in DAPM..
> Concerning spinlock
> I use it to protect context ( called by IRQ, on suspend, by user...). As
> some code is called in atomic i can not use mutex.
> I will review it and document it.

Please note my comments about these locks being very coarse grained - I
suspect that the spinlock is covering too much.

> >>+	/* Get interrupt status & clear them immediately */
> >>+	preempt_disable();
> >>+	status = GET_UNIPERIF_ITS(player);
> >>+	SET_UNIPERIF_ITS_BCLR(player, status);
> >>+	preempt_enable();

> >preempt_disable()?  Why is this being done, if you're doing unusual
> >stuff like this the code needs to be very clear about what the locking
> >rules are?

> This is used to be sure to not miss an interrupt. If preempted between both
> instruction i can clear an interruption flag before treat it. In this case i
> will receive
> a second interrupt with all flag to 0.

That doesn't sound right, the interrupt appears to be write to clear so
if we get a second interrupt between the read and write surely we'd not
get another spurious interrupt?  It would look like we were acknowleding
the second raise.  It sounds like something else is going on here.

In any case the spurious interrupt doesn't seem like it should happen a
lot, nor like it should be especially serious if we can handle it.

> >>+	snd_pcm_stream_lock(player->substream);

> >Again please explain the locking if we're doing something unusual.
> This protect from a race condition, if application request a stop while we
> receive Error from IP.
> I call it here to avoid toprotect all snd_pcm_stop calls... but i can
> protect only the snd_pcm_stop
> calls if more clear

Please do something to make it clear what you're doing.

> >>+	/* Check for fifo error (under run) */
> >>+	if (unlikely(status & UNIPERIF_ITS_FIFO_ERROR_MASK(player))) {
> >>+		dev_err(player->dev, "FIFO underflow error detected");
> >>+
> >>+		/* Interrupt is just for information when underflow recovery */
> >>+		if (player->info->underflow_enabled) {
> >>+			/* Update state to underflow */
> >>+			player->state = UNIPERIF_STATE_UNDERFLOW;

> >Why would underflow recovery be optional?

> To propose 2 strategies:
> - stop on underrun ( because plop will occurs)
> - try to recover it:  time is recovered when new data is available ( sample
> dropping)

Well, the standard behaviour is to halt on error (so that's what the
rest of the stack will expect) and it doesn't sound like the recovery is
really that great anyway.

--+Wh9JuUmCe2LsTPM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPpIqAAoJECTWi3JdVIfQMz0H/2nBtSaqk2c69OoLE9G8aMJj
bSDUcPUATD91zUrbkMEWDLpM5e0VIrmTvGSoWZz0gj3MKo4o4irLAliNMF/2j/zz
/07/xVjYWzPuG7aCDnIcqEYrurbu4dRYa9Zf+aTGS9yICiRAlY4PsSSM39trKi8T
6AbyU/MFNCSL7L+v2Q5Y2hmy8/mT/VU3BoctHz4cWkhl24S90/4/OQzu66wZMuUF
/C7Jkl1GmycnAS2xwdbqZI/+81a8mCDHGiNmyvreMbTlwSjqqzFIWpKLF3Qnw9S/
hFheNTgwEsCwf+8V22Tpl/RVBe+0kpzJGe2t68cWnzpfo1CrHJQLR6xnjTDblmo=
=6yD/
-----END PGP SIGNATURE-----

--+Wh9JuUmCe2LsTPM--

--===============8490300906261838346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8490300906261838346==--
