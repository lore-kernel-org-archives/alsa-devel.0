From: Giuliano Pochini <pochini@shiny.it>
Subject: build changes
Date: Wed, 04 Jun 2003 11:11:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030604111103.pochini@shiny.it>
References: <s5hptlvo57h.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hptlvo57h.wl@alsa2.suse.de>
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


In v0.9.4 Rules.make changed. I used to put the files of my driver
in the alsa-driver-xxx/pci directory, but they don't compile anymore:

bash-2.05$ make
Coping file alsa-kernel/core/pci/echoaudio.c
cp: cannot stat `/home/pochini/soft/alsa-driver-0.9.4/alsa-kernel/pci/echoaudio.c': No such file or directory
make: *** [echoaudio.c] Error 1
bash-2.05$

I tried to replace Rules.make with an older version and it works
fine. How do I compile the driver for 0.9.4+ ?  I also would like
to group all files in a subdir.


Bye.



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
