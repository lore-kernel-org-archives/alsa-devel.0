From: Ove Kaaven <ovek@transgaming.com>
Subject: Re: PCM hw mixing with volume
Date: Wed, 10 Mar 2004 15:40:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078929621.18054.256.camel@renegade>
References: <XFMail.20040310104621.pochini@shiny.it>
	 <1078928193.18054.247.camel@renegade>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078928193.18054.247.camel@renegade>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

ons, 10.03.2004 kl. 15.16 skrev Ove Kaaven:
> * Volume
> * Pan (not available if 3D sound is requested)
> * Frequency (can be used for software-calculated doppler shift, or for
> "wavetable synthesis"-like purposes)
> * 3D position (relative to listener)
> * Velocity (for hardware-calculated doppler shift)
> * Cone inside/outside angles, direction, outside volume
> * Min/max distance (wherever the sound is heard)

Correction: Min distance is where the sound does not get any louder if
you get closer. Max distance is where the sound does not get any softer
if you get further away. Whether the sound is heard or not when over max
distance is optional, and should also be a parameter if min/max distance
is.

In any case, most of this can all be handled by software. The only stuff
the hardware really need is the volume, frequency, direction to sound
source, and any additional effects (such as reverb). Application
software can deal with the rest.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
