From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Noisy audio - ALSA Configuration
Date: Thu, 16 Aug 2007 10:01:17 +1200
Message-ID: <200708161001.17944.linux@audioscience.com>
References: <BAY133-F32D7F625C6B67D236D68CEC3DD0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 082E024445
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Aug 2007 23:59:56 +0200 (CEST)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JMU00I7R53P2P10@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 16 Aug 2007 09:59:53 +1200 (NZST)
In-reply-to: <BAY133-F32D7F625C6B67D236D68CEC3DD0@phx.gbl>
Content-disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Magdalena Iovescu <magdab@hotmail.com>
List-Id: alsa-devel@alsa-project.org

> Eliot,
> Thank you very much. Here is the message. If Hotmail is the problem I can
> subscribe using my work e-mail; I wanted to avoid that in the first place.
> Magdalena

The Hotmail message is all HTML, with no plaintext version.  I'm not sure i=
f =

this list accpets html mails. OR  The text of the mail is all encapsulated =
in =

a number of HTML <DIV> blocks, maybe confused html to text converter...

Here is the original question:

> Does anyone have examples or documentation on how to configure periods,
> frames and buffers for various sample rates? I am writing a program to
> route a mp3 decoder output to ALSA on an ARM processor, and I get noisy
> audio. For a CD quality stream (S16_LE, 44100 kHz, Stereo, 128 bps) I am
> using an output=A0buffer of 44100 bytes, a period of 44100/(channels*2). =
With

Be careful about the distinction between bytes and frames (i.e. a frame of =

stereo S16 is 4 bytes)

Start with the period =

1024 frames =3D  4096 bytes
then make your buffer at least 2x this:
8192 bytes

(I'm not an app developer, so others may jump in with a better explanation)

Did you look at the code in alsa-lib/test?

> a buffer this big, I do not get underruns, but I do get all short writes.=
 I
> have not been able to find the right configuration to avoid short writes,
> and more importantly, to get good quality audio. What do 'short writes' (I
> am using writei) really mean? Is this a performance issue in the driver, =
or
> is mainly because of buffer setup? I would really appreciate any help with
> this.
> Magdalena
