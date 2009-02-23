From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Timer instability
Date: Mon, 23 Feb 2009 03:42:34 +0100
Message-ID: <20090223024233.GA1901@tango.0pointer.de>
References: <20090219024611.GA7930@tango.0pointer.de>
	<s5hy6w2hqap.wl%tiwai@suse.de>
	<20090220012220.GA11526@tango.0pointer.de>
	<s5h1vtty3f8.wl%tiwai@suse.de>
	<20090220203417.GA19093@tango.0pointer.de>
	<s5hhc2nu4qy.wl%tiwai@suse.de>
	<20090222031453.GA24365@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 038241037F2
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2009 03:42:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090222031453.GA24365@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 22.02.09 04:14, Lennart Poettering (mznyfn@0pointer.de) wrote:

> I wrote this little test to track down all kinds of timer issues: it
> opens and sets up a sound device. Then it will constantly query
> _avail(), _delay() and _htstamp() in a busy loop writing a single
> sample at a time. The three values are then printed along with a
> system timestamp. The data generated like this can be opened in
> gnumeric and a nice graph be drawn.

Hmm, did some more testing with this tool on other cards:

On es1969 snd_pcm_avail() sometimes returns values like
1073728596 samples. This smells a lot like an overflow given that this
times four (i.e. the sample size in bytes) is near to 2^32.

Here's an output of this tool for an emu10k1 card:

http://www.nopaste.pl/9vi

Check out line 4417: This is when the devcie starts playback. avail
goes rightfully to 0 (i.e column 4 -- don't get confused by the line
numbers the nopaste adds here), but the playback time suddenly jumps
from 100113 us down to 702 us (column 4 which is the written sample
counter minus the delay transformed to us). This is because in
contrast to most other drivers for this one writing a sample has no
direct effect on snd_pcm_delay while the device is stopped.

Also this shows that the data from _avail() and _status() together is
not atomic: the columns for avail delay change in
different rows when we don't get scheduled often enough.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
