From: "Ivica Bukvic" <ico@fuse.net>
Subject: Plan 9 /dev multiplexing (was: JACK 0.71.1 released)
Date: Sat, 10 May 2003 14:07:28 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <001301c3171f$049fea80$ac1f830a@ICO>
References: <1052577007.17837.1.camel@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1052577007.17837.1.camel@cthulhu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-audio-dev@music.columbia.edu
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hey guys, the other day I got a chance to speak to a buddy of mine who
is a cpu/OS guru and he was telling me how the author of original Unix
(whose name I can't recall) made this "new" OS called Plan 9 (currently
owned by Bell labs) that essentially fixes all of the shortcomings in
Unix, one of them being multiplexing the /dev stuff on the kernel level.
This would mean that driver implementation API would not need to do
software down-mixing when all that would be done in kernel-space. Seems
that the preliminary results are rather impressive (but probably not
sample accurate, hence we would still need jack for pro stuff). Yet, I
am wondering whether Kernel people should know about this and whether
such overhaul would be doable in the 2.6 or later revisions of Linux
kernel.

Any thoughts?

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico

> -----Original Message-----
> From: linux-audio-dev-admin@music.columbia.edu
[mailto:linux-audio-dev-
> admin@music.columbia.edu] On Behalf Of Taybin
> Sent: Saturday, May 10, 2003 10:30 AM
> To: jackit-devel; laa; lad; lau
> Subject: [linux-audio-dev] JACK 0.71.1 released
> 
>                               JACK 0.71.1
> 
> JACK is a low-latency audio server, written primarily for the
GNU/Linux
> operating system. It can connect a number of different applications to
> an audio device, as well as allowing them to share audio between
> themselves. Its clients can run in their own processes (ie. as normal
> applications), or can they can run within the JACK server (ie. as a
> "plugin").
> 
> JACK is different from other audio server efforts in that it has been
> designed from the ground up to be suitable for professional audio
work.
> This means that it focuses on two key areas: synchronous execution of
> all clients, and low latency operation.
> 
> **CHANGES**
> 
>  * fltk macros/detection from bob ham
>  * tmpdir configure-time patch from jesse chappell
>  * socket error handling change (with additional graph sort!)
>          from stephane letz
>  * xrun init patch from gunter geiger
> 
> Taybin Rutkin




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
