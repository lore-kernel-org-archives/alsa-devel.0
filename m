From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Hammerfall HDSP multiface doesn't work with latest driver?
Date: Tue, 27 May 2003 08:47:36 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19Kdng-0006e9-00@sc8-sf-list1.sourceforge.net>
References: <3ED3284A.FE3C1AF3@users.sourceforge.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 27 May 2003 11:56:42 +0300."
             <3ED3284A.FE3C1AF3@users.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "M. Nentwig" <nentwig@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hello,
>
>I just compiled alsa-lib and alsa-drivers yesterday. Now my hammerfall
>hdsp multiface doesn't load the firmware anymore. The red LED remains
>on, 'modprobe' ends with 'waiting for firmware'.
>I reverted to an earlier version of alsalib and alsadrivers, and it
>works again. Any ideas?

you need to get alsa-tools, and run the hdsploader program.

this change was made because we can't (and/or don't want to)
distribute non-GPL'ed firmware in the kernel, so the firmware has be
loaded from user-space.

--p


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
