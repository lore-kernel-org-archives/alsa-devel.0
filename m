From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: hdsp driver status
Date: Wed, 9 Jul 2003 06:49:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <38311.81.50.18.94.1057726192.squirrel@www.undata.org>
References: <34975.81.51.161.173.1057484037.squirrel@www.undata.org>
        <616961442ecc34a5866fa42a79757331@essej.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <616961442ecc34a5866fa42a79757331@essej.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jesse@essej.net
Cc: thomas@undata.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> I can use amixer to set up things as per usual, and jack starts
> normally.  However, I get no sound whatsoever.
>
> Loading the firmware via Windows, rebooting, and setting up the card
> identically with amixer *does* yield sound.
>
> So it looks like some critical parts for proper communication
> to the multiface need the proper firmware to work with the rev
> 0xb interface.
>
> Back to trying to load the proper rev11 firmware, it looks like
> some part of the communication protocol must have changed, or
> the multiface_firmware_rev11.dat is corrupt.  I wonder if there
> is any way to verify it.
>
> jlc

I did exactly the same test yesterday on a friend's rev 11 card. In fact
there is sound, but all messed up. I got sound on output 3 from
playback_15, on output 12 from playback_11, on output 9 from playback_3. I
could check too that strictly nothing happens with the new firmware, which
leads me to same conclusions. I'm trying to contact RME on this issue, the
problem being I do not have Paul's contact address. I sent a mail
yesterday to Matthias Carstens who's well known to all RME forum readers
and I'm waiting for an answer.

Thomas





-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
