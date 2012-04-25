From: Ulrik Kjems <ulrikkjems@yahoo.dk>
Subject: Writing an ASoC codec driver for Beaglebone McASP
Date: Wed, 25 Apr 2012 14:20:41 +0100 (BST)
Message-ID: <1335360041.4047.YahooMailNeo@web132406.mail.ird.yahoo.com>
Reply-To: Ulrik Kjems <ulrikkjems@yahoo.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm7-vm0.bullet.mail.ird.yahoo.com
	(nm7-vm0.bullet.mail.ird.yahoo.com [77.238.189.222])
	by alsa0.perex.cz (Postfix) with SMTP id 90D8F104933
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 15:20:42 +0200 (CEST)
References: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I am working on connecting audio from the beaglebone McASP to a codec on an=
 eval board, supporting a general TDM format. I know for sure the setup is =
viable because I have the system running in a bare-metal configuration usin=
g Starterware. I want to make it work under Linux ALSA/ASoC. I am willing t=
o share the source code if anyone is interested in working on this as well.

To do this I need to configure/write a driver for ALSA/ASoC, and my goal is=
 to be able to perform multi-channel sound capture and playback using ALSA.

The current kernel (3.2.14) davinci platform driver (davinci-evm.c) apparan=
tly supports TI's AM3358 EVM board, which uses the same ARM3358 Sitara proc=
essor as the Beaglebone. The EVM board uses a similar (but not identical) M=
cASP config (and a TLV320AIC3x codec, I believe).

When booting the kernel on the Beaglebone the ALSA driver fails to register=
 with the McASP. =

I can see in soc-core.c around line 825 that four client devices must be fo=
und: codec, codec_dai, platform, and platform_dai. By modifying sound/soc/d=
avinci/davinci-evm.c to reflect the fact that for beaglebone McASP 0 is bei=
ng used (as opposed to the EVM board where mcasp 1 is in use), I can make t=
he platform register:

static struct snd_soc_dai_link am335x_evm_dai =3D {
=A0=A0=A0 .name =3D "TLV320AIC3X",
=A0=A0=A0 .stream_name =3D "AIC3X",
=A0=A0=A0 //=A0=A0=A0 .cpu_dai_name =3D "davinci-mcasp.1",=A0=A0 =

=A0=A0=A0 .cpu_dai_name =3D "davinci-mcasp.0",=A0 // <<<<<<<Changed
=A0=A0=A0 .codec_dai_name =3D "tlv320aic3x-hifi",
=A0=A0=A0 .codec_name =3D "tlv320aic3x-codec.1-001b",
=A0=A0=A0 .platform_name =3D "davinci-pcm-audio",
=A0=A0=A0 .init =3D evm_aic3x_init,
=A0=A0=A0 .ops =3D &evm_ops,
};

Now, all I need is for the codec to register. If I look at /sys/kernel/debu=
g/asoc/ I can see the davinci platform now (the above change enables this)

~# cat /sys/kernel/debug/asoc/platforms =

davinci-pcm-audio
~# cat /sys/kernel/debug/asoc/dais=A0=A0=A0=A0=A0 =

davinci-mcasp.0
~# cat /sys/kernel/debug/asoc/codecs=A0=A0=A0=A0=A0 # No codecs!
~#

Of course, I dont have the codec tlv320aic3x-hifi on my system,- but for no=
w I would be happy configuring my codec manually (as I said its on an eval =
board with a config software tool I can use in place of I2C) so that I coul=
d get sound through the system. =

So my question is, how do I go about convincing ALSA that its OK not to hav=
e the codec? =


Is there a generic codec I could use as a starting point (e.g. setting code=
c_dai_name in the above struct to something else)?

I dont understand the kernel code well enough to see why and how the kernel=
 can detect the absence of the TLV codec above - I dont seem to be getting =
any calls to any of the functions inside sound/soc/codecs/tlv320aic3x.c exc=
ept aic3x_modinit(void) - how on earth does the system know the codec is no=
t there ?
