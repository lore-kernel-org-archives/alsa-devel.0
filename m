From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Resending ...can anyone suggest someone who can
 help ?
Date: Thu, 20 Jan 2005 09:11:26 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0501200903250.2453@pnote.perex-int.cz>
References: <200501200936.11434.songshop@bizmedia.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200501200936.11434.songshop@bizmedia.com.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Geoff Beasley <songshop@bizmedia.com.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Jan 2005, Geoff Beasley wrote:

> ALSA lib pcm.c:1178:(snd_pcm_link) SNDRV_PCM_IOCTL_LINK failed: Operation 
> already in progress

I know about this problem. The driver code allows inserting new PCM handle 
to list of linked streams only when the handle is not in another linked 
chain. Actually, the joining of two lists of linked stream is not allowed.

But the multi plugin does the linking for playback and capture streams at 
first (thus two linked chains exist) and then jack tries to link playback 
and capture devices (which is not allowed). This problem must be solved in 
the multi plugin (reordering linking sequence and adding the link 
operation to the alsa-lib midlevel code).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
