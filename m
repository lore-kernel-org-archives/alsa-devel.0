From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: snd-usb-usx2y 0.8.5 against alsa-kernel cvshead: OHCI doesn't
 crash anymore
Date: Mon, 25 Oct 2004 23:10:25 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32787.192.168.1.5.1098742225.squirrel@192.168.1.5>
References: <200409302046.29798.annabellesgarden@yahoo.de>
    <200410200228.16228.annabellesgarden@yahoo.de>
    <s5hacuhivfb.wl@alsa2.suse.de>
    <200410212021.22349.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200410212021.22349.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, Karsten Wiese <annabellesgarden@yahoo.de>
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:
>
> Summary: Fixes crashes that occured when communicating over ohci usb-hcds.
>
> Work on this started, when rumors spread that ohci equipped machines would
> crash.
> This was due to me missing two facts:
> 1) Ohci has a bigger usb frame number wrap around.
> 2) It only supports URB_ISO_ASAP when submitting iso urbs.
> Fixed now.
>
> Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
>

May I ask what's the status of this, wrt.including snd-usb-usx2y version
0.8.5 on the official alsa-kernel tree?

People seem to be happy with it, specially the OHCI owners, for whom the
current alsa-driver-1.0.7rc2/CVS is badly broken and causes a serious
kernel oops (bug #0000425).

I hope it makes into 1.0.7 release :)

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
