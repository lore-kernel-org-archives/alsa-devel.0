From: Conrad Parker <conrad@vergenet.net>
Subject: Re: Removal of /proc/asound ?
Date: Tue, 20 May 2003 15:48:35 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030520054835.GA27611@vergenet.net>
References: <20030517081625.6ef24458.erikd-alsa@mega-nerd.com> <Pine.LNX.4.44.0305171343140.21997-100000@pnote.perex-int.cz> <20030518081331.7b9eca31.erikd-alsa@mega-nerd.com> <s5h4r3re0a8.wl@alsa2.suse.de> <20030519200301.1c3276f7.erikd-alsa@mega-nerd.com> <20030520044030.GD24175@vergenet.net> <20030520010904.4a389604.david@eelf.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030520010904.4a389604.david@eelf.ddts.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David B Harris <david@eelf.ddts.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, May 20, 2003 at 01:09:04AM -0400, David B Harris wrote:
> 
> The removal of /proc/asound/dev/ has been noted, and shouldn't be a
> problem :) Once we actually upload packages within which
> /proc/asound/dev/ has been removed, anyways. We haven't yet. I doubt
> erik is bitching because of this, he hasn't asked any of us about it.

coolies. afaik Erik's using ALSA CVS atm, that's why he got bitten :)

hey I was suggesting to^W^Whassling Steve K about using discover or
something to autodetect soundcards, like the xserver-xfree86 package
does (with mdetect and read-edid) to detect the video card, monitor, and
mouse, if those packages are installed. He reckons discover needs some
fixing to work with ALSA, is that something that people on alsa-devel
could work on?

How do other distros autodetect soundcards to set up ALSA?

Conrad.


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
