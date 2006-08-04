From: Eric Peters <epeters@graphics.cs.uni-sb.de>
Subject: How to stop a device immediately??
Date: Fri, 04 Aug 2006 14:51:47 +0200
Message-ID: <44D342E3.908@graphics.cs.uni-sb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

Dear all,

I have a PCM device which is playing some PCM samples. The soundbuffer
is pretty full. And now I want to pause the buffer immediately (as
fast as possible) and sometime later I want to resume at exactly this
sample I paused.

Now I found the two functions snd_pcm_pause and snd_pcm_resume. But
unfortunately these functions aren't supported by all hardware. Do you
know if modern hardware like different sound blaster cards supports
this functions?

Or do you have an idea how to implement such a feature? I also found
the two functions snd_pcm_drain and snd_pcm_drop. But when I use this
functions the sound buffer will be empty if I resume. And with
snd_pcm_drain there will be a delay between I pause the playback and
there are no more samples out of my spaekers.

Thanks in advance
Eric

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
