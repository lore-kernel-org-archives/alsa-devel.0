From: "Pavana Sharma" <pavans@india.ti.com>
Subject: RE: OSS mapping for ALSA controls
Date: Thu, 8 Apr 2004 10:59:50 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <031101c41d2a$83ea2a50$f8b6a8c0@ent.ti.com>
References: <s5hhdvvacci.wl@alsa2.suse.de>
Reply-To: <pavans@india.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhdvvacci.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

yes, I did this as root ..

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Wednesday, April 07, 2004 11:40 PM
To: pavans@india.ti.com
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] OSS mapping for ALSA controls


At Wed, 7 Apr 2004 19:38:18 +0530,
Pavana Sharma wrote:
> 
> Hi,
> 
> 	I am trying to map my ALSA driver (for ARM) controls with OSS default
> controls.
> 
> 	I am using this method, to change/update assignment in /proc file.
> 	but I am not seeing any changes in my /proc/asound/card0/oss_mixer file.
> 	% echo 'VOLUME "Master Playback" 0' > /proc/asound/card0/oss_mixer

it should be ok.  did you do it as root?


Takashi



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
