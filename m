From: Carlo Wood <carlo@alinoe.com>
Subject: Re: Bug in OSS simulation (ALSA 0.9.4)
Date: Thu, 10 Jul 2003 03:51:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030710015134.GA12482@alinoe.com>
References: <20030710013326.GA12086@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030710013326.GA12086@alinoe.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: xvoice@yahoogroups.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 10, 2003 at 03:33:26AM +0200, Carlo Wood wrote:
> #fragments, #bytes: 0, 0
> #fragments, #bytes: 1, 1632
> Read 1024 bytes.
> #fragments, #bytes: 2, 2048
> Read 1024 bytes.
> #fragments, #bytes: 1, 1024
> Read 1024 bytes.
> #fragments, #bytes: 0, 0
> #fragments, #bytes: 0, 0
> #fragments, #bytes: 0, 0
> ...etc


Ah... I noticed something else.
It doesn't have to do with whether or not
using SNDCTL_DSP_SETFMT, but with having
an overrun of the number of buffers.

Why is the number of allocated buffers
so low?!

And, is it normal that when the buffers
did overrun that nothing is returned anymore?
How about just skipping it? :/

The problem of ViaVoice is probably that
after it opened /dev/dsp, it first does
something that eats cpu for half a second.
With only 2 buffers of 1024 bytes, I immedeately
get an overrun.

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
