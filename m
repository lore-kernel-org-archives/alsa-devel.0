From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: problems compiling current CVS
Date: Mon, 02 Jun 2003 23:54:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19N2mi-0001iY-00@sc8-sf-list1.sourceforge.net>
References: <20030603031534.GA27280@ds0.van.maves.ca>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 02 Jun 2003 20:15:34 PDT."
             <20030603031534.GA27280@ds0.van.maves.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matthew Clarke <Matthew_Clarke@mindlink.bc.ca>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>This bit:  
>
>        ${xtmp:0:5}
>
>is a Bash-ism.  Normal Bourne shells don't understand this.  I'm guessing
>that your system's /bin/sh isn't Bash.  You might be able to put a 
>
>        SHELL=/bin/bash

paul[2846]>which sh
/bin/sh
paul[2847]>ls -l /bin/sh
lrwxrwxrwx   1 root     root            4 Aug 16  2000 /bin/sh -> bash
paul[2852]>bash -version
GNU bash, version 1.14.7(1)




-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
