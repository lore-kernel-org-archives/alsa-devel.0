From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: build changes
Date: Wed, 4 Jun 2003 13:40:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306041339290.1174-100000@pnote.perex-int.cz>
References: <XFMail.20030604111103.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20030604111103.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 4 Jun 2003, Giuliano Pochini wrote:

> 
> In v0.9.4 Rules.make changed. I used to put the files of my driver
> in the alsa-driver-xxx/pci directory, but they don't compile anymore:
> 
> bash-2.05$ make
> Coping file alsa-kernel/core/pci/echoaudio.c
> cp: cannot stat `/home/pochini/soft/alsa-driver-0.9.4/alsa-kernel/pci/echoaudio.c': No such file or directory
> make: *** [echoaudio.c] Error 1
> bash-2.05$
> 
> I tried to replace Rules.make with an older version and it works
> fine. How do I compile the driver for 0.9.4+ ?  I also would like
> to group all files in a subdir.

Do you have a file alsa-driver/pci/echoaudio.patch?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
