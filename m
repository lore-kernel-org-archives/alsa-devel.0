From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: trigger problems.
Date: Wed, 14 Jul 2004 13:52:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40F52C9D.60704@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I am writing a alsa driver for the audigyls and p16v.
The output on these sound cards can work in 1 of two ways.
1) 1 substream with 8 channels, and one interrupt request per period.
For 5.1 output, we just use alsa.conf to map the user's application 
channels into the correct channels of the 8 channel substream.
2) 4 substreams with 2 channels each.
For 5.1 output, we just use 3 substreams, front, rear, center_lfe.
The problem with this is that we then have a separate interrupt per 
substream, resulting in 3 times more interrupts. The substreams are also 
not in sample sync with each other, because the trigger for each 
substream is executed one after the other, instead of in one go.

I don't know why exactly, maybe some audio experts can help, but (1) 
sounds a lot better than (2). I would not think that loosing sample sync 
would make so much difference, but that is the only thing that I see 
different between (1) and (2).

So, because of this, I have a feature request for alsa-driver.
If a user app opens the sound device in such a way that a single stream 
from the app gets converted into multiple substreams to the same sound 
card hardware, can we have a single trigger call for all substreams.

If we could have a single trigger call, I could start all the hardware 
substreams at the same time with a single outl() call.

To achieve this, I suggest we change the current:
static int snd_pcm_trigger_playback(
         snd_pcm_substream_t *substream,
         int cmd)
to
static int snd_pcm_trigger_playback(
         snd_pcm_substream_t **substream,
	int number_of_substreams,
         int cmd)


Any comments ?

James


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
