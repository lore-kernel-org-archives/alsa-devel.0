From: peter plessas <plessas@mur.at>
Subject: cvs compile, toplevel.config.in and alsa-kernel
Date: Sun, 20 Mar 2005 17:48:07 +0100
Message-ID: <423DA947.70609@mur.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dear List,

I am afraid here comes a cvs-compiliation question :-)

trying to build alsa-driver (fresh checkout) for a 2.6.11.5 kernel on a 
debian ppc testing box.

as i read from the docs, running ./cvscompile should do it, though i am 
getting one or two errors:

first:
Makefile:24: toplevel.config: No such file or directory

and:
find: /usr/local/src/cvs/alsa_cvs/alsa-driver/alsa-kernel/: No such file 
or directory

shouldn't this be the kernel/ directory?

spent some time on this now, and wanted to ask for a quick hint!

thanks!

Peter


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
