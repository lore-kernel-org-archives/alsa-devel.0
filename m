From: "Markus Rechberger" <mrechberger@gmail.com>
Subject: struct snd_pcm_hardware_t values
Date: Sat, 5 Aug 2006 15:09:13 +0200
Message-ID: <d9def9db0608050609t3683aba9ja80690a8758098e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B6D8116B
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Aug 2006 15:09:18 +0200 (MEST)
Received: by py-out-1112.google.com with SMTP id b29so105231pya
	for <alsa-devel@alsa-project.org>; Sat, 05 Aug 2006 06:09:13 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

a half year ago I bought an au600 device
(http://alsa.opensrc.org/au600) and it's still not supported... I made
some progress uppon the driver but there are still a few issues left.

does anyone know about the snd_pcm_hardware_t struct?
I'm not sure what values I should fill in there...
My current driver supports a choppy kind of playback and capturing choppy audio.
If I use following values in the struct my box locks up when the audio
stream is over (uninitialized buffer for sure)
static snd_pcm_hardware_t snd_au600_hw = {
    .info = SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP |
SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP_VALID,
    .formats = SNDRV_PCM_FMTBIT_S16_LE,
    .rates = SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS,
    .rate_min = 9600,
    .rate_max = 9600,
    .channels_min = 1,
    .channels_max = 1,
    .buffer_bytes_max = (32*1024),
    .period_bytes_min = 64,
    .period_bytes_max = 2048,
    .periods_min = 1,
    .periods_max = 255,
};

If I set the values lower it doesn't crash anymore but afterwards the
stream sounds garbled.

The streamformat itself is PCM, 9600hz, 16Bit, mono, S16_LE (capturing
as well as playback)

Markus

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
