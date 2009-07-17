From: Christopher Arndt <chris.arndt@web.de>
Subject: pyalsa: synchronizing queue with MIDI clock events
Date: Fri, 17 Jul 2009 14:54:00 +0200
Message-ID: <4A607468.7010300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 6799F1038CF
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jul 2009 14:54:33 +0200 (CEST)
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id B7A8810643116
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jul 2009 14:53:47 +0200 (CEST)
Received: from [87.79.56.112] (helo=minimax.paddyland.lan)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277) id 1MRmwd-0001jH-00
	for alsa-devel@alsa-project.org; Fri, 17 Jul 2009 14:53:47 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi everybody,

this is my first post on this list, so please excuse me, should it not
be the right place to post this.

I started exploring programming the ALSA sequencer via the pyalsa Python
interface, i.e the alsaseq module. I wrote a small utility that reads
MIDI events from one port, filters/processes them and writes it to
another. This allows for routing by channel, note range, controller
number etc. and to filter out, replace or add MIDI events.

Now to synchronize the queue tempo to incoming MIDI clock events, to be
able implement synchronized delays or arpeggiators,  I use the method in
the code shown below. This works ok, but I notice that the measured BPM
oscillates +-1 BPM around the value displayed by the clock source (my
synth's sequencer) if I measure/average only a few (~10) ticks or do not
 round the result to an integer value.

Is this the right approach? What is a sensible number of ticks to take
into account for measurement? Should I use another reference timer than
Python's time.time() function? Is pyalsa generally suitable for this
kind of application even on older/weaker hardware (e.g. a NSLU2)?

Any comments or suggestions for improvement would be very much appreciated!


Chris


class MidiProcessor(object):

    def run(self):
        # This is simplified to only show the general logic
        while True:
            events = self.sequencer.receive_events(
                timeout=RECEIVE_TIMEOUT, maxevents=1)
            for event in events:
                if event.type == SEQ_EVENT_CLOCK:
                    self.sync_queue(event)
                else:
                    # do other MIDI processing / routing

    def sync_queue(self, event):
        """Sync queue tempo to incoming MIDI clock events."""
        # list to collect the timestamps of the last few ticks
        lt = self._last_ticks
        lt.append(time.time())
        ltlen = len(lt)
        if ltlen > 1:
            # calculate & set bpm: calculate difference between
            # the times the last few ticks were received and average
            # all results
            avg_delta = sum(
                 [y-x for x,y in zip(lt, lt[1:])]) / (ltlen-1)
            # tick length is a 24th of a quarter note
            bpm = round(60 / avg_delta / 24)
            if bpm != self.bpm:
                self.bpm = bpm
                self.sequencer.queue_tempo(self.queue,
                    tempo=int(6e7 / self.bpm), ppq=self.ppq)
        # only remember last 24 received ticks
        # (length of a quarter note)
        if ltlen > 24:
            lt.pop(0)
