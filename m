From: Alftheo Potgieter <alfp@adsmr.co.za>
Subject: SBLive capture
Date: Mon, 28 Oct 2002 10:45:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021028104500.0bb63ab8.alfp@adsmr.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi

I'm trying to capture two streams from my SBLive card: one with just the microphone input, and one with everything
(in my case, microphone and pcm output). Is this at all possible? I see there are three capture devices...

Another (maybe the same) question: If i do arecord -Dplughw:0,0,0, I can set up recording as I wish using alsamixer,
but if i do arecord -Dplughw:0,1,0, nothing gets recorded, and I cant see anywhere to set up this capture device.
How do I specify mixer settings for this second capture device?

alf


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
