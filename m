From: Krivenok Dmitry <_asr_@inbox.ru>
Subject: Possible bugs in dummy.c
Date: Sun, 06 Aug 2006 22:59:34 +0400
Message-ID: <E1G9nqY-00085H-00._asr_-inbox-ru@f22.mail.ru>
References: <s5hfygegd7e.wl%tiwai=40suse.de>
Reply-To: Krivenok Dmitry <_asr_@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: =?koi8-r?Q?<s5hfygegd7e.wl%tiwai=40suse.de>?=
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello All!

Look at the following code:

static struct snd_pcm_hardware snd_card_dummy_playback =
{
        .info =                 (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
                                 SNDRV_PCM_INFO_RESUME | SNDRV_PCM_INFO_MMAP_VALID),
        .formats =              USE_FORMATS,
        .rates =                USE_RATE,
        .rate_min =             USE_RATE_MIN,
        .rate_max =             USE_RATE_MAX,
        .channels_min =         USE_CHANNELS_MIN,
        .channels_max =         USE_CHANNELS_MAX,
        .buffer_bytes_max =     MAX_BUFFER_SIZE,
        .period_bytes_min =     64,
        .period_bytes_max =     MAX_BUFFER_SIZE, // !!!
        .periods_min =          USE_PERIODS_MIN,
        .periods_max =          USE_PERIODS_MAX,
        .fifo_size =            0,
};

Maybe it should be:

static struct snd_pcm_hardware snd_card_dummy_playback =
{
        .info =                 (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
                                 SNDRV_PCM_INFO_RESUME | SNDRV_PCM_INFO_MMAP_VALID),
        .formats =              USE_FORMATS,
        .rates =                USE_RATE,
        .rate_min =             USE_RATE_MIN,
        .rate_max =             USE_RATE_MAX,
        .channels_min =         USE_CHANNELS_MIN,
        .channels_max =         USE_CHANNELS_MAX,
        .buffer_bytes_max =     MAX_BUFFER_SIZE,
        .period_bytes_min =     64,
        .period_bytes_max =     MAX_PERIOD_SIZE, // !!!
        .periods_min =          USE_PERIODS_MIN,
        .periods_max =          USE_PERIODS_MAX,
        .fifo_size =            0,
};

The second possible bug:

static struct snd_kcontrol_new snd_dummy_controls[] = {
DUMMY_VOLUME("Master Volume", 0, MIXER_ADDR_MASTER),
DUMMY_CAPSRC("Master Capture Switch", 0, MIXER_ADDR_MASTER),
DUMMY_VOLUME("Synth Volume", 0, MIXER_ADDR_SYNTH),
DUMMY_CAPSRC("Synth Capture Switch", 0, MIXER_ADDR_MASTER),
DUMMY_VOLUME("Line Volume", 0, MIXER_ADDR_LINE),
DUMMY_CAPSRC("Line Capture Switch", 0, MIXER_ADDR_MASTER),
DUMMY_VOLUME("Mic Volume", 0, MIXER_ADDR_MIC),
DUMMY_CAPSRC("Mic Capture Switch", 0, MIXER_ADDR_MASTER),
DUMMY_VOLUME("CD Volume", 0, MIXER_ADDR_CD),
DUMMY_CAPSRC("CD Capture Switch", 0, MIXER_ADDR_MASTER)
};

I'm not sure, but I think it should be:

static struct snd_kcontrol_new snd_dummy_controls[] = {
  DUMMY_VOLUME ("Master Volume", 0, MIXER_ADDR_MASTER),
  DUMMY_CAPSRC ("Master Capture Switch", 0, MIXER_ADDR_MASTER),
  DUMMY_VOLUME ("Synth Volume", 0, MIXER_ADDR_SYNTH),
  DUMMY_CAPSRC ("Synth Capture Switch", 0, MIXER_ADDR_SYNTH),
  DUMMY_VOLUME ("Line Volume", 0, MIXER_ADDR_LINE),
  DUMMY_CAPSRC ("Line Capture Switch", 0, MIXER_ADDR_LINE),
  DUMMY_VOLUME ("Mic Volume", 0, MIXER_ADDR_MIC),
  DUMMY_CAPSRC ("Mic Capture Switch", 0, MIXER_ADDR_MIC),
  DUMMY_VOLUME ("CD Volume", 0, MIXER_ADDR_CD),
  DUMMY_CAPSRC ("CD Capture Switch", 0, MIXER_ADDR_CD)
};

Am I right?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
