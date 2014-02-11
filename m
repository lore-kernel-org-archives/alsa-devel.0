From: Andreas Zeiler <zeiler@fs-net.de>
Subject: Noise on right channel of WM9715
Date: Tue, 11 Feb 2014 09:03:17 +0100
Message-ID: <5B70540BA10E7D49BEC1ACD5D414885353D7189694@FS-SBS2008.fs-net.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.171])
 by alsa0.perex.cz (Postfix) with ESMTP id B4977261A1C
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2014 09:03:23 +0100 (CET)
Content-Language: de-DE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

we have a board with an iMX6 processor from freescale and a Wolfson WM9715.
I can play music/sound files with it. We're on Linux 3.0.35.
The problem is that there is a noise on the right channel and this noise ch=
anges with the frequency. I don't mean the sample rate with that.
I'm playing a wav-file with a Sinus from 440Hz to 880Hz or higher. I can he=
ar how the noise is changing.
Then I played a silence file with nothing in it. When I see this file it ha=
s some small artefacts (in audacity). On the left channel I hear nothing as=
 expected.
On the right channel I hear some clicking. It's not periodic but I hear it =
very often.

So I turned off everything I don't need in the WM9715. So just the DAC (PCM=
 (Register 0x18)) and the Headphone Mixer (register 0x04) are turned on. Ev=
erything else is in default state or muted. AC97 communication is working. =
I have a good clock etc.
I think that there is something wrong when my audio data gets into the ac97=
 slot. Maybe it gets shifted wrong or something else.

Can someone help me with this? Does someone know what can be wrong here??

Mit freundlichen Gr=FC=DFen / With kind regards

Andreas Zeiler
(zeiler@fs-net.de<mailto:zeiler@fs-net.de>)

________________________________
armStone: Pico-ITX ARM based Single Board Computer
________________________________
F&S Elektronik Systeme GmbH, Stuttgart, Germany
Geschaeftsfuehrer: Holger Froelich, Guenther Scholz
Handelsregister Stuttgart HRB 18493, VAT DE178964418
