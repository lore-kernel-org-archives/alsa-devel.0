From: Martin Langer <martin-langer@gmx.de>
Subject: Typo in Writing-an-ALSA-Driver
Date: Sun, 21 Dec 2003 19:11:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031221181117.GA13971@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


Hi,

two small typos in the docs on
http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x494.htm

There are *playback* labeled functions for open and close:

static snd_pcm_ops_t snd_mychip_playback_ops = {
       .open =        snd_mychip_playback_open,
       .close =       snd_mychip_playback_close,
       [...]
};

But OTOH they were called *pcm* instead of *playback*:

static int snd_mychip_pcm_open(snd_pcm_substream_t *subs) {}
static int snd_mychip_pcm_close(snd_pcm_substream_t *substream) {}


martin


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
