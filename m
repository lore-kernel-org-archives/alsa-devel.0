From: ki.ber.kom.uni.st <ki.ber@kom.uni.st>
Subject: scheduling midi events with pyalsa and making queue to
	loop after few bars..
Date: Thu, 18 Sep 2008 03:44:42 +0200
Message-ID: <95e4e4ce0809171844l2cddd623leac6b0585de4207d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B94B24788
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Sep 2008 03:44:44 +0200 (CEST)
Received: by hs-out-0708.google.com with SMTP id x43so2228773hsb.0
	for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2008 18:44:42 -0700 (PDT)
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

hm.. i would like to make simple example of scheduling few midi notes
to queue and alsaseq where the length of the loop will be one bar or
any number of ticks...

i'm kind of stuck :(

i got two midi notes triggered (event & event2) but don't know how to
play the queue again or in loop while notes which are already there
should be played in every repetition...

i'm trying to do that placing alsaseq.SEQ_EVENT_SETPOS_TICK at 0 (or
1) but it doesn't play the notes again...

my logic is to schedule the playhead of queue at the beginning after
some number of ticks and i assume that already queued notes will be
there.. i'm quite sure i'm wrong ;)

what would be good logic to do that?

do i need to leave queue alone and implement my own logic on top of
it? something like adding notes all along the timeline simulating the
repetition that way... i would like to know or to check what's the
tick of running queue.. do i do that scheduling alsaseq.SEQ_EVENT_ECHO
some place on the timeline? hm... lot's of questions... hope someone
would explain to me a bit of the alsaseq inner logic... i'm sorry i
couldn't find good documentation but testing the library inside
ipython....

here is how my session looks like (i connect "myPort" to Virtual Raw
Midi with a little help of qjackctl and monitor it with amidi -p
hw:2,0 -d):

from pyalsa import alsaseq

seqsen = alsaseq.Sequencer()
seqsen.create_simple_port("myPort", alsaseq.SEQ_PORT_TYPE_APPLICATION,
alsaseq.SEQ_PORT_CAP_SUBS_READ | alsaseq.SEQ_PORT_CAP_READ)

queue = seqsen.create_queue()
seqsen.start_queue(queue)
queue = seqsen.create_queue()
seqsen.start_queue(queue)
tempo, ppq = seqsen.queue_tempo(queue)

event = alsaseq.SeqEvent(alsaseq.SEQ_EVENT_PGMCHANGE)
event.queue = queue
event.time = 96
event.set_data({'control.value' : 127})
seqsen.output_event(event)

event2 = alsaseq.SeqEvent(alsaseq.SEQ_EVENT_PGMCHANGE)
event2.queue = queue
event2.time = 96*4
event2.set_data({'control.value' : 100})
seqsen.output_event(event2)

event3 = alsaseq.SeqEvent(alsaseq.SEQ_EVENT_SETPOS_TICK)
event3.queue = queue
event3.time = 96*5
event3.set_data({'queue.queue' : 1})
seqsen.output_event(event3)

seqsen.drain_output()

##  event and event2 being sent but event3 is unnoticeable to me...
