From: Peter Enderborg <pme@ufh.se>
Subject: Re: Rawmidi bug or missed feature?
Date: Sat, 02 Mar 2002 20:15:44 +0100
Message-ID: <3C8124E0.4FDDECD1@ufh.se>
References: <200203021858.NAA13670@renoir.op.net>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------E9092D81C8422CBA2BDEFA1B"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--------------E9092D81C8422CBA2BDEFA1B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Paul Davis wrote:

> >How do you solve the problem with sharing hardware then?
>
> I don't. I intend to wait for (and contribute too, if I can) what I
> consider the correct solution:
>
>   a) sequencer genuinely split into:
>
>           1) a router/multiplexer
>           2) a scheduler
>
>   b) sequencer moves into user space
>
> As I've said before, I don't consider the current kernel-side
> implementation of the sequencer, nor its merging of two completely
> different functions, to be in anyone's interest. I think that Frank
> was (like myself and everyone else) somewhat "blinded" by the fact
> that OSS put the sequencer in the kernel, and we did not know that it
> was possible to get similar performance in user space.

How can we get the same performance i userspace? For me it is the
processor/OS schedule that gives the limit for that, and in kernel we
get
the hardware as the limit.

>
>
> For the time being, I have hardware solutions that work for me when I
> need to do complex MIDI routing (i.e. dedicated h/w MIDI patchbays),
> and I never run multiple apps using the same port.
>
> --p

--
foo!



--------------E9092D81C8422CBA2BDEFA1B
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
Paul Davis wrote:
<blockquote TYPE=CITE>>How do you solve the problem with sharing hardware
then?
<p>I don't. I intend to wait for (and contribute too, if I can) what I
<br>consider the correct solution:
<p>&nbsp; a) sequencer genuinely split into:
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1) a router/multiplexer
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2) a scheduler
<p>&nbsp; b) sequencer moves into user space
<p>As I've said before, I don't consider the current kernel-side
<br>implementation of the sequencer, nor its merging of two completely
<br>different functions, to be in anyone's interest. I think that Frank
<br>was (like myself and everyone else) somewhat "blinded" by the fact
<br>that OSS put the sequencer in the kernel, and we did not know that
it
<br>was possible to get similar performance in user space.</blockquote>
How can we get the same performance i userspace?&nbsp;For me it is the
<br>processor/OS schedule that gives the limit for that, and in kernel
we get
<br>the hardware as the limit.
<blockquote TYPE=CITE>&nbsp;
<p>For the time being, I have hardware solutions that work for me when
I
<br>need to do complex MIDI routing (i.e. dedicated h/w MIDI patchbays),
<br>and I never run multiple apps using the same port.
<p>--p</blockquote>

<pre>--&nbsp;
foo!</pre>
&nbsp;</html>

--------------E9092D81C8422CBA2BDEFA1B--


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
