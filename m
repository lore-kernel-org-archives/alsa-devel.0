From: Mark Knecht <markknecht@attbi.com>
Subject: Re: amixer question - numid=2
Date: 24 Jan 2003 04:26:32 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1043382393.1198.7.camel@Godzilla>
References: <1042973979.1448.43.camel@Godzilla>
	<s5hof66yf2b.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hof66yf2b.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Thanks!

On Fri, 2003-01-24 at 11:15, Takashi Iwai wrote:
> At 19 Jan 2003 10:59:39 +0000,
> Mark Knecht wrote:
> > 
> > Hi,
> >    On my HDSP 9652 system executing the command 
> > 
> > amixer controls
> > 
> > yields a list that appears to be 166 items long, starting with numid=1
> > and ending with numid=166. However, closer study shows numid=2 seems to
> > be missing.
> > 
> > Is this an issue with amixer or my card? What function might normally be
> > associated with numid=2?
> 
> don't worry, no bug:
> 
> it's not a mixer control but a control for a PCM stream.
> that's why amixer doesn't show this element.
> 
> 
> ciao,
> 
> Takashi




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
