From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB audio devices
Date: Wed, 10 Mar 2004 10:41:27 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403101035310.8680-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0403101006120.28347@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.58.0403101006120.28347@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

> On Wed, 10 Mar 2004, Clemens Ladisch wrote:
>
> > Conceptually, USB devices have variable-sized periods.  The question
> > is whether we actually want to allow this in the API.  Probably not.
>
> What this does mean? I though that the period size is specified with time
> (1ms) for USB, isn't it? I think that we can describe this constraint
> with the refine algorithm.

One USB frame is 1 ms, but the number of samples per USB frame varies
if the sample rate isn't an integer multiple of 1000.  E.g., at
44100 Hz, each USB frame has 44 samples, with one out of ten having
45.

I don't know what happens when we constrain the period size to 1 ms,
which would be exactly 44.1 frames.  The period size in frames gets
rounded to an integer, doesn't it?


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
