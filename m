From: Francisco Moraes <fmoraes@nc.rr.com>
Subject: Re: Rate or Plug plugin problem when converting rate
 down
Date: Fri, 09 Jul 2004 19:47:47 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40EF2EA3.1090205@nc.rr.com>
References: <40EDDFAC.9000201@nc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40EDDFAC.9000201@nc.rr.com>
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

Francisco Moraes wrote:

> Whenever I use plug, plughw or rate plugins to convert a stream into a 
> lower frequency, I get cracks in the sound output.
>
> I am attaching a dump of aplay -v with the rate plugin being used.
>
> Any ideas of what can be wrong? I've tried even 24000 which is half of 
> the default frequency of the emu10k1x card, but it still causes the 
> problem.

I've looked at the source code for the pcm_rate plugin and it seems like 
*snd_pcm_rate_shrink* will not fill the destination buffer last byte, at 
least from in the cases I've tried. From looking at the code, the loop 
is controlled by the source frames, which is bigger than the 
destination. Depending on the get_increment fractional part, the last 
"put" into the destination buffer will not happen and sound noise will 
be generated. It gets worse on lower frequencies and I've been able to 
reproduce this on both the emu10k1x and cs46xx sound cards.

I've also used the file plugin to write the output to a file and to play 
it back and the sound noise was present in the written file.

It seems to me that the code calling the function assumes that all bytes 
in the destination buffer will be filled and that's not happening. For 
istance:

from 48000 to 24000, which would be a simple 0x8000 step in the code, 
the actual calculated value for the get_increment is 0x7FFF from this code:

rate->pitch = (((u_int64_t)dst_rate * LINEAR_DIV) + src_rate - 1) / src_rate;

Anybody  with better knowledge to comment on the above?

Francisco


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
