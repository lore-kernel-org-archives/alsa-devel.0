From: Giuliano Pochini <pochini@shiny.it>
Subject: Complex mixer questions
Date: 29 Mar 2003 15:00:27 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048949817.18635.35.camel@Jay>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


Please give me some suggestions about how to build a control interface
for this thing. The card has Ni inputs and No ouputs. It can route any
input to any number of outputs and each connection have a different
gain. e.g:

    ---50%----- Out0
   /
In0 ---30%----- Out3
   \         /
    \ -60%---
     X 
    / -100%---- Out4
   /          /
In5----10%----


How have I to call a switch that selects SPDIFCoax/SPDIFOpt/ADAT ?


Bye.




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
