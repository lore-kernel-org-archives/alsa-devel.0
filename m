From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Complex mixer questions
Date: Sat, 29 Mar 2003 09:14:48 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18zH1M-00046X-00@sc8-sf-list1.sourceforge.net>
References: <1048949817.18635.35.camel@Jay>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "29 Mar 2003 15:00:27 GMT."
             <1048949817.18635.35.camel@Jay>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Please give me some suggestions about how to build a control interface
>for this thing. The card has Ni inputs and No ouputs. It can route any
>input to any number of outputs and each connection have a different
>gain. e.g:
>
>    ---50%----- Out0
>   /
>In0 ---30%----- Out3
>   \         /
>    \ -60%---
>     X 
>    / -100%---- Out4
>   /          /
>In5----10%----

the hammerfall HDSP series are the same.

there are 2 questions:

   1) what ALSA API to use, and how to use it?
   2) what would a GUI look like?

for (2), i suggest you *carefully* study RME's totalmix application, a
version of which will soon be available for linux.

for (1), we use the control API but use it in a slightly unorthodox
way. the control API normally is used to set control values in a
simple 1:1 mapping between a control parameter and its new
value. instead, we use 2 parameters (the source and the destination)
and 1 value (the gain level). this does mean that alsactl can't handle
it correctly, but so far no better suggestion has arisen. the hdsp
series would have 1500+ control elements if we used the 1:1 method.

>How have I to call a switch that selects SPDIFCoax/SPDIFOpt/ADAT ?

just use the control API. there is no standard name for such a switch.

btw, what h/w is this?





-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
