From: "Pavana Sharma" <pavans@india.ti.com>
Subject: RE: OSS mapping for ALSA controls
Date: Mon, 12 Apr 2004 14:05:27 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <03f901c42069$1bdbc8a0$f8b6a8c0@ent.ti.com>
References: <Pine.LNX.4.58.0404081911240.1867@pnote.perex-int.cz>
Reply-To: <pavans@india.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0404081911240.1867@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Jaroslav Kysela' <perex@suse.cz>, 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Shell supported by the target are ash , dash 
Is this causing problem ..??

Regards
Pavan S

-----Original Message-----
From: Jaroslav Kysela [mailto:perex@suse.cz]
Sent: Thursday, April 08, 2004 10:43 PM
To: Takashi Iwai
Cc: pavans@india.ti.com; alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] OSS mapping for ALSA controls


On Thu, 8 Apr 2004, Takashi Iwai wrote:

> At Thu, 8 Apr 2004 10:59:50 +0530,
> Pavana Sharma wrote:
> > 
> > yes, I did this as root ..
> 
> hmm, it works for me.
> 
> 	# echo 'VOLUME "Line Playback" 0' > /proc/asound/card0/oss_mixer
> 	# cat /proc/asound/card0/oss_mixer  | grep VOLUME
> 	VOLUME "Line Playback" 0

Shell problem? The embedded devices has stripped things.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
