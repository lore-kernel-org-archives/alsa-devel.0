From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: How to put 16bit none audio PCM data stream into a 32bit none audio S/P-DIF transport stream?
Date: Tue, 15 Apr 2003 00:14:24 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030414221424.GC22184@ulima.unil.ch>
References: <20030410112657.GA2332@ulima.unil.ch> <3E994CCE.6020105@cucumelo.org> <20030413170501.GA2323@ulima.unil.ch> <3E99AAAB.1070101@cucumelo.org> <20030413183035.GC2323@ulima.unil.ch> <3E99F176.6080503@cucumelo.org> <20030414190615.GA22184@ulima.unil.ch> <3E9B341E.4040200@cucumelo.org> <20030414212708.GB22184@ulima.unil.ch> <3E9B3D9B.2060901@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3E9B3D9B.2060901@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net, James@superbug.demon.co.uk, werner@suse.de
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 15, 2003 at 01:00:43AM +0200, Benny Sjostrand wrote:

> Let me guess, I did not work ? Well, guess what, I got new "this time=20
> hopefully working" patch,
> so if you like to apply it to CVS and test again -;)

Yes, for sure!!!

> Could you also test with:
> AES0=3D0x40,AES1=3D0x0,AES2=3D0x41,AES3=3D0x40 (all bits wrapped)

Unfortunately, it's still not working...
If needed I could still send you all the logs :-)

> Then I got a question about the IEC958 protocoll that hopefulle someone=
=20
> on this list
> knows something about. The Left and Right validity bits, and Left, Righ=
t=20
> user
> bits, what are suposed to do ?? are they suposed to be 1 or 0 when outp=
uting
> AC3/DTS ???
>=20
> That could be a posible source of the problem, in this patch they are
> all turned off.

I am sure Dr. Werner Fink know the answer of this question ;-)

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
