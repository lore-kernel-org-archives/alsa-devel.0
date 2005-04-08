From: Steve deRosier <derosier@pianodisc.com>
Subject: usage of snd_seq_queue_status_get_real_time()
Date: Thu, 07 Apr 2005 17:51:24 -0700
Message-ID: <4255D58C.9010903@pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

All,

I'm trying to use the snd_seq_queue_status_get_real_time() call to retrieve the current time on the queue so I can compare it to the events I'm pushing into the queue (in order to track down a possible synchronization bug).  But every call I do ends up outputting the same data.

Here's the relevant code snippets:

const snd_seq_real_time_t * CMIDIPort::GetRealQueueTime( void )
{
  snd_seq_queue_status_t * qs;

  snd_seq_queue_status_alloca( &qs );
  snd_seq_get_queue_status( hSeq, mQueue, qs );
  return snd_seq_queue_status_get_real_time( qs );
}

Caller:
// snip
  const snd_seq_real_time_t * CurTime = mMIDIPort.GetRealQueueTime();
  Debugger->DebugMsg( this, "MIDI clock time %d.%d", (int) CurTime->tv_sec, (int) CurTime->tv_nsec );
// snip


and the output:
...
[CAlsaSender | 15:19:22] MIDI clock time 28.-1086326380
[CAlsaSender | 15:19:22] MIDI clock time 28.-1086326380
[CAlsaSender | 15:19:22] MIDI clock time 28.-1086326380
[CAlsaSender | 15:19:35] MIDI clock time 28.-1086326380
[CAlsaSender | 15:19:35] MIDI clock time 28.-1086326380
[CAlsaSender | 15:19:35] MIDI clock time 28.-1086326380
...

I'm sure it's obvious, but I just don't see what the problem is.
/proc/asound/seq/queues shows me the time is continually incrementing.

Thanks,
- Steve



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
