From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Help with editing the Raw Midi data with ALSA?
Date: Sat, 07 Sep 2013 12:01:34 +0200
Message-ID: <522AF97E.6080105@ladisch.de>
References: <CAAVa-AFWJwBAYK2ix643bEVVraG0FkaEO-ovhfrYPZSSU53vdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id B89C12610AA
 for <alsa-devel@alsa-project.org>; Sat,  7 Sep 2013 12:02:15 +0200 (CEST)
In-Reply-To: <CAAVa-AFWJwBAYK2ix643bEVVraG0FkaEO-ovhfrYPZSSU53vdQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ember Autumn Rose Leona <emberleona@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ember Autumn Rose Leona wrote:
> I just joined the mailing list on after being referred to it.

Please note that, regardless of what others might say, this is the list
where you are most likely to get an answer.

> Is it possible for me to edit the Raw Midi data with ALSA...

It would be possible to write your own tool that does the editing.

> What I want to do is edit the Midi Messages, re-mapping the notes. I simply
> want to flip the progression of the keys on a midi piano from high
> notes to low notes.

See the example program below.  It modifies MIDI messages received at
its input ports and re-sends them from its output port.  Insert it into
your routing like this:

  Keyboard  -->  KeyFlip  -->  Synth

(Use aconnect to make the connections.)


Regards,
Clemens

--8<---------------------------------------------------------------->8--

#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>

#define CHECK(fn) check((fn), #fn)
static void check(int err, const char *fn)
{
	if (err < 0) {
		fprintf(stderr, "%s failed: %s\n", fn, snd_strerror(err));
		exit(EXIT_FAILURE);
	}
}

int main(void)
{
	snd_seq_t *seq;

	/* create I/O ports */
	CHECK(snd_seq_open(&seq, "default", SND_SEQ_OPEN_DUPLEX, 0));
	CHECK(snd_seq_set_client_name(seq, "Keyboard Flipper"));
	CHECK(snd_seq_create_simple_port(seq, "KeyFlip",
					 SND_SEQ_PORT_CAP_READ |
					 SND_SEQ_PORT_CAP_WRITE |
					 SND_SEQ_PORT_CAP_DUPLEX |
					 SND_SEQ_PORT_CAP_SUBS_READ |
					 SND_SEQ_PORT_CAP_SUBS_WRITE,
					 SND_SEQ_PORT_TYPE_MIDI_GENERIC |
					 SND_SEQ_PORT_TYPE_SOFTWARE |
					 SND_SEQ_PORT_TYPE_APPLICATION));

	for (;;) {
		snd_seq_event_t *ev;
		int err;

		/* read one event from the input port */
		err = snd_seq_event_input(seq, &ev);
		if (err == -ENOSPC)
			continue;
		CHECK(err);

		/* modify the note value */
		if (snd_seq_ev_is_note_type(ev))
			ev->data.note.note = 127 - (ev->data.note.note & 127);

		/* send the event from the output port */
		snd_seq_ev_set_subs(ev);
		snd_seq_ev_set_source(ev, 0);
		snd_seq_ev_set_direct(ev);
		CHECK(snd_seq_event_output_direct(seq, ev));
	}
}
