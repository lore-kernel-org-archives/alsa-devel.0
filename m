From: Sebastian Kapfer <sebastian_kapfer@web.de>
Subject: Re: [BUG] alsa-lib leaves sound device open for child processes
Date: Sat, 8 Feb 2003 20:45:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030208204557.5f8de78f.sebastian_kapfer@web.de>
References: <20030207194628.20880.qmail@web40604.mail.yahoo.com>
	<Pine.LNX.4.44.0302081248510.1141-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302081248510.1141-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: rankincj@yahoo.com, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On Sat, 8 Feb 2003 12:50:01 +0100 (CET)
Jaroslav Kysela <perex@suse.cz> wrote:

> > All of the remaining applications should be
> > considering what will happen to their resources on
> > exec(), and I see no reason why careless programmers
> > should have a few of their bugs swept under the rug
> > for them.
> 
> I fully agree here.

Can anyone comment on exactly how an alsa-lib client app should make
sure that exec'd processes don't inherit file handles? I can't find a
way to know the FD number which alsa-lib uses. snd_pcm_file_descriptor
is gone. What replaced it?

-- 
Best Regards,   |   Hi! I'm a .signature virus. Copy me into
 Sebastian      |   your ~/.signature to help me spread!


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
