From: Martin Langer <martin-langer@gmx.de>
Subject: Re: problems with rme digi96/8
Date: Thu, 5 Jun 2003 21:03:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030605190335.GB493@tuba.home>
References: <1054808252.7022.8.camel@duff>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1054808252.7022.8.camel@duff>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gorm David Lai <lai@daimi.au.dk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 05, 2003 at 12:17:32PM +0200, Gorm David Lai wrote:
> Hi, I really hope somebody can help me.
> 
> We have recently bought a RME Digi96/8 card. This connects via adat to a
> mixing console.
> I have implemented the code in the ALSA 0.9.0 HOWTO for playback. This
> works fine on a sound blaster card in stereo.
> However with the digi96/8 card the mixing console does not get any
> input. The mixing console syncs fine on the adat connection, it just
> does not seem to get any sound input.
> 
> Any help, would be greatly appreciated as I am getting desperate.
> 

ADAT isn't well tested, so everything is possible. But a look to wiki page
on http://opensrc.org/alsa/index.php?page=rme96 looks not so bad.

Are you using plughw:0,1 or hw:0,1? What's your alsa version? 


martin


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
