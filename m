From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: MMAP and pcm copy op.
Date: Sun, 18 May 2003 20:20:55 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19HYIv-0004jp-00@sc8-sf-list1.sourceforge.net>
References: <20030518161107.14355.h005.c012.wm@mail.icqmail.com.criticalpath.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sun, 18 May 2003 16:11:06 PDT."
             <20030518161107.14355.h005.c012.wm@mail.icqmail.com.criticalpath.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eliot Blennerhassett <bigblen@icqmail.com>
Cc: alsa-devel@lists.sourceforge.net, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

>I got the impression that should either have copy and silence operations, OR
>allow MMAP:

no. the driver provides read/write access (via the
read(2) and write(2) system calls (hidden by alsa-lib, but still
there; actually, its even more hideous than that, but you don't need
to know :), which requires the copy routine. it can also choose to
provide mmap access if the h/w can support it. sounds like you will
also want to do both (mmap is more efficient). off the top of my
head, i think alsa-lib can hide any limitation in what the driver
provides too, so ultimately its only a question of run-time efficiency.

--p


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
