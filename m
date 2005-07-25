From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: maximum voices/channels
Date: Mon, 25 Jul 2005 15:08:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0507251506490.8412@tm8103.perex-int.cz>
References: <1122043610.5724.6.camel@tordera.genos.intranet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4776F18D
	for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2005 15:08:43 +0200 (MEST)
In-Reply-To: <1122043610.5724.6.camel@tordera.genos.intranet>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Cesar Hernandez <chernandez@genos.es>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 22 Jul 2005, Cesar Hernandez wrote:

> Hi.
> 
> I have a question on using alsa sequencer. I am working on a kind of
> piano program, and I want to know what is the maximum number of notes or
> sampled voices (mapped to a note) that I can play at the same time...
> I know that two or three notes may sound at the same sequencer channel,
> but I don't know what is the maximum. 
> Is there a maximum number of voices/notes per sequencer channel? Or it's
> a maximum number counting all the channels...? Or it depends on the midi
> output (timidity, midi keyboard...)

See 'snd_seq_port_info_get_midi_voices()' function.... It returns total 
number of voices allocated for the midi emulation and this value is not 
available for external synths, of course. The voice allocation is 
driver/sequencer client specific.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
