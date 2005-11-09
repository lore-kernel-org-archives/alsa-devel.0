From: Giorgio Padrin <giorgio@mandarinlogiq.org>
Subject: Re: Audio support for codec Philips UDA1380
Date: Wed, 9 Nov 2005 12:41:00 +0100
Message-ID: <200511091241.01139.giorgio@mandarinlogiq.org>
References: <200511041201.01260.giorgio@mandarinlogiq.org> <200511050757.01732.giorgio@mandarinlogiq.org> <85ek5sz05p.fsf@Orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <85ek5sz05p.fsf@Orfeo.duckcorp.org>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>
Cc: alsa-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Hi Arnaud,

Thank you very much.

Alle 21:13, luned=C3=AC 7 novembre 2005, Arnaud Patard ha scritto:
> okay.. =C2=A0so you may safely remove the pxa header :)

Removed.

> I've done a test build and it doesn't build because the
> I2C_DRIVERID_UDA1380 symbol is lacking is linux/i2c-id.h.

Removed also. Optional in I2C subsystem, no more present in last docs; no u=
se.=20
No need to apply for an ID allocated in include/linux/i2c-id.h .

Giorgio


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
