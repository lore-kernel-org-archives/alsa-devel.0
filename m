From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Hammerfall HDSP9652
Date: Thu, 20 Feb 2003 06:48:12 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18lpAR-0002e5-00@sc8-sf-list1.sourceforge.net>
References: <1045719285.7937.16.camel@polyhymnia.plingplong.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 19 Feb 2003 22:35:33 MST."
             <1045719285.7937.16.camel@polyhymnia.plingplong.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Frank Ekeberg H." <frankh@notam02.no>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Is there a functioning driver available for the new Hammerfall HDSP9652
>yet?

the hdsp driver works, but the mixer register configuration is
different and so the volumes cannot be set. i have not yet found
the time to merge the "code" from RME into the existing hdsp
driver. if someone else wants to take this on, i will be happy to send
them the code fragments from RME, but they are not particularly clear
unless you already fully understand the existing driver and/or h/w
model.

--p


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
