From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: periods? fragments?
Date: Mon, 19 May 2003 00:12:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19Hbv6-0004zW-00@sc8-sf-list1.sourceforge.net>
References: <3EC85556.20008@sipquest.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sun, 18 May 2003 23:53:58 EDT."
             <3EC85556.20008@sipquest.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Stuart <dave@sipquest.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Greetings! Fledgeling alsa developer here,
>
>After reading a bunch of documentation, it's unclear to me exactly what 
>a period/fragment is used for. Could anyone expand on it a bit to fill 
>me in?

there is a hardware buffer. its N frames long. you rarely want to deal
with the entire buffer at once. its therefore divided into sections of
a certain length, often (but not always) specified in numbers of
frames. these sections are called "periods" and typically (but not
always) the hardware will interrupt the CPU every time it finishes
dealing with a "period", and you in turn get to deal with it in 1 (or
more) periods at a time. the number of periods per h/w buffer (or
alternately, their size) is a hardware parameter; how many periods
have to have been processed by the h/w before the driver will wake up
your code to read/write more data is a software parameter.

a "fragment" is an older OSS term for the same concept.


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
