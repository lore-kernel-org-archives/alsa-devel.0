From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: New PCM API extension
Date: Mon, 24 Feb 2003 20:51:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E5A77B0.117F229A@libero.it>
References: <Pine.LNX.4.44.0302241605410.1142-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.cp.tin.it (vsmtp3.tin.it [212.216.176.223])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA28417
	for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2003 20:51:25 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> On Mon, 24 Feb 2003, Abramo Bagnara wrote:
> 
> > Jaroslav Kysela wrote:
> > >
> > > I think that I have one present problem. It was not possible to write,
> > > something like the dmix plugin does (in the server/client model): Transfer
> > > data to different areas in the ring buffer. Imagine that client1 wants to
> > > write data at the end of the ring buffer (assume that server don't change
> > > the r/w pointer). Then client2 comes with some data to be placed at the
> > > start of the buffer later (server rewinds the stream position). Then
> > > hardware processed a period and client1 wants to continue (server forwards
> > > the stream position at the end of the ring buffer).
> > >
> > > I can imagine more examples where "later" samples might be wanted to be
> > > processed before "quick" ones.
> >
> > Your examples appears a little confused at my eyes, but if I've
> > understood correctly don't you think this might be solved by
> > snd_pcm_rewind done by server?
> 
> And you'll need to commit the same samples later which seems to me quite
> ineffective (extra copy + processing (if required)).

Yes, this is definitely true.

> I probably don't explain clearly my point:
> 
> We have data for time T, T+1 and T+2. The application might want to write
> data in this order: T+1, T, T+2. While we going back to T position, we can
> use snd_pcm_rewind(), but going to T+2 (without changing T+1 data)
> requires writting (or commiting) of same samples now. That's exactly what
> I want to eliminate.

Now I understand perfectly.

When in past I analyzed this I was unable to imagine a real scenario
where this might happens.

To tell you the truth now too I've some difficulties... can you help me?

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
