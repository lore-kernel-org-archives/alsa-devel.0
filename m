From: Ryan Pavlik <rpav@mephle.com>
Subject: Re: Simple alsa sequencer question
Date: Tue, 28 Oct 2003 12:52:21 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031028125221.38f31c82.rpav@mephle.com>
References: <E1AEWlF-0005EN-00@sc8-sf-list2.sourceforge.net>
	<200310282020.40649.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200310282020.40649.plcl@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 28 Oct 2003 20:20:40 +0100
Pedro Lopez-Cabanillas <plcl@telefonica.net> wrote:

> El Martes, 28 de Octubre de 2003 17:30, Ryan Pavlik escribi=F3:
> > Clemens Ladisch <clemens@ladisch.de> wrote:
> > > The event timestamps are set yo the current time of the queue. Your
> > > queue isn't running, so its current time is zero.
> > >
> > > Call snd_seq_start_queue(seq, queue, NULL) (and snd_seq_drain_output).
> >
> > Hmm, nope... I've tried this in various combinations along with
> > tempo-setting and position-setting events sent to the queue, with no
> > avail.  I'm still getting 0 0.
>=20
> Try:
> 	snd_seq_open(&seq, "default", SND_SEQ_OPEN_DUPLEX, 0);
>=20
> Opening with SND_SEQ_OPEN_INPUT, any call to snd_seq_start_queue will ret=
urn a=20
> -22 error code.

YES!  Thank you! :-)  Now, why didn't I try that.  Both of these
combined did the trick.

Anyhow, thanks a ton, solved a very nagging problem.  My ruby-alsa
module should soon have a useful sequencer. ;-)

ttyl,

--=20
Ryan Pavlik <rpav@mephle.com>

"Maybe it's the unfocused, blind, murderous rage." - 8BT


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
