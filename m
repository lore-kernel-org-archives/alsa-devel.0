From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: Audio support for codec Philips UDA1380
Date: Mon, 07 Nov 2005 21:13:38 +0100
Message-ID: <85ek5sz05p.fsf@Orfeo.duckcorp.org>
References: <200511041201.01260.giorgio@mandarinlogiq.org>
	<85wtjo4m82.fsf@Orfeo.duckcorp.org>
	<200511050757.01732.giorgio@mandarinlogiq.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200511050757.01732.giorgio@mandarinlogiq.org> (Giorgio Padrin's
	message of "Sat, 5 Nov 2005 07:57:01 +0100")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giorgio Padrin <giorgio@mandarinlogiq.org>
Cc: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, alsa-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Giorgio Padrin <giorgio@mandarinlogiq.org> writes:

> Alle 13:43, venerd=C3=AC 4 novembre 2005, Arnaud Patard ha scritto:
>> > See h2200_audio (also on the site) for a sample glue module, that su=
pport
>> > the audio of an iPAQ h2200 handheld, using it together with a
>> > complementary module for the Intel PXA2xx I2S audio.
>>
>> So, the uda1380 module is generic enough to be used on non PXA boards =
?
>
> Yes. It's so intended.

okay..  so you may safely remove the pxa header :)

I've done a test build and it doesn't build because the
I2C_DRIVERID_UDA1380 symbol is lacking is linux/i2c-id.h.

Arnaud.



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
