From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problem compiling alsa-driver-0.9.3c
Date: Tue, 27 May 2003 08:09:19 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0305270806320.2726-100000@studcom.urz.uni-halle.de>
References: <200305261857.31425.azidog@nyc.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200305261857.31425.azidog@nyc.rr.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jacek Blizinski <azidog@nyc.rr.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jacek Blizinski wrote:
> checking for GCC version...
> Kernel compiler: gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk)
> Used compiler:   gcc-3.2.2 (GCC) 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk)
> Fatal error: Compiler type does not match
>
> However the compiler is the same. Is there any way to fix this or remove the
> check?

I don't know why the identification strings are different, but you can
remove the error by deleting line 2754 of the configure script.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
