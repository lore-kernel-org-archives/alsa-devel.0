From: Paul Davis <pbd@Op.Net>
Subject: Re: Problems compiling with C++
Date: Mon, 25 Mar 2002 07:30:01 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203251729.MAA15700@renoir.op.net>
References: <001001c1d421$878145d0$0200a8c0@travelmate>
In-Reply-To: Your message of "Mon, 25 Mar 2002 18:21:35 +0100."
             <001001c1d421$878145d0$0200a8c0@travelmate>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Pablo Espada <pablo.espada@naviforo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I'm trying to compile a program written in c++ using alsa API functions =
>related with the plugin interface (v.05.11). But the linker do not find =
>these functions (such as snd_pcm_plugin_params). I don't have any =
>problems if i use C instead of C++, but in this time i have to use C++. =
>Does anybody knows what can i do?

1) Stop using ALSA 0.5.X. Despite what the web site, 0.9.X is a lot
   more usable and stable. Your code will not work with most people's
   installations of ALSA in the very near future, if not right now.

2) use 
        extern "C" {
	      #include <...> // ... is whatever include file you need
        }

3) just a quick note to point out that whether you know it or not, the
   email program you are using is sending out copies of your mail in
   both plain text and HTML formats. increasingly on the net, there
   are filters being put in place that silently dump HTML-formatted
   email. some mailing lists will not ever accept such posts. as long
   as you do this, you are (1) wasting network bandwidth by sending
   messages that are typically more than twice as long as they could
   be (2) making it harder for people using traditional email readers
   to read them (3) risking the chance that people will never see your
   mail because its filtered before reaching their email inbox.

*************
<pretend-to-be-usenet-newbie>
4) ALSA DEVEL MEMBERS

PLEASE PLEASE PLEASE CAN WE CHANGE THE WEBSITE TO MOVE AWAY FROM THE 
DENOTATION OF 0.5.X AS THE "STABLE" RELEASE? CAN WE DO IT IN THE NEXT
TWO DAYS??? PATRICK HAS A REASONABLE VERSION OF THE HOME PAGE. LETS
DO THIS REALLY, REALLY SOON!! WHAT'S HOLDING THIS UP?
***************
</pretend-to-be-usenet-newbie>
