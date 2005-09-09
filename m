From: asbjs@stud.ntnu.no (Asbjørn Sæbø)
Subject: Re: Minimum period size of M-Audio Delta 44?
Date: Fri, 9 Sep 2005 16:10:31 +0200
Message-ID: <20050909141031.GA23500@stud.ntnu.no>
References: <20050909104023.GA25499@stud.ntnu.no> <Pine.HPX.4.33n.0509091535130.15023-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0509091535130.15023-100000@studcom.urz.uni-halle.de>
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

On Fri, Sep 09, 2005 at 03:48:18PM +0200, Clemens Ladisch wrote:
> Asbj=F8rn S=E6b=F8 wrote:
> > What is the minimum period size of the M-Audio Delta 44 soundcard whe=
n
> > running under ALSA?
>=20
> The snd-ice1712 driver uses a minimum period size of 80 bytes.

So the period size is given in bytes, not in frames or samples?
(Well, they are of course closely coupled.)

> > (I am thinking of bying such a card, but would prefer the
> > attainable latency to be low.)
>=20
> The ICE1712 chip uses 40 bytes per frame (ten channels with 32 bits),
> so the minimum latency at 96 kHz would be 0.02 milliseconds.

That should suffice ;-)

The Delta 44 is a four-channel device.  If the chip is capable of 10=20
channels, what happens to the other six?

Thanks!
Asbj=F8rn



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
