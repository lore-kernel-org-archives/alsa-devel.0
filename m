From: Graham Leggett <minfrin@sharp.fm>
Subject: Re: [Alsa-user] Request for test of powermac driver
Date: Wed, 22 May 2002 19:49:36 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <acqdvh$egi$2@main.gmane.org>
References: <s5hn0v15p95.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> i've updated snd-powermac driver on cvs.
> so far, a G3 desktop (with screamer) was confirmed to work, but the
> others are not tested.
> thus i'd like to ask you powermac users to update and test the driver,
> and give me the feedback whether it works or not.

Just tried it, and playback works!!! Will give gnomemeeting a try
tomorrow and see if recording works.

AWACS chip, 1999 Powerbook G3.

> a new feature of the driver is "automatic muting".
> it's supported on awacs/screamer, burgundy and tumbler chips.
> when the headphone is plugged/unplugged, then the mute switch is
> changed automatically.
> this feature is disabled by turning "Auto Mute Switch" control off.

Works here.

> also, screamer driver has now more controls, bass/treble and
> amp. master volume, headphone volume/mutes.
> 
> the tumber was improved at the last update, supporting bass/treble and
> DRC (dynamic-range compression) controls.

Any new sliders in the AWACS driver? The CD, Line and Mic levels are
still not changeable, but at least I am getting sound! :)

Regards,
Graham
-- 
-----------------------------------------
minfrin@sharp.fm		"There's a moon
					over Bourbon Street
						tonight..."



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
