From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: non-running sequencer queues
Date: Mon, 12 Jan 2004 17:19:56 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401121719.56879.cannam@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


I notice that if you send to a non-running sequencer queue an event 
scheduled for exactly the current time of the queue, then the event 
is delivered immediately: the queue doesn't wait to be started first.

Is this intentional?  I had thought the main reason for allowing 
queues to stop and start was to permit stuffing a queue with events 
away from the pressure of time and then decide at leisure when to 
start playing them, but that only seems to make sense if the queue is 
guaranteed not to deliver any of them until you tell it to go.  If 
it's intentional, what is the intended use?  (compared to not queuing 
your event at all, that is.)


Chris



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
