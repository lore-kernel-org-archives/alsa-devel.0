From: Daniel James <daniel@64studio.com>
Subject: Re: More info on hard lock-ups with MIDI on envy24, x86_64 machine
Date: Thu, 11 Aug 2005 16:43:27 +0100
Message-ID: <200508111643.27160.daniel@64studio.com>
References: <200508111525.07881.daniel@64studio.com> <1123770589.6980.1.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1123770589.6980.1.camel@mindpipe>
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
Cc: alsa-devel@lists.sourceforge.net, Free Ekanayaka <free@64studio.com>
List-Id: alsa-devel@alsa-project.org

Hi Lee,

> I guess you have tried to trigger the crash from a console as well
> as X

I've done that now. If I boot the system, switch to a console with 
ctrl-alt-f1 and run nothing but:

strace seq24

it starts to go wrong after: 

open ("/dev/snd/seq", O_RDWR)

There are a bunch of lines beginning with ioctl, then the killer blow 
is dealt by:

ioctl (3, CDROM_DEBUG or SNDRV_SEQ_IOCTL_SUBSCRIBE_PORT

(This is retyped from hand-written notes of course). The machine is 
then locked up solid - it's very reproducible too, same output every 
time. 

> and there's no Oops output? 

Nothing at all appears in the console or in /var/log/messages. Should 
I try increasing the log level or something like that?

Cheers!

Daniel


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
