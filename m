From: Giuliano Pochini <pochini@shiny.it>
Subject: Small controls bug
Date: Sun, 23 Nov 2003 00:43:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031123004359.738df49f.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


If I try to register two different controls which have the same name, it does
not fails very nicely. It does not call the .dev_free callback and it doesn't
free a lot of stuff:

Nov 22 23:55:53 localhost kernel: ALSA ../alsa-kernel/core/memory.c:81: kmalloc(5) from e501bc78 not freed
Nov 22 23:55:53 localhost kernel: ALSA ../alsa-kernel/core/memory.c:81: kmalloc(76) from e501bc60 not freed
Nov 22 23:55:53 localhost kernel: ALSA ../alsa-kernel/core/memory.c:81: kmalloc(176) from e502d18c not freed
Nov 22 23:55:53 localhost kernel: ALSA ../alsa-kernel/core/memory.c:81: kmalloc(7) from e501bc78 not freed
[~300 lines]


--
Giuliano.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
