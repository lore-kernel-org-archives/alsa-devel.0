From: "Aldrin Martoq" <amartoq@dcc.uchile.cl>
Subject: Re: problems howto send simple 'noteon' event with
	pyalsa...
Date: Thu, 13 Mar 2008 15:07:17 -0300
Message-ID: <17eedd8a0803131107n5721d467r3a73e0d3d688e0c8@mail.gmail.com>
References: <95e4e4ce0803130458g7339fd65g7342f8a934db4a52@mail.gmail.com>
	<Pine.LNX.4.61.0803131333560.7942@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E09224482
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 19:07:20 +0100 (CET)
Received: by gv-out-0910.google.com with SMTP id c6so935970gvd.24
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 11:07:19 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.0803131333560.7942@tm8103.perex-int.cz>
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, "ki.ber.kom.uni.st" <ki.ber@kom.uni.st>
List-Id: alsa-devel@alsa-project.org

Hello,

On Thu, Mar 13, 2008 at 9:34 AM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Thu, 13 Mar 2008, ki.ber.kom.uni.st wrote:
>  > i was happy user of PySeq [1] and it was easy to send directly
>  > 'noteon' event.. more or less in python interactoin session:
>  > import pyseq
>  >
>  > seq = pyseq.PySeq()
>  > seq.createOutPort()
>  > event = snd_seq_event()
>  > event.setSource(0)
>  > event.setSubscribers()
>  > event.setNoteOn(ch, note, velocity)
>  > event.sendAsIs(seq)
>  >
>  > it seems that pyalsa will go along alsa development so i tried pyalsa.. but....

You can send NOTEON events without a queue, but you cannot send NOTE
events without a queue. (subtle difference: note_ON_)

The following code will work; 14:0 is "midi-through" in my system... I
run aseqdump -p 14:0 on another window:

seq = alsaseq.Sequencer()
event = alsaseq.SeqEvent(alsaseq.SEQ_EVENT_NOTEON)
event.set_data({'note.note' : 0x40, 'note.velocity' : 64})
event.dest = (14, 0)
seq.output_event(event)
seq.drain_output()


>  > i tried this:
>  > from pyalsa import alsaseq
>  > seq = alsaseq.Sequencer()
>  > seq.create_simple_port("myPort", alsaseq.SEQ_PORT_TYPE_APPLICATION,
>  > alsaseq.SEQ_PORT_CAP_SUBS_READ | alsaseq.SEQ_PORT_CAP_READ |
>  > alsaseq.SEQ_PORT_CAP_WRITE | alsaseq.SEQ_PORT_CAP_SUBS_WRITE)

AFAIK, You don't need a port if you are sending events directly.
Now, if you subscribe and connect ports, you don't need to assign them
into the event, because a new event is created with
snd_seq_ev_set_subs called..

You can check this and other stuff with the following code:

-ini-------------
def _find_attributes(typelist):
        l = []
        for t in typelist:
                d = t.__dict__.items()
                for k, v in d:
                        v = "%s" % v
                        if v.startswith("<attribute"):
                                l.append(k)
        l.sort()
        return l

def dump_event(port, name = 'seqevent'):
        print "Dumping Event ---------->"
        print "%s" % port
        l = _find_attributes([alsaseq.SeqEvent])
        for k in l:
                print "%-30.30s %s" % (name + "." + k, port.__getattribute__(k))
        return

seq = alsaseq.Sequencer()
event = alsaseq.SeqEvent(alsaseq.SEQ_EVENT_NOTEON)
event.set_data({'note.note' : 0x40, 'note.velocity' : 64})
dump_event(event)
seq.output_event(event)
seq.drain_output()
-------------end--


>  > event = alsaseq.SeqEvent(alsaseq.SEQ_EVENT_NOTE)
>  > event.set_data({'note.note' : 0x40, 'note.velocity' : 127,
>  > 'note.duration' : 1, 'note.off_velocity' : 0})

note.duration and note.off_velocity make sense only for
SEQ_EVENT_NOTE, but you need a queue... so, use SEQ_EVENT_NOTEON and
SEQ_EVENT_NOTEOFF instead....

I'm planning to move event.set_data() to attributes, like
event.note_note, event.note_velocity ... Tell me what you think!

>  > event.dest = (20, 0)
>  > seq.output_event(event)
>  > seq.drain_output()
>  >
>  > after drain it says:
>  > "SequencerError: Failed to drain output: Invalid argument"

Well, that's what asoundlib says... weird, don't you think?

Alsa hackers: This is a good proof that alsa-lib message errors
really, really sucks... Is there any chance to change this? I mean, if
I volunteer to improve this could be accepted? Any hints for doing
this?

[...]
>  > any ideas? do i have to use queues to be able to send 'noteon'.. for
>  > my purposes it seems to me that that's overkill....

Remember: python is far away of real-time so if you get weirds timings
you may reconsider using a queue anyway!


HTH,

-- 
Aldrin Martoq
http://aldrinvideopodcast.podshow.com/
