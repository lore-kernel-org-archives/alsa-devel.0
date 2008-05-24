From: =?ISO-8859-1?Q?Martin_Kr=FCger?= <m_a_krueger@gmx.de>
Subject: Re: PATCH - MIDI on ice1724 - real-time kernel problem
 SOLVED(?)
Date: Sat, 24 May 2008 18:53:01 +0200
Message-ID: <483847ED.8050208@gmx.de>
References: <20080520112539.81C9D2484D@alsa0.perex.cz>
	<m2bq2xtixw.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 22FA324343
	for <alsa-devel@alsa-project.org>;
	Sat, 24 May 2008 18:53:03 +0200 (CEST)
In-Reply-To: <m2bq2xtixw.fsf@vador.mandriva.com>
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
List-Id: alsa-devel@alsa-project.org

Pavel Hofman wrote:
>Clemens,
>
>Thanks a lot. After a few pointer fixes to make it compile your code =

>works flawlessly for both the generic as well as realtime ubuntu kernel.
>
>I am enclosing the functioning patch.
>
>Now I cannot feel any delay difference between usb and ice1724 midi =

>inputs. Well done, gentlemen, thank you all.

Hi, =


thanks a lot for taking care for that issue. =

I just tried it out by modifying the following files from the 2.6.26-rc3 ke=
rnel:

sound/pci/Kconfig (modified by hand)
sound/pci/ice1712/ice1712.h (modified by hand)
sound/pci/ice1712/envy24ht.h (modified by hand)
sound/pci/ice1712/ice1724.c (copied from the actual Git snapshot)

I double-checked all the handmade changes, should be ok. =


Midi in via "amidi -p hw:0 -d" works now without problem, =

but when trying to write to the device, for example by "amidi -p hw:0 -s tx=
data.syx" =

it causes an immediate crash. =


That would not be a problem for me, but jackd probes all ports, and is unus=
able now.

Perhaps i forgot a patch, is the output working for you? =


My System: =

Amd64 @ 32Bit, =

Debian Sid,
Esi Juli@

Regards, =


Martin Kr=FCger
