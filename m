From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: Extended API: Constructors and alloca()
Date: Fri, 21 Mar 2003 07:51:41 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18wLwB-0001c4-00@sc8-sf-list1.sourceforge.net>
References: <s5hisudq8gf.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 21 Mar 2003 12:12:48 +0100."
             <s5hisudq8gf.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: hamren@sdu.se, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> It would be a good thing if the necesary structs (snd_ctl_t, et c.)
>> were available in an unofficial include file in the library.
>
>THIS is the very question.
>so far, in the implementation of alsa-lib, we have been trying to hide
>this.  the all strucs are suppose to be opaque (except for some
>trivial cases).
>putting the struct in public (even though it's unofficial) breaks this
>policy.

i (and i hope many other ALSA users/developers) would scream very
loudly if we moved from this design/policy. it has been critical and
central to success in stabilizing the API from the perspective of
applications. it has worked for Xlib for a long time, it has worked
for us for a year or more, and we should not change this. making the
change proposed by lars would open us up to major binary compatibility
issues as alsa evolves.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
