From: Arnaud de Bossoreille de Ribou <arnaud.debossoreille@via.ecp.fr>
Subject: Re: emu10k1 bug and patch (0.9.0rc7)
Date: Tue, 18 Feb 2003 09:30:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030218083012.GB2181@via.ecp.fr>
References: <20030217083611.GA2181@via.ecp.fr> <Pine.LNX.4.44.0302171123090.1054-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302171123090.1054-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Arnaud de Bossoreille de Ribou <arnaud.debossoreille@via.ecp.fr>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 17, 2003, Jaroslav Kysela wrote:
> Unfortunately, the problem is more deep that I thought. I have to enhance 
> the midlevel and transfer routine only synchronizes with appl_ptr now. It
> will avoid the "ping-pong" effect caused by the extra function argument
> "frames".
> 
> Could you try the latest CVS sources? Thanks.

The CVS sources sound OK, thank you very much.

-- 
Arnaud


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
