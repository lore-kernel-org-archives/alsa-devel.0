From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: New driver
Date: Tue, 04 Mar 2003 18:27:21 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18qLlR-0000Wg-00@sc8-sf-list1.sourceforge.net>
References: <200303041935.AA192217402@embedded.cl>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 04 Mar 2003 19:35:35 -0400."
             <200303041935.AA192217402@embedded.cl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander@embedded.cl
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>What is the "official" procedure to integrate  my driver ?

my approach has always been:

   cd $TOP_OF_ALSA_TREE
   find . -type f | xargs grep SOME_OTHER_CARD_NAME

where SOME_OTHER_CARD_NAME is picked from a suitable existing driver.
this lets me see all the places i have to refer to it.

but there must be a better way :)



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
