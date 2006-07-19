From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: default device setting doesn't work
Date: Wed, 19 Jul 2006 14:43:25 +0200
Message-ID: <20060719124325.GC24800@turing.informatik.uni-halle.de>
References: <715d90900607172251q7a94ac0bj752ae562da3f354d@mail.gmail.com>
	<20060718071405.GB11917@turing.informatik.uni-halle.de>
	<715d90900607180020g3bf04664g8d48308ec93183c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <715d90900607180020g3bf04664g8d48308ec93183c4@mail.gmail.com>
Content-disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: boku <boku0712@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

boku wrote:
> On 7/18/06, Clemens Ladisch <clemens@ladisch.de> wrote:
> >boku wrote:
> >>     I met a problem that it doesn't work while I use the defaults
> >> device such as
> >>          aplay test.wav
> >
> >What do you mean with "doesn't work"?  No sound?  Noise?  Some error
> >message?  A crash?  Green demons coming out of your speakers?
> >
> >What is the output of "aplay -v test.wav"?
> 
> Hi, it reports errors from alsa-lib's snd_pcm_open_noupdate() in pcm.c.

Thank you for your detailed error description.

My crystal ball tells me that the error output by "aplay -v" is
"Error: snd_pcm_open_noupdate(): Green demons detected".

This means that you forgot to sacrifice a virgin chicken over your
keyboard.

(In case my crystal ball was wrong, I cannot help you unless you show me
the error message.  And you might tell what sound card you use; some
devices aren't chicken compatible.)


SCNR
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
