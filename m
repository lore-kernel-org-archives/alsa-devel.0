From: Carlo Wood <carlo@alinoe.com>
Subject: Re: Bug in OSS simulation (ALSA 0.9.4)
Date: Fri, 11 Jul 2003 02:00:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030711000049.GA21433@alinoe.com>
References: <20030710013326.GA12086@alinoe.com> <Pine.LNX.4.44.0307110145380.5612-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307110145380.5612-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 11, 2003 at 01:49:49AM +0300, Kai Vehmanen wrote:
> Hmm, I tested on my machine and this seems to work fine (ALSA 0.9.3c 
> / 2.4.19 / SB128 (snd-ens1371 module).
> 
> Total number of fragments allocated for buffering: 64

Well, you have 64 fragments - I only 2.

> #fragments, #bytes: 13, 13472
> Read 1024 bytes.

You didn't really test it when you stop here.
13472 < 64 * 1024.

You need to wait till you get an overrun (xrun?).

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
