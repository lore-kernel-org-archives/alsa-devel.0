From: Paul Davis <pbd@Op.Net>
Subject: Re: Status of ALSA documentation?
Date: Tue, 05 Mar 2002 05:18:59 -0500
Message-ID: <200203051518.KAA26851@renoir.op.net>
In-reply-to: Your message of "Tue, 05 Mar 2002 16:56:20 +0200."
             <20020305145620Z50770-778+2417@nic.funet.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Juhana Sadeharju <kouhia@nic.funet.fi>
Cc: pshirkey@boosthardware.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>>Here's the latest.
>>
>>http://www.boosthardware.com/LAU/alsa/index5-pd.html
>
>I liked better the version which had the explanation of the
>project. What were its problems? I.e., why it was taken off?

i didn't "take it off". i tried to rewrite it so that it didn't sound
as if we were just starting out. ALSA isn't complete, but its hardly
in a "still working on the basic design" phase. i thought the text
should reflect this so that first-time visitors would get a better
feeling for it as a working system. the old description sounded to me
like a reflection of where ALSA was a year or two ago.

>This new page is too wide. Could the title be broken to two lines?
>Then title's height would match the height of the logos.

Sounds good to me.

>  Two line explanation........and link to more information

I tried hard to write a two line explanation, but I couldn't.

>  OSS Combat short
   ^^^^^^^^^^

I think its very VERY VERY important that this not be presented this
way. ALSA offers binary OSS compatibility with no modifications needed
(except for some OSS-mmap apps like quake) Nothing extra is needed to
make them work.

the OSS compat library does a *lot* more than provide OSS
compatibility. we need a new name for it that reflects it capabilities
(routing OSS apps through alsa-lib).

we do not want anyone imagining they have to relink their apps to get
them to work with ALSA, since thats not true.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
