From: asbjs@stud.ntnu.no (Asbjørn Sæbø)
Subject: Re: Minimum period size of M-Audio Delta 44?
Date: Fri, 9 Sep 2005 16:39:59 +0200
Message-ID: <20050909143959.GA3638@stud.ntnu.no>
References: <20050909104023.GA25499@stud.ntnu.no> <Pine.HPX.4.33n.0509091535130.15023-100000@studcom.urz.uni-halle.de> <20050909141031.GA23500@stud.ntnu.no> <s5hr7byqq7u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hr7byqq7u.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 09, 2005 at 04:18:45PM +0200, Takashi Iwai wrote:

> At Fri, 9 Sep 2005 16:10:31 +0200,
> asbjs@stud.ntnu.no wrote:

> [MAudio Delta 44]=20
> > So the period size is given in bytes, not in frames or samples?
> > (Well, they are of course closely coupled.)
>=20
> It doesn't matter.
> The number of channels and the format are fixed on ice1712.


> > The Delta 44 is a four-channel device.  If the chip is capable of 10=20
> > channels, what happens to the other six?
>=20
> Two are for SPDIF.  Others are not used.


OK.  Thanks for the info.

Asbj=F8rn



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
