From: Richard Lemon <richard@clinicdesign.com.au>
Subject: possible intel8x0 problem with nforce chip-set
Date: 21 Oct 2003 13:18:39 +0930
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1066708119.13971.10.camel@baked.spud.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi Guys,

I have been using the alsa api for a while working on some multimedia
stuff.

I believe I have found a bug with the intel8x0 driver when running the
nforce chip-set.

The problem appears to be an uninitialized variable type problem. The
first time you call snd_pcm_mmap_begin() the channels are returned in
their pairs in a random order. That is the rear channels may end up in
the front or Center/LFE slots, etc, the channel order does not change
from then on.

I compiled up the pcm.c test code and tried that out. This shows the
problem, only worse. If you change the generate_sine function to the
following to pick out one pair of channels only.

if ((chn == 2) || (chn == 3))
	*samples[chn] = ires;
else
	*samples[chn] = 0;

then call pcm with the following...
./pcm -r 48000 -c 6 -m direct_noninterleaved

I would expect silence from all but the rear pair. What we get is a
sequencing of the audio through the 6 channels. It makes no difference
which of the modes or rates I use.

Am I just misusing the api or is this a bug?

Here are the hardware specs.

ShuttleX pc
North bridge-Nvidia nForce2, South bridge-nVidia MCP-T
Realtek ALC650 6 Ch, Support Digital SPDIF Output

for more details on hardware.
http://www.us.shuttle.com/specs_access.asp?pro_id=284

running Mandrake Linux 9.0.

I have tested several of the alsa releases and am currently using 0.9.6.

Richard Lemon.




-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
