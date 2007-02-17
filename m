From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: why would i *not* be able to update a register in
	ac97#0-0+regs when it's read write?
Date: Fri, 16 Feb 2007 21:01:55 -0500
Message-ID: <75b66ecd0702161801l3e1492c3j37e001bbf57eaac9@mail.gmail.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF896@sea-exch-01.na.corp.dmxmusic.com>
	<75b66ecd0702161724ncd340a8o1feea138fa98963c@mail.gmail.com>
	<F8FB97052F1BEF409F7842E960E49B5AAAF897@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <F8FB97052F1BEF409F7842E960E49B5AAAF897@sea-exch-01.na.corp.dmxmusic.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: John Utz <John.Utz@dmxmusic.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 2/16/07, John Utz <John.Utz@dmxmusic.com> wrote:
>  i think the configure help should be changed; what would you conclude from
> this list:
>
>   --with-debug=level      give the debug level (none,basic,full,detect)
>
>  to me, this certainly implies detect>full>basic>none
>

Agreed.

>
>  >  i believe that i want to set these to the 01 setting so that i can get
>  > surround out from Universal Audio Jacks on our MSI motherboard samples
>  >
>  >  am i barking up the wrong tree here?
>
>  Not sure - can you state the exact problem you are trying to solve?
>
>
>  there are two issues:
>
>  1. attempting to write to registers that are documented to be read-write
> doesnt
>     result in a change of value; how do i debug this?
>

The mode in /proc is misleading but the documentation in
Documentation/ALSA-Configuration.txt is correct.


>  2. i have an msi motherboard with a via8237Rplus and a vt1618 8ch codec. it
> has only
>     three plugs on the back that default to a stereo out, line in and mic
> in.
>
>     they are supposed to be 'Universal Audio Jacks' and thus reconfigurable
> in the manner
>     mentioned in the documentation that i listed previously - i wont really
> know if i have this
>     write until i get the write to work
>

How do you know that surround out from this device isn't already supported?

Does:

speaker-test -c 6 -Dsurround51

produce output on all speakers?

What is the output of "amixer"?

Lee

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
