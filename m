From: Patrick Shirkey <kotau@firstlinux.net>
Subject: RE: question regarding latest CS4205 laptop
    soundcard driver
Date: Wed, 27 Feb 2002 01:02:16 -0800 (PST)
Message-ID: <20020227090216.82DC43ED3@sitemail.everyone.net>
Reply-To: pshirkey@boosthardware.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from omta04.mta.everyone.net (sitemail3.everyone.net [216.200.145.37])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA17575
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2002 10:02:19 +0100
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--- "Ivica Bukvic" <ico@fuse.net> wrote:
>> > *There is esd, which is outdated and simply crappy.
>> > *There is artsd, which is better, but not good enough, and again,
>the
>> > app must be made to be aware of it in order to utilize it.
>> > *There is JACK project which has a huge potential but none of its
>> > effects are again universal, nor backwards-compatible with already
>> > released software.
>> > *There is Gstreamer, but I do not honestly know enough about it.
>> 
>> Then make them better.
>
>While I would like to thank you for your prompt response, I want to
>point out that I find your above statement rather discouraging. Not
>everyone is a low-level programmer, and not everyone should be one. Yet,
>with such statement you are implying exactly that: "for one to use Linux
>for multimedia, one has to be prepared to be able to do low-level coding
>in an environment that inherently suffers from lack of documentation."
>
>Although I've provided my humble coding contributions to the Linux
>community, I am by no means an adept programmer who is capable of
>dealing with the low-level stuff such as this (needless to say I have no
>clue where to start since documentation is less than sparse). Besides, I
>would love to help any of these projects to reach their "ripeness," but
>find most of them to be focused on things that need less urgent
>attention (i.e. JACK, as I understand it, focuses on inter-app audio
>communication in a highly efficient manner, requiring app-side
>implementation for any kind of dsp resource sharing, thus meaning there
>is currently no planned backwards-compatibility, unless the older apps
>are adapted to its architecture, which in itself is a rather far-fetched
>assumption that the other application developers will be willing to
>adapt their apps to this yet-and-if-to-be-established-standard).
>

First let us establish that you want pro quality audio right?

PD will answer this better than I.

Jack is based on the callback paradigm. This is the same as nearly all the "professional" quality sound servers on other leading OS's. Unfortunately it has taken the Linux audio community slightly longer to implement this design. Now that we have it many of the developers of realtime music apps are supporting it. Jack is not a yet-and-if-to-be-established-standard. It is a yet to be finished implementation of the standard.

>Finally, why not merge the efforts of all these different
>groups/projects into one concise solution, rather than a dozen
>half-working ones?
>

And who is going to organise this effort? No seriously you are talking about Jack.

It is the combined knowledge of the LAD community who have been debating the concept for the past 5 years and are now writing the code. If you haven't joined the mailing list for jack then you should. AFAIK everyone is welcome.

>Sincerely,
>
>Ico
>
>
>
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel

--
Patrick Shirkey - Boost Hardware Ltd
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/Linux_Audio_Users_Guide/


_____________________________________________________________
Want a new web-based email account ? ---> http://www.firstlinux.net

_____________________________________________________________
You deserve a better email address! Get personalized email @yourname
or @yourcompany from Everyone.net --> http://www.everyone.net?tag

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
