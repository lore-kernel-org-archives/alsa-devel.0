From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Bug in OSS simulation (ALSA 0.9.4)
Date: Fri, 11 Jul 2003 03:05:28 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307110251390.5612-100000@ecabase.localdomain>
References: <20030710234320.GA21216@alinoe.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030710234320.GA21216@alinoe.com>
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

On Fri, 11 Jul 2003, Carlo Wood wrote:

> On Fri, Jul 11, 2003 at 01:54:51AM +0300, Kai Vehmanen wrote:
>> No, this definitely looks like a driver bug. In OSS-emulation mode the 
>> xruns should be ignored (just lke kernel/OSS drivers do). 
> Ok.  Any chance that this can be fixed soon?
> If only in CVS.

I'm not the right person to answer this unfortunately. You probably 
have to wait for Jaroslav Kysela's and Takashi Iwai's comments. They
are the primary (active :)) ALSA developers and have written the 
the OSS layer.

> If you have no time to look into it, then
> can you at least tell me if it is possible
> to run the alsa modules in usermode somehow,
> so I can debug them with gdb?

One thing to try is the alsa-oss package. This is an alternative
(user-space) implementation of the OSS emulation layer. It relies on the
LD_PRELOAD mechanism. You can test it with:

LD_PRELOAD=/path/to/libaoss.so.0.0.0 ./a.out

... where "a.out" is your test program. You should be able to run ViaVoice
also this way. You can get the alsa-oss package from ALSA CVS or from:
LD_PRELOAD=~/src/alsa-cvs/alsa-oss/.libs/libaoss.so.0.0.0 ./a.out

> I am afraid I have no experience with kernel
> (model) debugging.  Can you give me a pointer
> to where I read up on debugging this?

Adding printk()'s to the alsa-driver code, recompiling and reloading the 
modules is the best (well, IMHO) way to start. The ALSA kernel-space OSS 
emulation code is in 'alsa-driver/acore/oss/*'.

--
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
