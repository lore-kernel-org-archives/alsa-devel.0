From: "Demian Martin" <demianm_1@yahoo.com>
Subject: Via VT82xx VT1708 ICE1724HT and higher sample rate/bit
	depth files through SPDIF
Date: Mon, 25 Feb 2008 22:15:17 -0800
Message-ID: <068801c8783e$f5456390$d450a8c0@PDSMain2>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n6.bullet.mud.yahoo.com (n6.bullet.mud.yahoo.com
	[216.252.100.57]) by alsa0.perex.cz (Postfix) with SMTP id 630382460F
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 07:19:30 +0100 (CET)
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

I have several problems trying to play files higher than 48000 KHz and with
bit depth of 24 bits. I submitted this to the users and got a resounding
silence.

 =


First- sample rate

Even though the documents claim that it will play at 176.4 KHz and 192KHz
whenever I play a file at these rates it down converts to =BD the rate (882=
00
and 96000). I tested this with the ICE1724HT (Juli@) which has almost the
same core, I never could get 176.4KHz at the SPDIF output. I confirmed that
the ICE1724 will play the file at 176.4KHz in Windows so its not a hardware
limitation. I tried to do the same with the VT1708 (on a Via CX700  chipset)
and the Windows driver wouldn=92t let me at anything other than 48000. =


 =


Second, the only way I can get the 24 bit files out in a form that the card
can play is to pass them through dmix. But I need to reconfigure dmix for
each sample rate. And I=92m not convinced that it isn=92t resampling twice,=
 both
at the input and the output. Or how to configure the buffers etc. to prevent
underruns even when the only conversion is to pass a 24 bit file to the
card.

 =


I=92m trying to build a high quality music server that will pass the files =
to
either the internal or an external DAC at the bit depth and sample rate they
were recorded at. I have tried to understand the various plugs and settings
but it seems they are all focused on mixing various streams. I want to send
the files unmixed to the output. I can=92t figure out what set of plugs and
settings in asound.conf would enable this.

 =


 =


 =
