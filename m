From: Carlo Wood <carlo@alinoe.com>
Subject: Re: Bug in OSS simulation (ALSA 0.9.4)
Date: Fri, 11 Jul 2003 01:43:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030710234320.GA21216@alinoe.com>
References: <20030710015134.GA12482@alinoe.com> <Pine.LNX.4.44.0307110150040.5612-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307110150040.5612-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: alsa-devel@lists.sourceforge.net, xvoice@yahoogroups.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 11, 2003 at 01:54:51AM +0300, Kai Vehmanen wrote:
> No, this definitely looks like a driver bug. In OSS-emulation mode the 
> xruns should be ignored (just lke kernel/OSS drivers do).

Ok.  Any chance that this can be fixed soon?
If only in CVS.

If you have no time to look into it, then
can you at least tell me if it is possible
to run the alsa modules in usermode somehow,
so I can debug them with gdb?

I am afraid I have no experience with kernel
(model) debugging.  Can you give me a pointer
to where I read up on debugging this?

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
