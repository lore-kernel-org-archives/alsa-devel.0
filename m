From: "David Cummings" <real.psyence@gmail.com>
Subject: PCM Multi capture w/ICE1712 help?!
Date: Fri, 12 Jan 2007 02:09:57 -0500
Message-ID: <dbce93020701112309sea91e85p9af0a91006ce1dbe@mail.gmail.com>
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

Hi all,
    First, sorry if this has been discussed, I tried to search but
wasn't satisfied. I'm trying to write an app that will capture from a
Delta 1010LT (8 ch) as well as the onboard ACL850(4ch?) of the A8N-SLI
motherboard. Somehow I'd like to record from 12 channels
simultaneously and be able to address each one individually for
encoding/transmit/etc. purposes. I'm really confused as to how to go
about this.
1) If i write a .asoundrc like the one here
http://www.sound-man.co.uk/linuxaudio/ice1712multi.html, can I then
open the device using pcm_name = "multi_capture" (from that example)?
If so, do I have to set SND_PCM_ACCESS_MMAP_COMPLEX? and where are my
individual channels in the buffer then?
2) If the above isn't the right way to do it, is snd_pcm_multi_open or
_snd_pcm_multi_open the right way? and if so, how do I set up the
bindings, etc.
3) The above page mentions an issue with the current release versions
and multi channel playback and capture. Supposing I'll want to play
back something at the same time I'm recording, I'll need to apply the
mentioned patch right?

The requirements are really lightweight, latency's not really an
issue, 8kHz sampling is fine, etc., but i'm stuck on this. Any help,
pointers, manuals to read, etc. would really be appreciated.
Thanks in advance, and I hope I'm not asking too much,
-Dave

-- 
The way that can be named is not the Way.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
