From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: sequencer: handling non-registered parameter
 numbers....
Date: Mon, 16 Jun 2003 10:57:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306161055470.11284-100000@pnote.perex-int.cz>
References: <200306161041.05077.david@olofson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200306161041.05077.david@olofson.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Olofson <david@olofson.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 16 Jun 2003, David Olofson wrote:

> On Monday 16 June 2003 10.29, Jaroslav Kysela wrote:
> [...]
> > The driver code and alsa-lib does not handle nonreg and reg
> > parameters. They simply pass them like standard controllers, so the
> > four event sequence is ok. I think that we may add this piece code
> > to seq_midi_event.c.
> 
> This is weird... Wonder what's actually happening in there. :-)

If you have USB midi device, I think that we had driver versions which 
works directly with sequencer events so probably it is the case.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
