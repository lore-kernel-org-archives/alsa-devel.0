From: ki.ber.kom.uni.st <ki.ber@kom.uni.st>
Subject: problems howto send simple 'noteon' event with
	pyalsa...
Date: Thu, 13 Mar 2008 12:58:06 +0100
Message-ID: <95e4e4ce0803130458g7339fd65g7342f8a934db4a52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EE6510390E
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 12:58:08 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so1057200ana.80
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 04:58:06 -0700 (PDT)
Content-Disposition: inline
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

e,
i was happy user of PySeq [1] and it was easy to send directly
'noteon' event.. more or less in python interactoin session:
import pyseq

seq = pyseq.PySeq()
seq.createOutPort()
event = snd_seq_event()
event.setSource(0)
event.setSubscribers()
event.setNoteOn(ch, note, velocity)
event.sendAsIs(seq)

it seems that pyalsa will go along alsa development so i tried pyalsa.. but....

i tried this:

from pyalsa import alsaseq

seq = alsaseq.Sequencer()
seq.create_simple_port("myPort", alsaseq.SEQ_PORT_TYPE_APPLICATION,
alsaseq.SEQ_PORT_CAP_SUBS_READ | alsaseq.SEQ_PORT_CAP_READ |
alsaseq.SEQ_PORT_CAP_WRITE | alsaseq.SEQ_PORT_CAP_SUBS_WRITE)

event = alsaseq.SeqEvent(alsaseq.SEQ_EVENT_NOTE)
event.set_data({'note.note' : 0x40, 'note.velocity' : 127,
'note.duration' : 1, 'note.off_velocity' : 0})
event.dest = (20, 0)
seq.output_event(event)
seq.drain_output()

after drain it says:
"SequencerError: Failed to drain output: Invalid argument"
i can connect and disconnect ports around and (20,0) is functional
port where i send events with no problems from PySeq...

any ideas? do i have to use queues to be able to send 'noteon'.. for
my purposes it seems to me that that's overkill....

thanx..

[1] http://www.sci.ccny.cuny.edu/~brinkman/software/pyseq/
