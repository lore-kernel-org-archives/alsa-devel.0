From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: dmix bugs. sounds very broken up.
Date: Mon, 01 Sep 2003 01:59:18 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F5299E6.7040408@superbug.demon.co.uk>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have found two problems with using the dmix alsa device name.
1) snd_pcm_hw_params_can_pause (params)  causes alsa-lib to assert!

2) Sound is broken up.
a) It can only function with 2 periods, why is that? Having 8 periods
might be better, although "front" works fine with 2 periods, but "dmix"
with 2 periods fails.
b) Of the 2 periods, it sounds like sound is only being played from one
of the periods, with silence for the other period.

Summary: -
If I use device name "front", there are no problems with sound output.
If I use device name "dmix", there are the above problems.

Cheers
James




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
