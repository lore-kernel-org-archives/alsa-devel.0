From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-user] Where to find more info on dmix?
Date: Thu, 27 Feb 2003 10:25:24 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302271019580.1109-100000@pnote.perex-int.cz>
References: <002301c2de14$bf92b410$aa1f830a@ICO>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <002301c2de14$bf92b410$aa1f830a@ICO>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 26 Feb 2003, Ivica Bukvic wrote:

> I just read about the existence of dmix that apparently enables /dev/dsp
> sharing through software (please correct me if I am wrong).
> 
> Does it poll both I and O or just O? (i.e. can the mic input be shared
> among several apps)

Only playback, but we will create a plugin for input, too. Abramo has 
suggested 'snoop' as the name. The separation is clear, because playback 
needs mixing samples but capture only copying to multiple locations.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
