From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Bug in OSS simulation (ALSA 0.9.4)
Date: Fri, 11 Jul 2003 01:54:51 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307110150040.5612-100000@ecabase.localdomain>
References: <20030710015134.GA12482@alinoe.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030710015134.GA12482@alinoe.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlo Wood <carlo@alinoe.com>
Cc: alsa-devel@lists.sourceforge.net, xvoice@yahoogroups.com
List-Id: alsa-devel@alsa-project.org

On Thu, 10 Jul 2003, Carlo Wood wrote:

>> #fragments, #bytes: 0, 0
>> #fragments, #bytes: 1, 1632
>> Read 1024 bytes.
>> #fragments, #bytes: 2, 2048
[...]
> Ah... I noticed something else.
> It doesn't have to do with whether or not
> using SNDCTL_DSP_SETFMT, but with having
> an overrun of the number of buffers.
[...]
> Why is the number of allocated buffers
> so low?!

This is a feature of the SB-Live driver: in capture/recording direction,
it supports max two interrupts per buffer. To increase the total
buffersize you need to increase fragment size. In playback mode up to 1024 
interrupts per buffer is supported. I got this info by reading through the 
driver code, so I don't have further info about the issue.

> And, is it normal that when the buffers
> did overrun that nothing is returned anymore?
> How about just skipping it? :/

No, this definitely looks like a driver bug. In OSS-emulation mode the 
xruns should be ignored (just lke kernel/OSS drivers do).

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
