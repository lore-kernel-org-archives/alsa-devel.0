From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: SPDIF and cs46xx ?
Date: Sun, 30 Mar 2003 20:42:58 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030330184258.GB9474@ulima.unil.ch>
References: <14a4584ea6cb4a6894e70d84e717abc6.peter599@gotnet.net> <3E75075E.7030401@cucumelo.org> <20030329142035.GA16590@ulima.unil.ch> <3E864424.6060707@cucumelo.org> <20030330144633.GA9474@ulima.unil.ch> <3E874714.5020302@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3E874714.5020302@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net, werner@suse.de
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 30, 2003 at 09:35:48PM +0200, Benny Sjostrand wrote:

> About the period sizes there'e nothing we can do in the driver, as this=
 is a
> HW limitation.
> (However it's possible to implement Scatter/Gather DMA support for the
> cs46xx driver, then maybe there's more posibilies to variate the period
> size, but that's not going to happen in a near future ...)

OK, I hope Dr. Werner Fink could work with this limitation ;-)

> I think that the problem with the current cs46xx driver could be the=20
> status bits
> in the IEC958 stream that is not set correctly.  Some receivers seems t=
o=20
> ignore
> the status bits and detects the format looking into the stream instead,=
=20
> other receivers
> may look into the status bits to detect if it's PCM audio, or digital d=
ata.
> So it's posible that AC3 DTS, etc work's OK with thoose receivers that=20
> just ignores
> the content of the status bits, which I think is the case of my Harmon=20
> Kardoon
> receiver.

Great, even with my bad english and I was understood !!!
Is there any hope to fix this issue?

Thank you very much,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
