From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: spdif setup
Date: Sun, 03 Jul 2005 16:49:13 +0100
Message-ID: <42C808F9.1050200@superbug.co.uk>
References: <Pine.LNX.4.56.0507111229490.12873@www.ithos.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.56.0507111229490.12873@www.ithos.nl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Cc: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Ronald S. Bultje wrote:
> Hi,
> 
> Use case for the average user:
> * have a cool new soundcard and the box says "HOT NEW SPDIF AC3!!11" [*]
> * start Totem
> * don't get AC-3 passthrough
> 

I don't see what the problem is.
start totem, edit->preferences->audio->audio_output_type=AC3 passthru.

It should then work.

If it fails, send us the output of:
cat /proc/asound/cards
cat /proc/asound/version


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
