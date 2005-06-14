From: =?utf-8?b?ancsTGVl?= <jwstyle@gmail.com>
Subject: time stamp and dmix
Date: Tue, 14 Jun 2005 02:30:08 +0000 (UTC)
Message-ID: <loom.20050614T040426-721@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi,
I use ALSA lib v1.0.6 
and I got some question about time stamp and dmix in ALSA lib.

1>I want to make application that use dmix like mplayer with dmix option
(one or more application play sound concurrently->this is what I want).
then, I must use snd_pcm_dmix_open instead snd_pcm_open?
I tried to find function related snd_pcm_dmix_* in mplayer source, 
but I cannot find. How can I make it?

2>How can I get the currnt time stamp? I coded like this
    snd_pcm_status_alloca(&alsa_status);
    snd_pcm_status_get_tstamp(alsa_status, &aud_time_stamp);
But I get the answer '0'.

Please give me some advice.

Thanx in advance.

Best Regards.




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
