From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Latest CVS ALSA: XMMS 1.2.10 now crashes after running aplay
Date: Tue, 1 Feb 2005 11:18:14 +0000 (GMT)
Message-ID: <20050201111814.96858.qmail@web52909.mail.yahoo.com>
References: <m27jls8uea.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <m27jls8uea.fsf@vador.mandrakesoft.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Thierry Vignaud <tvignaud@mandrakesoft.com>
wrote:=20
> Chris Rankin <rankincj@yahoo.com> writes:
>=20
> > I have just upgraded my alsa drivers, library and
> utilities to the
> > latest CVS version, and have just discovered that
> xmms 1.2.10 now
> > crashes whenever I play a WAV file using aplay. I
> was playing a CD
> > through xmms at the time.
>=20
> Takashi Iwai has wrote a patch for xmms that works
> smoothly, you may
> want to port it to current xmms CVS

I have raised a bug in xmms's bugzilla. If you forward
this patch to me then I can append it to the bug
report. (However, from the gdb output, it looked as if
alsa-lib was dereferencing NULL mixer pointers...??)

Cheers,
Chris



=09
=09
	=09
___________________________________________________________=20
ALL-NEW Yahoo! Messenger - all new features - even more fun! http://uk.me=
ssenger.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
