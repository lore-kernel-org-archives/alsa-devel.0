From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: Re: non-running sequencer queues
Date: Mon, 12 Jan 2004 17:31:15 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401121731.15808.cannam@all-day-breakfast.com>
References: <200401121719.56879.cannam@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200401121719.56879.cannam@all-day-breakfast.com>
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

On Monday 12 Jan 2004 5:19 pm, Chris Cannam wrote:
> I notice that if you send to a non-running sequencer queue an event
> scheduled for exactly the current time of the queue, then the event
> is delivered immediately: the queue doesn't wait to be started
> first.
>
> Is this intentional?

OK, my description was a little incomplete and now that I've refined 
my search on the ALSA list archives it seems the question may be 
obvious and perhaps moot.  I was queueing my events on the stopped 
queue (using RT timestamps rather than ticks) and then draining the 
alsa-lib buffer via snd_seq_drain_output; of course, in practice I 
can simply defer the latter until I actually want to start the queue.

I do find the stopped queue's behaviour a bit perplexing though.


Chris



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
