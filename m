From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Interrupt-driven (or callback/handler?), Full-duplex (simultaneous capture/playback) without using JACK
Date: Mon, 10 Nov 2003 07:26:05 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311101226.hAACQ5BA012577@oud.linuxaudiosystems.com>
References: <000601c3a779$752cfd70$264440ab@roboserv1>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 10 Nov 2003 02:57:37 PST."
             <000601c3a779$752cfd70$264440ab@roboserv1>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: rcassidy@stanford.edu
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Many thanks for the info.!

just keep in mind what jaroslav noted about signal handling
context. please don't build a serious application around this
mechanism. sooner or later, you may want to make a system call from
the handler that violates the POSIX guarantees about what can be
done. at that point, you will need to completely reimplement your
code. 

acting as my own devil's advocate, and again echoing what jaroslav
wrote, if you write real-time safe code in the handler, you won't be
making any system calls anyway; at best perhaps a write to a FIFO to
drive some other thread, and write(2) is specifically allowed.

finally, you will still need to implement the full logic of JACK's
internal loop that uses snd_pcm_avail_update() on both streams to
determine how much data space is available. JACK's is arguably a bit
more complex, since it wants to guarantee that clients process equal
size blocks every time for both playback and capture.

--p


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
