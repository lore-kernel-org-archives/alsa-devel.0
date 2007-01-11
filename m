From: Daniel Jacobowitz <drow@false.org>
Subject: Re: Ideas for the softvol plugin
Date: Thu, 11 Jan 2007 10:05:55 -0500
Message-ID: <20070111150555.GA17015@nevyn.them.org>
References: <70a871c80701092048v23fbf0d8yc40d434eab023506@mail.gmail.com>
	<70a871c80701101406y3f8293e9sd57b1d4c5ba9b166@mail.gmail.com>
	<45A64FBF.5070503@ingomueller.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <45A64FBF.5070503@ingomueller.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Ingo =?iso-8859-1?Q?M=FCller?= <alsa@ingomueller.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 11, 2007 at 03:54:55PM +0100, Ingo M=FCller wrote:
> Hi!
> =

> I have some ideas about features that could be added to the softvol
> plugin, that I want to discuss with you.
> =

> 1) A mute/unmute function. I think this is the most easy job.

I've got code for this lying around somewhere, though I'm not sure
where.  But...

> All the three suggestions aim to solve one frequent problem (it occured
> with EVERY sound card I ever had (~5) and forums are full of them): The
> volume control elements don't control the volume like they are supposed
> to. E.g. I've seen so many people whose Master control only affects the
> volume of the front channels. With the above changes, one could just
> rebuild a software based volume control system without having to worry
> whether the hardware controls are supported or not.

Take a look at the "ganged volume" patch I posted to this list, at the
beginning of the month.  In general, when the kernel master volume
only controls the front channels, that's because it's how the card's
control registers work; ganged volume lets you add a kernel control
that moves things up and down in sync.  It's a bit better than using
softvol, because you don't have to do any processing of the samples
as they pass through.

It's to solve exactly what you're describing.

You have to adjust the kernel drivers to set it up properly, but
after messing around with softvol for a while, I think that's best.
It's not hard to do.

-- =

Daniel Jacobowitz
CodeSourcery

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
