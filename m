From: Mark Knecht <markknecht@attbi.com>
Subject: Re: Re: HDSP 9652 MIDI - A timing disaster?
Date: 14 Jan 2003 05:16:05 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1042521366.1245.5.camel@Godzilla>
References: <Pine.HPX.4.33n.0301130954070.4019-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0301130954070.4019-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-List <linux-audio-user@music.columbia.edu>, Alsa-Devel <alsa-devel@lists.sourceforge.net>, Paul Davis <paul@linuxaudiosystems.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-01-13 at 09:04, Clemens Ladisch wrote:
> Mark Knecht wrote:
> >    I recently purchased an RME HDSP 9652 card. The card is working fine
> > for audio, but the MIDI interface is a timing disaster. The interface
> > works, but won't keep time. A 2 minute song is Rosegarden takes abut
> > 2:45 to play every time. You can hear how the HDSP isn't delivering
> > closely spaced MIDI events together, but is sort of smearing them out.
> 
> The hdsp driver doesn't send more than one MIDI byte per timer tick.
> IMHO it should be modified to send in a loop until the FIFO is full
> (however, I don't know if the HDSP has a FIFO at all). And it should start
> sending in output_trigger() instead of delaying it to the next timer tick.
> 
Clemens,
   Thanks for the response. One comment I forgot to make in the first
post. This MIDI interface works fine under Windows, so whatever causes
the problem is purely a Alsa MIDI issue. If we can figure it out, then
we can fix it.

   I agree that it sounds like this sort of one note per timer tick.
When the interface is supposed to send a chord, it sends what sounds
like an arpegiated chord. It's all smeared out.

   Is there some example code I could look at to understand implementing
a FIFO? However, if there is a FIFO Full indication, doesn't we need to
know _how_ it's indicated? I would assume it's different for all cards?
(Bus possibly similar for cards from the same manufacturer? 

   Also, this is the HDSP 9652, which is a single PCI card. Is this
problem showing up for the DigiFace/MultiFace type cards?

Thanks,
Mark



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
