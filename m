From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Plan 9 /dev multiplexing (was: JACK 0.71.1 released)
Date: Sat, 10 May 2003 17:41:39 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19Ec1z-0005o0-00@sc8-sf-list1.sourceforge.net>
References: <001301c3171f$049fea80$ac1f830a@ICO>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 10 May 2003 14:07:28 EDT."
             <001301c3171f$049fea80$ac1f830a@ICO>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hey guys, the other day I got a chance to speak to a buddy of mine who
>is a cpu/OS guru and he was telling me how the author of original Unix
>(whose name I can't recall) made this "new" OS called Plan 9 (currently
>owned by Bell labs) that essentially fixes all of the shortcomings in

as mentioned, Plan 9 is at least a decade old at this point. the name
is rob pike, btw. plan 9 has some really cool features, but its hard
to see any of them making it so much better than linux that its worth
switching. i think that every core member of the linux kernel team is
aware of plan 9's design, and a few of them have almost certainly
tried it out.

>Unix, one of them being multiplexing the /dev stuff on the kernel level.
>This would mean that driver implementation API would not need to do
>software down-mixing when all that would be done in kernel-space. Seems

welcome to ALSA. the kernel side of ALSA doesn't do this either. its
all in user space. the kernel side offers very simple services to user
space, nothing more. providing complex services in the kernel is a bad
idea, and worse, if it ever involves floating point math, imposes
extra load on the kernel. currently, the kernel doesn't save/restore
FP state for itself, because FP operations are not allowed in the
kernel. saving FP state is expensive.

>that the preliminary results are rather impressive (but probably not
>sample accurate, hence we would still need jack for pro stuff). Yet, I

the new dmix ALSA plugin is very impressive and very clever. it
doesn't provide sample sync, its true, but its the answer to what most
consumer apps want. try it. you'll like it.

--p



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
