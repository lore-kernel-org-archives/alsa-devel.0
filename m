From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: New PCM API extension
Date: Thu, 27 Feb 2003 14:32:19 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302271408580.24556-100000@ecabase.localdomain>
References: <Pine.LNX.4.44.0302221819040.1497-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302221819040.1497-100000@pnote.perex-int.cz>
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

Hi,

sorry for the late response.

On Sat, 22 Feb 2003, Jaroslav Kysela wrote:

> 	I've added the snd_pcm_forward() function. This function is
> function with opposite meaning to snd_pcm_rewind() - it skips given count
> of frames (note that in the ring buffer are unchanged, only the r/w
> pointer is increased). The application has full control on the r/w pointer
> now. It's useful mainly in the no-xrun mode where the stream runs forever.

I think this is a good addition, especially considering we already have
the rewind function. I actually have some existing no-xrun code, where I
need to do dummy write/reads if the app side is late. pcm_forward() is 
just the thing for handling these scenerios.

-- 
 http://www.eca.cx
 Audio software for Linux!




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
