From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: HP Pavillion TX2000z - Headphonejack not working
Date: Thu, 11 Dec 2008 11:57:57 -0700
Message-ID: <494162B5.6080809@cox.net>
References: <d9690f190812110907w7fe7c0d4w4a71b4e0c36f3300@mail.gmail.com>	<49414D6B.8090402@cox.net>
	<d9690f190812110955ja3d0ca2qa90efdd58a0ca168@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao106.cox.net (fed1rmmtao106.cox.net [68.230.241.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FE6924650
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 19:57:30 +0100 (CET)
In-Reply-To: <d9690f190812110955ja3d0ca2qa90efdd58a0ca168@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Klaus Schulz <kls.schlz@googlemail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Klaus Schulz wrote:
 > Stan.
 >
 > You don't seriously expect me to show this document to a 
standard Linux
 > User!!

Well yes for some users, but mostly it was for your use. 
When the user asks you questions, you use the information in 
the document to give them advice of what to do.  Perhaps you 
could extract the user doable parts for your own use and to 
send to users.

I think we have slightly different perceptions of what a 
standard linux user is.  ;-)

 From my perspective, your perception is that a standard 
linux user uses linux like a windows user uses windows, an 
appliance.

I think a standard linux user has some IT background, or at 
least some IT interest.  They aren't afraid of getting their 
hands dirty.  If they were a car owner, they know how to 
open the hood and can point to a spark plug and the battery, 
know how to fill the window washer fluid and radiator, check 
the oil.

In other words your standard linux user is a driver, mine 
drives but does his own standard maintenance.

I suspect that both types are linux users.  I read about 
people whose grandmothers use linux so it must work like 
that (they do all the setup and maintenance for them).

 > This is designer talk!
Not all of it.  I'm thinking you got freaked by the 
technical tone and your eyes glazed over.  But much of the 
information there could be understood and implemented by a 
high school student (a bright high school student, but a 
high school student).  Try reading it, just skip those 
sections that seem too technical to you.  I think you'll be 
surprised at how much information you get out of it.

 > The normal user needs a manageable guideline.
That's you.  :-)
Actually, the normal user should never ever see these 
issues.  HD audio should work the way AC97 works.  It just 
works.  It is having teething pains.
 >
 > Is there a(n) (up2date and reliable!!) database of 
Codecs, PCs and its
 > interface implementations and testrecords
 > somewhere?  Let me know there is one.

There is sort of one, in the alsa-driver source package of 
alsa.  It is in alsa-kernel/Documentation/ALSA-Configuration.txt

Of course, the ultimate source is the source code itself, 
but I will concede that that is beyond the capabilities of 
standard linux users.
 >
 > My role: I am just gathering the problems over there
 > http://ubuntuforums.org/showthread.php?t=962695
 > I am making sure that the mixer issue is clarified over 
there at
 > Ubuntuforums as well
 > as the model-id part. Beyond that everything else will 
exceed my capacities.
Maybe now, but I suspect you will get proficient with time. 
  Another alternative is to open problem records to alsa 
when you have issues you can't resolve.  They will need the 
alsa-info.sh output in them for the developers to use.  I 
don't know how effective that will be, but at least a record 
will be kept.
 >
 > The model-id part, if you read Takashi's document, sounds 
IMO pretty fluffy.
 >
 > You can't expect a user to try all model-ids, to find the 
right one.
 > You need to set up a database for that. Expecting the 
normal user to fiddle
 > around
 > with module options, is also not what I'd honestly expect 
from a 2009 Linux
 > sound layer.

Do a search for alsa-info.sh in the document.  That is a 
script that runs to extract all relevant sound information 
from the PC of the user.  The codec information is there, 
and it will show the model ID it determined.  I don't think 
it is beyond a linux user to run alsa-info.sh and look at 
the information if told where to look.

 >
 > Sorry for sounding maybe a bit harsh. But the issues of 
"My headphone jack
 > is not working" "My speakers are not working"
 > "I got noise on my speakers" "I can't use my digital out" 
asf asf somehow
 > have to get under control.
 > It is obvious that a normal user can not handle this.

I happen to agree.  Almost all of the issues in linux sound 
are related to HD audio these days.  As the document points 
out, not all of these are alsa issues.  It explains how to 
resolve them if they are resolvable within alsa.  And it 
points to how to open a problem record to alsa and what to 
include in it.  Again, the alsa-info.sh output should be there.
 >
 > A reliable, well maintained database and  user 
documentation would be a IMO
 > a nice starting point.
Yes, it would.  But that takes time and effort.  It isn't so 
much the initial effort, it is the ongoing maintenance 
effort.  And it requires in depth knowledge of alsa.  The 
people who have that knowledge spend their time developing alsa.
 >
 > THX
 > Klaus
