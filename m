From: Giuliano Pochini <pochini@shiny.it>
Subject: .dimen order ?
Date: Mon, 24 Nov 2003 20:08:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031124200810.5f4f55b2.pochini@shiny.it>
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



snd_ctl_elem_info_t.dimen contains the dimensions of the array of
controls. AFAIK there are no drivers which use that feature (but mine)
to look for examples. We have to agree about the order of them:

Array[d0][d1][d2][d3]

or

Array[d3][d2][d1][d0]

I used the first one. Is it ok ?


--
Giuliano.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
