From: ian <deviant@custard.org>
Subject: Re: Java Bindings?
Date: Tue, 18 Mar 2003 15:01:11 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303181452060.31785-100000@rhubarb.custard.org>
References: <61627AE0C39BD11182D600805FE6527B0A02D77D@lonim26408.uk.ml.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <61627AE0C39BD11182D600805FE6527B0A02D77D@lonim26408.uk.ml.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

i don't think there are any java bindings for alsa. but there is tritonus,
which is an implementation of the java sound api, and uses alsa in parts.
alternatively, you could use jni (java native interface) to write the glue
code between your java app and alsa. i've done that, and it works fine.
ian


On Tue, 18 Mar 2003, Merrony, Stephen (London) wrote:

> Has anyone worked on Java bindings for ALSA?
>
> Or is there another route I should consider if I want a Java app to
> communicate with ALSA?
>
> Regards
> 	         Steve
>
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Does your code think in ink?
> You could win a Tablet PC. Get a free Tablet PC hat just for playing.
> What are you waiting for?
> http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
