From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Memory managment.
Date: Tue, 7 May 2002 05:18:37 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020507051837.A5750@sci.fi>
References: <3CD56D48.E0C82404@ufh.se> <s5hlmaxmx3i.wl@alsa2.suse.de> <3CD65674.3C90FC62@ufh.se> <s5hk7qhmuja.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk7qhmuja.wl@alsa2.suse.de>; from tiwai@suse.de on Mon, May 06, 2002 at 12:37:29PM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, May 06, 2002 at 12:37:29PM +0200, Takashi Iwai wrote:
> snd_seq_event_output() copies the event instance, so a temporary
> variable can be used safely in the above.

What about snd_seq_event_input()? The comments in the code suggest that it
uses snd_seq_event_create() but I don't see it. It doesn't seem to
allocate anything. Do I have to supply it with a pointer to a preallocated
event structure? If that's the case the example code in the alsa-lib/test
directory is broken. Actually it's broken in either case since
like you said snd_seq_free_event() doesn't free anything.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
