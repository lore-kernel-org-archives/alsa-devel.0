From: Matthias Weiss <matthias.weiss@inode.at>
Subject: Re: Debugging driver modules
Date: Sun, 1 Dec 2002 15:27:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <6302.49866885624$1038753109@news.gmane.org>
References: <1038695263.19113.12.camel@vermin2.joe.net> <E18IBVD-0004hD-00@sc8-sf-list1.sourceforge.net>
Reply-To: matthias.weiss@inode.at
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E18IBVD-0004hD-00@sc8-sf-list1.sourceforge.net>
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

On Sat, Nov 30, 2002 at 12:38:20PM -0500, Paul Davis wrote:
> >I have a STAudio DSP24 mkII and I have noticed that recent changes(after
> >NOV 13) in the CVS creates an ICE1712 driver that locks up my kernel.
> >Instead of just complaining about this problem I thought I might try to
> >narrow down the location in the driver that is causing the lockup.
> >
> >Does anyone have any tips on debugging the driver modules? Is anyone
> >using a debugger to do this? I have looked at UML, but I am not sure if
> >there is a way to access the sound hardware with it.
> 
> use the "single" kernel option on the boot command line. this will
> shorten start up times considerably. once you're at the shell prompt,
> mount any necessary filesystems by hand, modprobe the drivers, and
> test using a console window. i generally find that this shortens the
> crash-reboot-edit-recompile-reboot-crash cycle by a factor of at least
> three. mount any filesystems that don't need to be writable with the
> "ro" option so that any crash leaves them untouched.

Couldn't "user mode linux" be used to avoid the "reboot" stage?

matthias


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
