From: vanDongen-Gilcher <gml@xs4all.nl>
Subject: mmap questions
Date: Mon, 28 Oct 2002 17:16:34 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0CkXrR161FA30000.gml@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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

Hi all,

With snd_pcm_mmap_begin I get the offset in the ringbuffer for the period 
that has just been played.
So anything I put there will only be played after bufferlength frames (a 
little less probably)
Is it possible to write ahead in the ringbuffer?
For instance two periods ahead? 
I have tried a couple of different ways with little succes, and little 
understanding.

I am asking because my card (a rme96) has a fixed buffer length, and pretty 
bad latency in mmap mode. Normal blocked read/writes are _much_ better.  


regards

Gerard


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
