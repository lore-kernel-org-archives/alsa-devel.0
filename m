From: Ian Campbell <icampbell@arcom.com>
Subject: Re: correcting incorrect ac'97 codec clock
Date: Mon, 21 Feb 2005 16:05:36 +0000
Message-ID: <1109001936.3174.7.camel@icampbell-debian>
References: <Pine.HPX.4.33n.0502211624520.24184-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.HPX.4.33n.0502211624520.24184-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
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

On Mon, 2005-02-21 at 16:26 +0100, Clemens Ladisch wrote:
> Ian Campbell wrote:
> > I am working on a piece of hardware where the AC'97 codec clock was
> > erroneously set at 24MHz instead of the correct 24.5764MHz, this causes
> > the sound to come out slightly wrong, a 1000Hz sine wave is ~977Hz or
> > so.
> >
> > We'd prefer to have the kernel correct for this error rather than
> > expecting every application to do it.
> 
> bus->clock is set to the sample rate of the AC'97 bus, and is 48000 by
> default.  Setting it to 46875 after creating the bus should help.

that looks like it'll do the trick -- cheers!

Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
