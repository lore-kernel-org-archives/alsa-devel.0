From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Rawmidi bug or missed feature?
Date: Sat, 2 Mar 2002 12:14:05 +0100 (CET)
Message-ID: <Pine.LNX.4.33.0203021211500.681-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <3C7FFE29.698B64E1@ufh.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Peter Enderborg <pme@ufh.se>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 1 Mar 2002, Peter Enderborg wrote:

> Paul Davis wrote:
> 
> > >Yes! And the device that is using running status is alsa rawmidi device.
> >
> > What makes you think that? AFAIK, the raw MIDI device code does no
> > parsing of MIDI data at all ...
> 
> Parsing? It sends raw midi on a stream. That stream is _from_ alsa seq.
> It is doing the bandwith optimize by it self. I do the parsing.

Ok, please, specify your problem in a more detailed way. At least, we need 
to know about midi paths in your applications and what sequencer clients 
are involved to help you. And yes, there could be a problem with running 
status, because our converts work with it.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
