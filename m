From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: build changes
Date: Wed, 04 Jun 2003 17:57:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030604175732.pochini@shiny.it>
References: <Pine.LNX.4.44.0306041339290.1174-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306041339290.1174-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 04-Jun-2003 Jaroslav Kysela wrote:
>> I tried to replace Rules.make with an older version and it works
>> fine. How do I compile the driver for 0.9.4+ ?  I also would like
>> to group all files in a subdir.
>
> Do you have a file alsa-driver/pci/echoaudio.patch?

Yes... I removed it and now it compiles the main source, but it stops here:

make: *** No rule to make target `echoaudiogeneric/CDaffyDuck.c', needed by `echoaudiogeneric/CDaffyDuck.o'.  Stop.

The Makefile contains this line:

snd-echoaudio-objs := echoaudio.o echoaudiogeneric/OsSupportLinux.o [...]

all .cpp sources in echoaudiogeneric/ have already been compiled. It shouldn't try
to compile them again since object files are up to date.


Bye.



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
