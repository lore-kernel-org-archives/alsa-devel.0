From: drclaw@dogsolitude.org
Subject: Re: [BUG] buggy ali5451 driver
Date: Mon, 4 Nov 2002 06:20:35 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021104112035.GA14883@dogsolitude.org>
References: <m24raxpndj.fsf@vador.mandrakesoft.com> <s5hu1ixa0eu.wl@alsa2.suse.de> <3DC68350.2040208@wanadoo.fr> <3DC68814.6070700@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3DC68814.6070700@wanadoo.fr>
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

Try disabling "use dma by default" in the ide section.  If that then
fixes the problem I have a patch that can get you dma back.  I've got an
ali southbridge in my laptop as well and everything works fine.  

784 - Michael C. Piantedosi - drclaw@dogsolitude.org


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
