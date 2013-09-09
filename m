From: Ember Autumn Rose Leona <emberleona@gmail.com>
Subject: Re: Help with editing the Raw Midi data with ALSA?
Date: Sun, 8 Sep 2013 18:24:26 -0700
Message-ID: <CAAVa-AFHigDo2CCZ9+8zrUdVF=EG+FN3sqtMOSH+qCREqTVO2w@mail.gmail.com>
References: <CAAVa-AFWJwBAYK2ix643bEVVraG0FkaEO-ovhfrYPZSSU53vdQ@mail.gmail.com>
 <522AF97E.6080105@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f178.google.com (mail-vc0-f178.google.com
 [209.85.220.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 72E05264F26
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 03:24:27 +0200 (CEST)
Received: by mail-vc0-f178.google.com with SMTP id ha12so3693072vcb.9
 for <alsa-devel@alsa-project.org>; Sun, 08 Sep 2013 18:24:26 -0700 (PDT)
In-Reply-To: <522AF97E.6080105@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thank you Clemens!

You pretty much wrote it all for me, I made a minor edit so that it
flips the keyboard on D5.
I know that this should work... but I am getting compiler errors with
undefined reference...

here's the error: http://pastebin.com/41WAvjCs

I even looked into the ld in /usr/bin/ which was a link to ld.bfd I
redirected it to ld.gold... I still get errors. I already have the
library libasound2-dev installed  and I even compiled from source
cmake . then make  and put the all the /include/ files in the program
directory....

It must be something I am doing wrong... if you can help that would be nice.
PS>$ pkg-config --libs alsa
-lasound

This is what I changed.

if (snd_seq_ev_is_note_type(ev))
                    if (ev->data.note.note < 125)
ev->data.note.note = (((127 - (ev->data.note.note & 127)) - 3) & 127)

I might end up using an array I think there will be less latency...
The ANDs make sure that it is within the byte range  0-127 before and
after... -3 is the offset for D5 -27 for D4 I am going to put these in
an array. I want to allow the user to choose what note to mirror on.

I have tried -lasound I even put the entire alsa lib in the project
root and changed the .c file to include "asoundlib.h"
include "seqmid.h"  //this is where most those macros and functions are

Well, I really tried b4 bugging you again...

Thanks for you help thus far,
Ember


On 9/7/13, Clemens Ladisch <clemens@ladisch.de> wrote:
> Ember Autumn Rose Leona wrote:
>> I just joined the mailing list on after being referred to it.
>
> Please note that, regardless of what others might say, this is the list
> where you are most likely to get an answer.
>
>> Is it possible for me to edit the Raw Midi data with ALSA...
>
> It would be possible to write your own tool that does the editing.
>
>> What I want to do is edit the Midi Messages, re-mapping the notes. I
>> simply
>> want to flip the progression of the keys on a midi piano from high
>> notes to low notes.
>
> See the example program below.  It modifies MIDI messages received at
> its input ports and re-sends them from its output port.  Insert it into
> your routing like this:
>
>   Keyboard  -->  KeyFlip  -->  Synth
>
> (Use aconnect to make the connections.)
>
>
> Regards,
> Clemens
>
> --8<---------------------------------------------------------------->8--
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <alsa/asoundlib.h>
>
> #define CHECK(fn) check((fn), #fn)
> static void check(int err, const char *fn)
> {
> 	if (err < 0) {
> 		fprintf(stderr, "%s failed: %s\n", fn, snd_strerror(err));
> 		exit(EXIT_FAILURE);
> 	}
> }
>
> int main(void)
> {
> 	snd_seq_t *seq;
>
> 	/* create I/O ports */
> 	CHECK(snd_seq_open(&seq, "default", SND_SEQ_OPEN_DUPLEX, 0));
> 	CHECK(snd_seq_set_client_name(seq, "Keyboard Flipper"));
> 	CHECK(snd_seq_create_simple_port(seq, "KeyFlip",
> 					 SND_SEQ_PORT_CAP_READ |
> 					 SND_SEQ_PORT_CAP_WRITE |
> 					 SND_SEQ_PORT_CAP_DUPLEX |
> 					 SND_SEQ_PORT_CAP_SUBS_READ |
> 					 SND_SEQ_PORT_CAP_SUBS_WRITE,
> 					 SND_SEQ_PORT_TYPE_MIDI_GENERIC |
> 					 SND_SEQ_PORT_TYPE_SOFTWARE |
> 					 SND_SEQ_PORT_TYPE_APPLICATION));
>
> 	for (;;) {
> 		snd_seq_event_t *ev;
> 		int err;
>
> 		/* read one event from the input port */
> 		err = snd_seq_event_input(seq, &ev);
> 		if (err == -ENOSPC)
> 			continue;
> 		CHECK(err);
>
> 		/* modify the note value */
> 		if (snd_seq_ev_is_note_type(ev))
> 			ev->data.note.note = 127 - (ev->data.note.note & 127);
>
> 		/* send the event from the output port */
> 		snd_seq_ev_set_subs(ev);
> 		snd_seq_ev_set_source(ev, 0);
> 		snd_seq_ev_set_direct(ev);
> 		CHECK(snd_seq_event_output_direct(seq, ev));
> 	}
> }
>
