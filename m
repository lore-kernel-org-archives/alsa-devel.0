From: Brian Victor <bhv1@psu.edu>
Subject: Re: General Guidelines?  (MIDI)
Date: Tue, 14 Jan 2003 16:20:04 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030114212004.GA24898@bhv1.adelphia.net>
References: <20030111183121.GA12653@bhv1.adelphia.net> <Pine.HPX.4.33n.0301131008290.5715-100000@studcom.urz.uni-halle.de> <s5hadi5weoe.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hadi5weoe.wl@alsa2.suse.de>
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

On Mon, Jan 13, 2003 at 11:02:25AM +0100, Takashi Iwai wrote:
>At Mon, 13 Jan 2003 10:25:55 +0100 (MET), Clemens Ladisch wrote:
>> Well, there are example programs ...
>	http://www.alsa-project.org/alsa-doc/alsa-lib-old/
[snips]

Thanks to both of you for your responses.  The old documentation was
especially helpful, and I feel I have a better, if still imperfect grasp
of things.

I've been following the miniArp.c sample code from Matthias Nagorni's
HOWTO, and trying to break it up into functions for a C++ wrapper I'm
writing.  I'm having the following issues:

  * On first run, the test program will only play the note on tick 0,
    and nothing beyond that.

  * On subsequent runs, the test program doesn't even play that.  I
    would chalk it up to poor garbage collection (I'm doing a ^C to stop
    the program), but miniArp will still run fine after that, and then
    my test program performs as the first run again.

My NoteOn code looks like this (tick is the tick at which the event
should be sent):

void wxMidiQueue::NoteOn(const wxMidiOutput& port, int key,
                         int velocity, int tick, int channel)
{     
  snd_seq_event_t ev;
  snd_seq_ev_clear(&ev);
  snd_seq_ev_set_noteon(&ev, channel, key, velocity);
  snd_seq_ev_set_source(&ev, port.GetAlsaPort());
  snd_seq_ev_set_subs(&ev);
  snd_seq_ev_schedule_tick(&ev, m_queue, 0, tick);
  snd_seq_event_output_direct(m_drv.GetAlsaSeq(), &ev);
}

It's being called like this:
  queue->NoteOn(*out, 60, 80, 0);
  queue->NoteOn(*out, 64, 80, 1);
  queue->NoteOn(*out, 67, 80, 2);

After this the queue is started.  My remaining questions are:
  * Above I use output_direct.  Should I just be using output for events
    that should occur in the future?
  * Does the output pool need to be big enough to accomodate any data my
    program will have in the queue at once?  Or just big enough to allow
    for some buffering?
  * Am I doing something absurdly wrong that you can see?  I've already
    opened the sequencer, opened a port, allocated a queue, and set the
    tempo

Sorry this email was so long.  But if you can provide any insight, I
would really appreciate it.  Thanks!

-- 
Brian


-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
