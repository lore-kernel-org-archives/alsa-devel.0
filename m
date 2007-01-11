From: =?ISO-8859-1?Q?Ingo_M=FCller?= <alsa@ingomueller.net>
Subject: Re: Ideas for the softvol plugin
Date: Thu, 11 Jan 2007 23:45:41 +0100
Message-ID: <45A6BE15.4010101@ingomueller.net>
References: <70a871c80701092048v23fbf0d8yc40d434eab023506@mail.gmail.com>
	<70a871c80701101406y3f8293e9sd57b1d4c5ba9b166@mail.gmail.com>
	<45A64FBF.5070503@ingomueller.net>
	<20070111150555.GA17015@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070111150555.GA17015@nevyn.them.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Daniel Jacobowitz schrieb:
> On Thu, Jan 11, 2007 at 03:54:55PM +0100, Ingo M=FCller wrote:
>> 1) A mute/unmute function. I think this is the most easy job.
> =

> I've got code for this lying around somewhere, though I'm not sure
> where.  But...

Sounds great! That'd be awesome if this would find its way into the
official alsa code!

> Take a look at the "ganged volume" patch I posted to this list, at the
> beginning of the month.  In general, when the kernel master volume
> only controls the front channels, that's because it's how the card's
> control registers work; ganged volume lets you add a kernel control
> that moves things up and down in sync.  It's a bit better than using
> softvol, because you don't have to do any processing of the samples
> as they pass through.
> =

> It's to solve exactly what you're describing.

That sounds good, too! Unfortunately, I don't understand C code very
well, and nothing of kernel programming at all. I doubt whether I would
be able to apply the patch, even if I used the same module as you do
(which I don't).

On Sat, Oct 14, 2006 at 04:37:37PM -0400, Daniel Jacobowitz wrote:
> Here's an implementation of a ganged volume control. I suspect it
> could be improved with advice from a maintainer; I'm happy to revise
> it. It works in every way I've been able to test it. I suspect plenty
> of other devices could benefit from this; probably even some not AC97
> based, so maybe it ought to move elsewhere, but at least it's a start.

I do also think that this piece of code (as far as I understan it)
should be used more often or more centrally! On many sound cards, the
master volume doesn't seem to control the volume of all channels (which
it should definitely).

Greetings, Ingo


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
