From: Paul Davis <pbd@op.net>
Subject: Re: more improvement of alsa web pages
Date: Wed, 24 Apr 2002 08:29:44 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E170Lqp-0001FB-00@usw-sf-list1.sourceforge.net>
References: <s5hd6wph296.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 24 Apr 2002 11:31:01 +0200."
             <s5hd6wph296.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>how about to add informational pages for each driver, and make links
>from soundcard matrix?  then a user can reach to the detailed info by
>two clicks from the top page.
>
>a driver page will contain:
  
 [ ... ]
 
>the pages should be controlled by cvs, so that both developers and web
>admins can keep them up-to-date.
>an advantage is that we can generated documents for
>alsa-kernel/Documentation from these files.
>
>i'm not sure whether these docs to be auto-generated or should be
>static files.  also, we need to discuss which format is best - sgml,
>docbook, html or else.
>
>we can start from converting existing docs (e.g. CMIPCI.txt) to
>such pages.
>
>
>any comments please?

we had quite a bit of discussion about this a month or two back. some
people were in favor of something like a wiki, where people could add
information in a dynamic, immediate way, and thus increasing the
likelihood that we'd accumulate a bunch of useful information. others
wanted something more like you're suggesting.

i think that its important that there is a mechanism to make
collecting information from users extremely easy, because otherwise
there simply won't be very much in this pages. CVS doesn't meet this
requirement since its intended to grant write access to a relatively
small number of people (and certainly not just anybody who happens to
have a useful piece of info about their audio interface).

patrick even mocked up a sample page which i critiqued in a number of
ways. 

whatever we do, we should move forward with this fairly quickly,
because its one of the biggest weaknesses (after the complete lack of
user-usable documentation for ~/.asoundrc) of ALSA at this time.

--p
