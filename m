From: Mark Knecht <markknecht@gmail.com>
Subject: Re: USB audio - 10x too fast on 2.6.14
Date: Thu, 3 Nov 2005 11:02:53 -0800
Message-ID: <5bdc1c8b0511031102n128ce6can6af48df2e25d52c5@mail.gmail.com>
References: <5bdc1c8b0511021804m250a54dbx5b88e21acd4b74a6@mail.gmail.com>
	 <1131013713.4369e6518359d@webmail.uni-halle.de>
	 <1131044040.13952.5.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1131044040.13952.5.camel@mindpipe>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 11/3/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Thu, 2005-11-03 at 11:28 +0100, Clemens Ladisch wrote:
> > Mark Knecht wrote:
> > > However, when we tried our USB->TosLink device a 3:30 minute song pla=
ys in
> > > about 25 seconds.
> >
> > A bug in the snd-usb-audio driver.  Using another playback program (usi=
ng ALSA
> > instead of OSS) may work instead.  This has been fixed in CVS.
>
> Where's the patch?  This needs to be submitted for the stable kernel.
>
> Lee

If there's a 2.6.14+ test kernel one of these days please let me know
and I'll test it immediately. In the meantime I've gone back to
2.6.13-gentoo-r3-ht which works fine for me.

Cheers,
Mark


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
