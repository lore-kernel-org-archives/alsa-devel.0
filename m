From: Joshua N Pritikin <vishnu@pobox.com>
Subject: HDSP 96/52
Date: Sun, 27 Apr 2003 13:36:03 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030427080603.GB641@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Mark Knecht wrote:
> I'm getting a lot of reasonable or even good results, but no actual
> audio unfortunately.

Me too.  The driver loads fine.  hdspconf works great.  My A/D
converter is happy.  i tried running the following script to
set all the mixer levels to unity.

for dest in $(seq 0 26);do
  for i in $(seq 0 51);do
    amixer cset numid=5 $i,$dest 32768 > /dev/null;
  done
done

However, i've never gotten any audio through the card.  Only silence.
If there is any patch available then i'm happy to test it.

-- 
Victory to the Divine Mother!!         after all,
  http://sahajayoga.org                  http://why-compete.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
