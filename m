From: Patrick Shirkey <kotau@firstlinux.net>
Subject: Re: Status of ALSA documentation?
Date: Wed, 27 Feb 2002 00:46:08 -0800 (PST)
Message-ID: <20020227084608.350742757@sitemail.everyone.net>
Reply-To: pshirkey@boosthardware.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@Op.Net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--- Paul Davis <pbd@Op.Net> wrote:
>>I disagree. I just went through the process of teaching a friend how to use li
>>nux and he needed every piece of information I could give him. It is my opinio
>>n that repetiton and hand holding is the key to success for all newbies. (Base
>>d on teaching ESL for the past two years and teaching myself how to use linux 
>>for the past 3). 
>
>well, then i'd use language like:
>
>      edit the file /foo/bar/baz. you can use any text editor for
>      this, including such programs as vi and emacs.
>
>you cannot usefully make a document on a specific audio interface into
>a tutorial on basic unix system skills. i think that someone who
>doesn't know how to use a text editor will *not* be able to follow
>your instructions without additional help from someone else.
>

That's a good point. Someone else also mentioned why not have a more user friendly example. I will eventually. I think I will make a page with maybe 5 examples of how to edit a file to make a working modules.conf and provide it as a link in the doc. The info in the doc will be as above.

If anybody wants to write a corresponding example for their favorite editor please send it to me. It should take about 1 minute. The text that needs changing is this:

---------
To copy and paste the above to your /etc/modules.conf file follow these instructions.

Using the vi text editor:

Change to root.


	su

Open the file with your favorite text editor.

	vi /etc/modules.conf

Copy the above text to the bottom of the file by highlighting it with your mouse and paste it by clicking in the appropriate spot with your middle mouse button. If you don't have a middle mouse button then you can press the left and right button at the same time.
If you use the above text editor you will need to put the cursor in the correct place and type: 

	a

Which allows you to write to the file. Then save the file. If you use the above text editor type:

	ESC
	q
	then type:
	wq!
	and press enter.


---------


>>>The problem is that these documents will become reference sheets for
>>>each soundcard. Browsing through a couple of pages of install info for
>>>ALSA every time you want to check on that detail about the
>>>CmRMiceCreatEmu Y18kJA card is going to annoy most people. 
>>>
>>
>>Hence the hyperlinks in the contents of the page. Once I learn some more comma
>>nds for the wiki then having these shouldn't be a problem. Someone correct me 
>>if I'm wrong.
>
>I would just invert the order of the information. Put the card
>specific info at the top, and follow it with the generic information.
>

That works too. But more experienced users can easily follow a link whereas the newbies will get very confused with lots of technical info at the top of the document. I think a linked TOC is a good compromise.

>>I'm attacking the install howto from the point of view of a "complete" newbie.
>> Someone who needs to be spoonfeed. 
>
>Thats a different goal than I was originally outlining. We get lots of
>mail on alsa-devel (and probably even more on alsa-user) asking "how
>do i use this card?" or "how do i get this card to do ...?". the mail
>isn't from complete newbies, who probably wouldn't even know that
>alsa-devel exists, but from people who know how to use a text editor
>yet have no clue how to get their audio interface working. Thats the
>audience I was aiming for.
>

Sure, currently we do but in the not too distant future we may be overloaded with new users who don't know this information. Better to cover our bases now than field hundreds of the same questions later. We just need to organise the page in a layout that makes it as easy as possible for everyone.


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
