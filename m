From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Problems with snd_pcm_status_get_delay()
Date: Wed, 09 Oct 2002 02:25:40 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA30704.3050000@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello

Can someone please explain to me the use of snd_pcm_status_get_delay()

If a buffer size is 16384, and avail=6384, should delay therefore equil 
10000 ? In all cases ?

I have found that in  SND_PCM_STATE_RUNNING, delay = buffer_size - avail.
I have found that in  SND_PCM_STATE_PREPARED, delay = 0

This causes problems. As one fills the buffer in SND_PCM_STATE_PREPARED 
, delay stays at 0, but when the buffer fills enough and moves to state 
 SND_PCM_STATE_RUNNING, the delay value suddenly jumps to delay = 
buffer_size - avail.

This causes problems with applications that need "delay" to be as 
accurate as possible at all times.
Is this a bug in alsa09, or should I ignore "delay" and just use the 
"buffer_size - avail" value.

Obviously, in  SND_PCM_STATE_XRUN, delay is invalid.with avail values 
sometimes becoming > buffer_size!
so should not be used.

Cheers
James




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
