From: Paul Davis <pbd@op.net>
Subject: Re: Suse 8.0 Alsa CVS compile problem (possibly snd-hammerfall-mem problem?)
Date: Sun, 19 May 2002 22:33:08 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E179cxf-000826-00@usw-sf-list1.sourceforge.net>
References: <000401c1ffa3$302e0900$ac1f830a@ico>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Sun, 19 May 2002 22:08:06 EDT."
             <000401c1ffa3$302e0900$ac1f830a@ico>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hi all, I am having an odd problem with the ALSA cvs compile on SUSE
>8.0. I am trying to do this in order to get the hdsp driver. However,
>whenever I compile the driver it stores all the modules in the
>/lib/modules/2.4.18-4GB/ folder assuming that my kernel is 2.4.18-4GB.
>However, when I open the k control center it tells me that I am using
>2.4.18-64GB-SMP kernel (which makes no sense since I am using it on a
>single processor laptop).
>
>So, when I try to install the module for the built-in soundcard (intel
>8x0), it installs fine, but when I try to modprobe snd-hammerfall-mem,
>it fails saying that it has been compiled for the 2.4.18-4GB kernel and
>that I am using 2.4.18-64GB-SMP kernel -> hence the kernel mismatch ->
>modprobe failed.
>
>Anyone has a clue as to why is this happening?

k control center is broken.

simple enough?

as nice as these tools may be, they are not to be trusted in
situations like this. as regrettable as it may be, you need to be able
to use the actual toolset that k control center "wraps". if you still
get the error, i'll rescind my judgement.

--p

ps. ico - sorry i haven't logged into your machine yet. evidence from
another poster here suggests there are issues with the cardbus code in
the linux kernel right now (not related to ALSA or the H-DSP
driver). i'll do some more work on this next week.



_______________________________________________________________
Hundreds of nodes, one monster rendering program.
Now that's a super model! Visit http://clustering.foundries.sf.net/
