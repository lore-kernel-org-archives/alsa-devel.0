From: "Ronald S. Bultje" <R.S.Bultje@students.uu.nl>
Subject: Re: mixer device
Date: Fri, 14 May 2004 10:22:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1084522933.28725.9.camel@shrek.bitfreak.net>
References: <Pine.HPX.4.33n.0405121735410.26780-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0405121735410.26780-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-05-12 at 17:40, Clemens Ladisch wrote:
> Ronald S. Bultje wrote:
> > for a given alsa device ("default", "dmix", "plughw:N", "hw:N,M",
> > "dspN", etc.), how do I automatically obtain the right device to use as
> > a audio mixer with that device?
> 
> Depends on your definition of "right device".  In the general case
> this isn't possible because many cards don't have any mixer controls,
> or don't have the controls you want to use.  Or the pcm device uses
> several cards, or none.
> 
> What do you want to do with the mixer?

Change the volume, as hinted by others.

So, given your .asoundrc hint, is it possible for me to get the
cardnumber (and thereby the hw:N entry) for a given non-hw device (e.g.
dspN, hw:N,M, dmix, ...)? Either via libalsa or by manually parsing the
asoundrc or whatever interface is provided to do that for me? This
should be possible for at least plughw:N and hw:N,M card entries (well,
that's simple, I can just parse the string, but I'm looking for
something inside libalsa).

Ronald


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
