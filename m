From: Gerald Grabner <gerald.grabner@tugraz.at>
Subject: queue synchronization to external clock?
Date: Wed, 01 Jan 2003 23:10:23 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E13674F.6010604@tugraz.at>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

is there any way to synchronize an alsa midi queue to an external midi
source, of which I know the tempo and receive clock events? Of course
I can start my alsa queue after getting a start event, but how can I
avoid a drift over time?

As I also want to do midi recording, it would be nice to have an
offset between external and internal clock of say half a tick, so that
events that come a bit too early are correctely quantized. Is that
possible?

The mail archive of alsa-devel features some related postings, but
being rather new to alsa, it is quite tough to pick the right things.
Therefore I'd be very grateful for hints and help!

Thanks a lot,
Gerald



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
