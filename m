From: Peter Enderborg <pme@ufh.se>
Subject: Re: Rawmidi bug or missed feature?
Date: Fri, 01 Mar 2002 20:22:27 +0100
Message-ID: <3C7FD4F3.BFDA1791@ufh.se>
References: <200203011345.IAA12541@renoir.op.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:

> >I have a program that read's from a raw midi device. In midi there
> >are some simple compression.  It is assumed that if the data flow is
> >correct, and the data should be interpreted as paramaters to previus
> >command if it's not a new command. But when I open a raw midi stream
> >I can get in to the stream without having the "previus" command. Is
> >there any way to do a query or reset the stream so I can get that
> >command? If it's only one midi channel sending the same type of
> >command it will never get in to sync!
>
> raw MIDI means ***RAW*** MIDI. there is no parsing, no state, no
> history, no automatic reset. you just read and write a stream of
> bytes.
>

Yes it raw. But it's sent by the sequcenser within alsa.  So the state is
there.

This is the configuration:

Roland MCR-8->midi-device->alsa-seq->user_code->alsa-seq->raw_midi

So how far back should I need to reset? The communication roland and
alsa-seq is in sync and
my user-land code is sending snd_seq_event_t. I guess that my problem
will disapear if I turn
active-sening-on and that is what I going to try.

>
> it sounds as if you should issue a full MIDI reset sequence when you
> open the device (all notes off on every channel, reset all controllers
> to a default value, restore all programs to a known state, etc.)
>

That will not help my reading. The device is in sync with alsaseq and
there shuld not
be needed to reset the transmitter. And even if I do. The merge of midi
streams could be
smart enough to see that it is of the same type.

>
> --p

--
foo!




_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
