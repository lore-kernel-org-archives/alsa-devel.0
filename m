From: Matthias Koenig <list@phasorlab.de>
Subject: Re: open /dev/snd/seq failed
Date: Mon, 12 Jun 2006 15:27:50 +0200
Message-ID: <87bqsytsfd.fsf@zebra.localdomain>
References: <E1FpPt7-0001Z8-7E@localhost.localdomain>
	<1150045861.14253.119.camel@mindpipe>
	<20060611183043.GA6409@localhost.localdomain>
	<1150055462.14253.162.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: John Rigg <ad@sound-man.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell <rlrevell@joe-job.com> writes:
> On Sun, 2006-06-11 at 19:30 +0100, John Rigg wrote:
>> On Sun, Jun 11, 2006 at 01:11:00PM -0400, Lee Revell wrote:
>> > Of course it won't work, snd-seq-midi is not loaded.
>> 
>> Thanks. Stupidity caused by lack of sleep.
>
> I can't see why udev does not load this module on demand when the
> sequencer is first used.

I don't think this can be done in this way you mention, because udev 
actually creates the device nodes. 
But of course a missing sequencer module has bothered me too.

One possibility would be to add some modprobe configuration
to load snd-seq-midi when your MIDI device driver gets loaded.
E.g. If you want to load snd-seq-midi automatically with loading 
of snd-foo, add this to some file in /etc/modprobe.d/:

install snd-foo /sbin/modprobe --ignore-install snd-foo && \
{ /sbin/modprobe\ --quiet snd-seq-midi ; }

If snd-foo gets loaded, it also loads snd-seq-midi. But somehow
I don't like this solution.

Another solution could trigger the loading of snd-seq-midi by
udev at Midi device detection time -- the time /dev/snd/midiC*
get created, we could start a script, which loads snd-seq-midi.
The udev rule could be something like:
KERNEL=="midiC*", RUN+="/path/to/alsa-seq-load"

Matthias
