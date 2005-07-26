From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: envy24control midi updates
Date: Tue, 26 Jul 2005 13:37:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0507261337160.8190@tm8103-a.perex-int.cz>
References: <42E58773.2020609@cubic.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42E58773.2020609@cubic.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dirk Jagdmann <doj@cubic.org>
Cc: alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Jul 2005, Dirk Jagdmann wrote:

> Hello developers,
> 
> I have enhanced the midi control of envy24control.
> 
> 1) I have fixed midi feedback, where issuing a controller event resulted in
> the controller value beeing sent to the midi port again.
> 
> 2) I have added midi controllers for the "mute" buttons, which can now be
> controller via midi.
> 
> 3) and while rewriting the midi code to support the mute buttons several
> off-by-one errors have been fixed.

Applied to CVS. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
