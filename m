From: "Defiant" <mail@defiant.homedns.org>
Subject: Bug Report: Bad Quality with AC97
Date: Wed, 24 Dec 2003 11:20:25 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <33077.192.168.36.2.1072261225.squirrel@defiant.homedns.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Alsa-Version:
0.9.6 - 1.0.0rc2 and the one included in Linux Kernel 2.5.x, 2.6.x-2.6.0
What:
Bad Quality playing bass on AC'97

Hello,

I'm not 100% sure that I'm posting at the right place, but I will just start:
I was using alsa-driver 0.9.3 a long time and was very contently with it.
Then I hear you made the 1.dot release so I simply upgraded to the latest
version. Well switching to alsa-driver 1.0.0 got ma a little problem:
I get a bad Quality playing 'bass' on my laptop.

After some research I found out that this Problem started in Alsa driver
Version 0.9.6 - I needed two! real days to find what change caused the
problem:
Near line 812 in file alsa-driver/alsa-kernel/core/oss/pcm_oss.c
In static ssize_t snd_pcm_oss_write1(...)
After
buf += tmp;
bytes -= tmp;
xfer += tmp;

You changed
if (runtime->oss.buffer_used == runtime->oss.period_bytes) {
To
if (substream->oss.setup == NULL || !substream->oss.setup->wholefrag ||
runtime->oss.buffer_used == runtime->oss.period_bytes) {

Next Lines are
tmp = snd_pcm_oss_write2(substream, runtime->oss.buffer,
runtime->oss.buffer_used, 1);
if (tmp <= 0)
 return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 runtime->oss.bytes += tmp;

Well I don't know what these lines does mean, I only know that undo this
change is giving be good Sound Quality again, so it would be cool, if you
could undo this for next Version or could do something else to fix this.

My Soundcard:
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio
Controller (rev 02)

lsmod:
snd-seq-oss            29472   0  (unused)
snd-seq-midi-event      3584   0  [snd-seq-oss]
snd-seq                38000   2  [snd-seq-oss snd-seq-midi-event]
snd-pcm-oss            38820   1
snd-mixer-oss          13520   0  [snd-pcm-oss]
snd-intel8x0           18948   1
snd-ac97-codec         48588   0  [snd-intel8x0]
snd-pcm                63744   0  [snd-pcm-oss snd-intel8x0]
snd-timer              14980   0  [snd-seq snd-pcm]
snd-page-alloc          6740   0  [snd-intel8x0 snd-pcm]
snd-mpu401-uart         3504   0  [snd-intel8x0]
snd-rawmidi            14048   0  [snd-mpu401-uart]
snd-seq-device          4368   0  [snd-seq-oss snd-seq snd-rawmidi]
snd                    34276   0  [snd-seq-oss snd-seq-midi-event snd-seq
snd-pcm-oss snd-mixer-oss snd-intel8x0 snd-ac97-codec snd-pcm snd-timer
snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3908   6  [snd]

I hope that you can fix that in the next Alsa-driver Version.

greetings, Merry Christmas, and sorry for that bad English :)

Erik Andresen

--

All I ask is a tall ship, and a star to steer her by
> defiant.homedns.org <
 -cause Experience is Knowledge



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
