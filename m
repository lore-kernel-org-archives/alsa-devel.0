From: Brian Victor <bhv1@psu.edu>
Subject: Re: General Guidelines?  (MIDI)
Date: Wed, 15 Jan 2003 22:27:13 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030116032713.GA30510@bhv1.adelphia.net>
References: <20030114212004.GA24898@bhv1.adelphia.net> <Pine.HPX.4.33n.0301151227400.2915-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0301151227400.2915-100000@studcom.urz.uni-halle.de>
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

On Wed, Jan 15, 2003 at 12:43:18PM +0100, Clemens Ladisch wrote:
>Running queues are visible in /proc/asound/seq/timers IIRC. And in theory,
>ALSA should properly free queues/timers when doing ^C.

Thanks once more.  I feel like I'm getting closer, but I'm still
struggling.  This is my NoteOn code:

void wxMidiQueue::NoteOn(const wxMidiOutput& port, int key,
                         int velocity, int tick, int channel)
{
  snd_seq_event_t ev;
  snd_seq_ev_clear(&ev);
  snd_seq_ev_set_note(&ev, channel, key, velocity, 10);
  snd_seq_ev_schedule_tick(&ev, m_queue, 0, tick);
  snd_seq_ev_set_source(&ev, port.GetAlsaPort());
  snd_seq_ev_set_subs(&ev);
  snd_seq_event_output_direct(m_drv.GetAlsaSeq(), &ev);
}

For testing, I placed this in a for loop:
for (x=0; x<400; ++x) queue->NoteOn(*out, x, 127, x, 0);

Monitoring /proc/asound/seq/queues shows the events being queued, but as
soon as the queue starts, all 400 notes leave the queue instantly; none
are played.  miniArp, from which this code is extracted nearly verbatim,
will show the "queued tick events" rising and falling as notes are
played and requeued.  The output of /proc/asound/seq/timer when running
miniArp and my test program are identical.

Clearly I'm doing something blatantly wrong, but I've compared my code
to the sample's with a fine-tooth comb, and I can't for the life of me
figure out what.  Can you see where the problem is?

Thank you once again for your patience.

-- 
Brian


-------------------------------------------------------
This SF.NET email is sponsored by: A Thawte Code Signing Certificate 
is essential in establishing user confidence by providing assurance of 
authenticity and code integrity. Download our Free Code Signing guide:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0028en
