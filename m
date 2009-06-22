From: Christopher Tsui <cicciolina@sbcglobal.net>
Subject: Need help on mmap
Date: Mon, 22 Jun 2009 11:54:46 -0700 (PDT)
Message-ID: <453508.13954.qm@web81902.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web81902.mail.mud.yahoo.com (web81902.mail.mud.yahoo.com
	[68.142.207.181]) by alsa0.perex.cz (Postfix) with SMTP id 27BA8245CE
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Jun 2009 20:54:47 +0200 (CEST)
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

Hi

I am in the process of add mmap support in my ALSA driver.

So this is what i have done so far

In snd_pcm_hardware structure
.info =3D SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP |=A0=A0=A0=A0=A0=
 SNDRV_PCM_INFO_MMAP_VALID

In snd_pcm_ops structure
.mmap =3D my_pcm_mmap

So to test my code,=A0 I use
aplay -M -Dhw:0 rock.wav

and this is what I get
ALSA lib pcm_mmap.c:378:(snd_pcm_mmap) mmap failed: Invalid argument
aplay: set_params:1022: Unable to install hw params:
ACCESS:=A0 MMAP_INTERLEAVED
FORMAT:=A0 S16_LE
SUBFORMAT:=A0 STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (27210 27211)
PERIOD_SIZE: 1200
PERIOD_BYTES: 4800
PERIODS: 4
BUFFER_TIME: (108843 108844)
BUFFER_SIZE: 4800
BUFFER_BYTES: 19200
TICK_TIME:
 10000

What am I doing wrong??

Thanks in advance
