From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB fix (debian bug#100041)
Date: Wed, 12 Mar 2003 12:10:07 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0303121137220.16181-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.44.0303121049030.1619-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.44.0303121049030.1619-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Pedro Lopez-Cabanillas <plcl@telefonica.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Wed, 12 Mar 2003, Clemens Ladisch wrote:
> > Neither OSS nor ALSA sequencer ports can change parameters of the
> > underlying rawmidi port. Maybe there should be a module parameter for
> > this.
>
> Yes, if this behaviour causes troubles, we can specify the reset behaviour
> via a module parameter.
>
> Perhaps, the best solution is to implement a control element which will
> define the "reset" byte sequence when the rawmidi device is closed. Then
> users might configure things themselves.

Yes. 0xFE, 0xFF, GM/GS/XG reset, or nothing may be usful in specific
situations.

> Opinions?

Seems to be a Good Thing(TM).


Regards,
Clemens




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
