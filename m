From: Peter Plessas <plessas@mur.at>
Subject: Re: hdsp oss emulation and sync
Date: Wed, 29 Jun 2005 12:30:02 +0200
Message-ID: <42C2782A.7060308@mur.at>
References: <42C17BBC.1070402@mur.at> <s5hbr5p7bq7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbr5p7bq7.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi, List,

Takashi Iwai wrote:

> How doesn't it work?  More detailed explanation please?

I have the card synced as slave to my mixer.
I get the following error messages when starting f.e. pd or rezound:

(all software also tested as root)

pd -verbose -oss
device 1: tried /dev/midi READ/WRITE; returned 5
opened 1 MIDI input device(s) and 1 MIDI output device(s).
input channels = 2, output channels = 2
opened /dev/dsp for reading and writing

error: OSS: SNDCTL_DSP_CHANNELS failed /dev/dsp
opened audio output on /dev/dsp; got 0 channels
opened /dev/dsp for reading only

error: OSS: SNDCTL_DSP_CHANNELS failed /dev/dsp
opened audio input device /dev/dsp; got 0 channels


rezound
Error occurred while initializing audio output method 'oss' -- virtual 
void COSSSoundPlayer::initialize() -- error setting the format -- 
Operation not permitted


In both cases dmesg gives:

Jun 29 12:31:49 bigh kernel: No AutoSync source for requested rate

But my rate in pd and of the external source is both 44.1k

As i switch the card to sync master, these apps do fine.

> Well, it's hard to debug without error details...

Where else can i look for meaningful messages?


Thanks,

Peter


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
