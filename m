From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_seq_sync_output_queue does not work
Date: Thu, 2 Dec 2004 16:41:10 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0412021625200.27068-100000@studcom.urz.uni-halle.de>
References: <20041202115801.6119.qmail@web42108.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041202115801.6119.qmail@web42108.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Bengt_M=E5nsson?= <bengt_mansson@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Bengt Månsson wrote:
> I'm trying to make an app where I need to exchange an
> 18k sysex. I use Rh9.
> I think I've worked out the receiving part, but
> sending will not work.
> I chop the big sysex into 256 byte blocks and send in
> a sequence. This seems to work fine when I run it
> stepwise in the debugger, but crash when I run it at
> full speed.

The sequencer isn't designed to handle big sysexs.  Due to the
message-based architecture it's difficult to signal back to the
sending application that the output buffer is full.

I'd guess some message couldn't be delivered and was thrown away.

Try to limit the rate of messages so that you don't exceed the MIDI
data rate.

> I think I've traced the problem down to the call to
> snd_seq_sync_output_queue. I expect that call to hang
> until the output is drained, and return a 0.
> What happens is that the call seems to return
> immediately with a 1.

The documentation is wrong, any nonnegative return value indicates
success (the current implementation always returns 1).

snd_seq_sync_output_queue waits until all events have been sent.  At
this point, it's too late to detect events than cannot be delivered at
the destination.


The documentation, if it actually existed, would tell you to use the
rawmidi API for big chunks of sysex data.  See the amidi program for
an example.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
