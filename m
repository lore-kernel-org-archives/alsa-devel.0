From: Paul Davis <pbd@op.net>
Subject: Re: ALSA docs
Date: Fri, 26 Jul 2002 20:15:08 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17YFBD-0007ac-00@usw-sf-list1.sourceforge.net>
References: <3D403A94.2070308@boosthardware.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Fri, 26 Jul 2002 02:51:16 +0900."
             <3D403A94.2070308@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I'm looking into ways to automate the modules options component file for 
>  the docs.
>
>At the moment I am considering using perl or mysql. Does anyone know 
>which is easier to setup to do the following.
>
>Parse the INSTALL file for a module name.
>Return the info for that module.
>
>Then either
>
>Write the module info to a temp file which is inserted into the template
>
>  or
>
>insert the module info into the template.

i would personally work from a complete set of snd-* modules, and use
modinfo(1) + perl to get the information and put that into the temp
file that is inserted into the template, or if possible, put it
straight into the template.

--p 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
