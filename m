From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: programming with dmix ?
Date: Thu, 19 Jun 2003 15:20:43 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19T4s9-0004nK-00@sc8-sf-list1.sourceforge.net>
References: <20030619184036.62520.qmail@web40904.mail.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 19 Jun 2003 11:40:36 PDT."
             <20030619184036.62520.qmail@web40904.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alex Kuang <alex_sfu@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Just wondered how I can apply the cool feature - dmix
>- to my own program to mix sounds? for example, after
>I compile my small c++ program, I can run it one at a
>time:
>
>./a.out TestMusic.wav
>
>The thing's that how I can mix sounds when I run:
>
>./a.out TestMusic01.wav &
>./a.out TestMusic02.wav &
>./a.out TestMusic03.wav &

make your program accept an argument naming the PCM device to
open. define the device (if necessary) in ~/.asoundrc. run the program
with the appropriate argument. i believe that there is documentation
on the website about using dmix, but it'll be up to someone else to
point you at it if you can't find it.

different kinds ALSA PCM devices do not require different source
code. writing to the dmix plugin is no different than writing to
hardware or other plugins.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
