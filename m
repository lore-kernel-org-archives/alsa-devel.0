From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Re: [Jackit-devel] alsa_driver_wait -> libasound?
Date: Tue, 14 Jan 2003 20:25:18 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301142021090.541-100000@pnote.perex-int.cz>
References: <1042570555.10960.133.camel@birdie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1042570555.10960.133.camel@birdie>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Josh Haberman <joshua@haberman.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 14 Jan 2003, Josh Haberman wrote:

> On Tue, 2003-01-14 at 08:31, Jaroslav Kysela wrote:
> > I wonder why to implement this function when one can link more pcm streams
> > with "snd_pcm_link()" together? Then polling one stream is sufficient when
> > streams are hardware synchronized.
> 
> This reminds me of another question I had: can any two streams be linked
> together or do they need to be on the same device?  Is it reasonable to
> assume that linking two streams will always succeed?

There are no restrictions, except - if you don't have clock sync in 
hardware, there is no guarantee that streams will have same positions.
Also, when hardware does not allow synchronized start (paralel) then the 
start sequence is serialized (thus some streams might be started a bit 
later).

The software (application) needs to handle these situations.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
