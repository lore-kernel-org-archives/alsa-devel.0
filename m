From: Riku Voipio <riku.voipio@iki.fi>
Subject: async alsa applications and pcm plugin sound output
Date: Wed, 3 Jan 2007 22:09:00 +0200
Message-ID: <20070103200900.GA15841@kos.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,

It possible to use async callbacks[1] using snd_async_add_pcm_handler()
to find out when it is possible to write to ALSA. It is also possible
to write a alsa-lib I/O Plugin for sound output[2]. Such 
plugins have been created atleast for alsa-bluetooth[3] and
dsp gateway[4]. Unfortunatly it seems IO plugins don't support
async playback. Using the pcm binary from alsa testsuite 
and dsp gateway I/O plugin:

-snip-
./pcm -Ddefault -m async
Playback device is default
Stream parameters are 44100Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Using transfer method: async
Unable to register async handler
-snip-

It appears external IO plugins are not _allowed_ to
deal with async stuff:

-snip-
static int snd_pcm_ioplug_async(snd_pcm_t *pcm ATTRIBUTE_UNUSED,
                int sig ATTRIBUTE_UNUSED,
                pid_t pid ATTRIBUTE_UNUSED)
{
    return -ENOSYS;
}
-snip-

Does this mean that async callbacks should not be used if you
want to be sure sound works everywhere? Is there a chance that
plugin api will be changed to allow plugins implement async
callbacks?

Cheers,
Riku

[1] http://alsa2.opensrc.org/HowTo_Asynchronous_Playback
[2] http://alsa.cvs.sourceforge.net/alsa/alsa-lib/src/pcm/pcm_ioplug.c?revision=1.10&view=markup
[3] http://bluetooth-alsa.sourceforge.net/
[4] https://garage.maemo.org/projects/dsp-alsa/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
