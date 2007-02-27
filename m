From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] Adding a alsa mixer interface to
	ibm-acpi
Date: Mon, 26 Feb 2007 23:14:02 -0300
Message-ID: <20070227021402.GC6828@khazad-dum.debian.net>
References: <20070225012017.GA19039@khazad-dum.debian.net>
	<s5h649pue8z.wl%tiwai@suse.de>
	<20070226162819.GE2909@khazad-dum.debian.net>
	<s5hr6scswnp.wl%tiwai@suse.de>
	<20070226174145.GF2909@khazad-dum.debian.net>
	<20070227015024.GF8154@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20070227015024.GF8154@thunk.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Theodore Tso <tytso@mit.edu>
Cc: Takashi Iwai <tiwai@suse.de>, ibm-acpi-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Feb 2007, Theodore Tso wrote:
> thinkpad's real sound card.  Otherwise sound applications will have no
> idea that this separate mixer-only sound card has anything to do with
> the main speaker output (as compared to the Skype headset I have
> plugged into the USB port). 

True.  That's the downside.   The upside is that we don't need to create a
new API to allow the piggy-back.  After all, the real soundcard module could
get loaded *after* ibm-acpi... or it could be removed before ibm-acpi.  The
"piggy-back mixer control" would need an API with full hotplug semanthics.

> I suppose it does mean you can use alsamixer to manipulate the sound,
> but from the user's point of view, if it's not visible when they right
> clock on the mixer applet (because it's not associated with the
> laptop's primary sound card), is it really that useful?

If they got a mixer applet worth something, it will list two cards, or allow
them to have two instances, one for each card.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
