From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Am I asking the right people ?
Date: Wed, 27 Nov 2002 08:24:26 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18H27W-0003Oe-00@sc8-sf-list1.sourceforge.net>
References: <3DE472FA.1060300@tele-ip.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 27 Nov 2002 18:23:38 +1100."
             <3DE472FA.1060300@tele-ip.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bruce Paterson <bruce@tele-ip.com>
Cc: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Am I sending these queries about the operation of alsa through the API 
>to the right place ?  I'm trying to use alsa for a real scientific
>application and I'm starting to worry it simply isn't ready yet.

the API is ready. the documentation is not. some of us have been using
ALSA to develop serious audio applications for several years. there
are no substantive issues with the API at this time.

>However, the silence I get in reply to queries is golden (unlike the
>distortion I'm getting from the soundcard) !

the problem with your question is that there's no way to know whether
its a software issue or hardware issue without getting your code and
running it ourselves. there are actually very few developers in the
ALSA team, and all of them are extremely busy. the lack of response to
your question has nothing to do with the state of the API and
everything to do with people's workloads and their interest in solving
yet another common problem with audio software (the problem you're
describing has happened to me often, and can be caused by several
different things in your code).

>It's possible I'm not using the alsa API in the way intended and 
>bringing the problems upon myself, but please, somebody tell me !
>
>It would be a real blow to the progress of linux in this company if all 
>the alsa work had to be scrapped.

i would point out that "scrapping ALSA" would be pretty stupid when
its the standard audio API in the 2.5/2.6 kernel.

--p


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
