From: Paul Davis <pbd@Op.Net>
Subject: Re: Status of ALSA documentation?
Date: Tue, 26 Feb 2002 10:07:50 -0500
Message-ID: <200202261508.KAA21675@renoir.op.net>
In-reply-to: Your message of "Mon, 25 Feb 2002 23:02:52 PST."
             <20020226070252.779392756@sitemail.everyone.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: pshirkey@boosthardware.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I disagree. I just went through the process of teaching a friend how to use li
>nux and he needed every piece of information I could give him. It is my opinio
>n that repetiton and hand holding is the key to success for all newbies. (Base
>d on teaching ESL for the past two years and teaching myself how to use linux 
>for the past 3). 

well, then i'd use language like:

      edit the file /foo/bar/baz. you can use any text editor for
      this, including such programs as vi and emacs.

you cannot usefully make a document on a specific audio interface into
a tutorial on basic unix system skills. i think that someone who
doesn't know how to use a text editor will *not* be able to follow
your instructions without additional help from someone else.

>>The problem is that these documents will become reference sheets for
>>each soundcard. Browsing through a couple of pages of install info for
>>ALSA every time you want to check on that detail about the
>>CmRMiceCreatEmu Y18kJA card is going to annoy most people. 
>>
>
>Hence the hyperlinks in the contents of the page. Once I learn some more comma
>nds for the wiki then having these shouldn't be a problem. Someone correct me 
>if I'm wrong.

I would just invert the order of the information. Put the card
specific info at the top, and follow it with the generic information.

>I'm attacking the install howto from the point of view of a "complete" newbie.
> Someone who needs to be spoonfeed. 

Thats a different goal than I was originally outlining. We get lots of
mail on alsa-devel (and probably even more on alsa-user) asking "how
do i use this card?" or "how do i get this card to do ...?". the mail
isn't from complete newbies, who probably wouldn't even know that
alsa-devel exists, but from people who know how to use a text editor
yet have no clue how to get their audio interface working. Thats the
audience I was aiming for.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
