From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-lib resamplers broken.
Date: Wed, 17 Dec 2003 16:54:26 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312171653350.8959@pnote.perex-int.cz>
References: <3FE07BE6.5010100@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FE07BE6.5010100@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 17 Dec 2003, James Courtier-Dutton wrote:

> Hi,
> 
> If I use the "front" device name, and select a rate of 48000, I get 
> sound output. (snd-intel8x0)
> If I use the "front" device name, and select a rate of 44100, It replies 
> saying 44100 is not availiable, try 48000 instead!
> 
> As the "front" device is a plug device, alsa-lib should automatically 
> resample 44100 to 48000 instead of rejecting 44100.

"front" is _NOT_ a plug device. If you want to use front as plug device, 
use "plug:front".

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
