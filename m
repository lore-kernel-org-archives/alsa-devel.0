From: Paul Davis <pbd@op.net>
Subject: Re: libasound and libpthread
Date: Mon, 29 Jul 2002 08:05:21 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17Z9Fw-00028n-00@usw-sf-list1.sourceforge.net>
References: <3D44F782.3070007@emt.iis.fhg.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 29 Jul 2002 10:06:26 +0200."
             <3D44F782.3070007@emt.iis.fhg.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Thomas Roeder <rdr@emt.iis.fhg.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I am working with Alsa 0.9.0beta12 version and I am also using posix 
>threads (libpthread) in my project. In the release version of the 
>program I link both libraries (libpthread, libasound) dynamically and 
>everything works well. In the debug version however, I have to do static 
>linking of the libpthread for proper debugging.

why? i use pthreads a great deal, and i have never had to do this.

and no, libasound does not use pthreads or any other form of threads.

--p


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
