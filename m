From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: dolby digital output
Date: Sun, 17 Feb 2002 18:44:10 -0000
Message-ID: <NGBBLNODKDFPBFMBBFAFOEAECBAA.James@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <1013970073.2394.17.camel@samoyed.wuff.dhs.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Hod McWuff <hod@wuff.dhs.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Hod McWuff [mailto:hod@wuff.dhs.org]
> Sent: 17 February 2002 18:21
> To: James Courtier-Dutton
> Subject: RE: [Alsa-devel] dolby digital output
>
>
>
> So, the upshot is that thanks to the AC3 latency spec, even with a
> lightning-fast encoder, it wouldn't work.
>
> >
> > I think it would be best for your application to do the mixing.
> >
>
> I think you may be right... but that still doesn't solve the additional
> latency, and digital output is still (unhappily) limited to two channels
> unless you're playing a canned stream, such as a dvd.
>
> Any other ideas on how to deal with that, or would an extension to
> S/PDIF be required?
>
I think some high speed S/PDIF is available which can do 8 Channel 96Khz 24
bit audio but very few PC sound cards can do that.

I would have preferred everything to be converted to packet technologies,
and then we could link all consumer equipment together with Ethernet cables!
Circuit based technologies are quite complicated because one has to worry
about clocking and synchronisation all the time.
With packet, each packet would just have a small header, with Stream ID,
duration of packet, Packet number, with maybe a timestamp if one needs to
synchronise two or more different streams together. Also circuit based
technologies have no error correction.

A simple 100 Megs Full duplex point to point Ethernet cable can handle just
about anything S/PDIF, USB, SCSI, IDE can throw at it.
Maybe that is why there is an IP version of SCSI now.

Cheers
James


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
