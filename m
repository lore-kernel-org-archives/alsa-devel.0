From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: [Alsa-devel] Adding a alsa mixer interface
	to	ibm-acpi
Date: Wed, 7 Mar 2007 21:38:06 -0300
Message-ID: <20070308003806.GC12070@khazad-dum.debian.net>
References: <s5h649pue8z.wl%tiwai@suse.de>
	<20070226162819.GE2909@khazad-dum.debian.net>
	<s5hr6scswnp.wl%tiwai@suse.de>
	<20070226174145.GF2909@khazad-dum.debian.net>
	<20070227015024.GF8154@thunk.org>
	<20070227021402.GC6828@khazad-dum.debian.net>
	<s5hd53kaf5r.wl%tiwai@suse.de>
	<41840b750703071512o1d171dfy9d2a615382e5e635@mail.gmail.com>
	<20070307234240.GA12070@khazad-dum.debian.net>
	<1173311709.4531.30.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1173311709.4531.30.camel-lPoCD4h/KdUU2NE2KMwFWnnhMCiq3JZZ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tobin Davis <tdavis-TKBhMlbpEWrk1uMJSBkQmQ@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Theodore Tso <tytso-3s7WtUTddSA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 07 Mar 2007, Tobin Davis wrote:
> Another question comes to mind.  Why would the volume need to be
> controlled if there is no sound driver to generate sound?  I'm trying
> to understand the usage model here for that aspect.

Because the firmware will happly beep away, and you may want to control the
volume of those beeps.  And it also controls the volume of the PC buzzer
(the BIOS makes sure whatever sound hardware is in the machine lets that one
through by default).

> As to the firmware controlling the sound mixer when drivers are loaded,
> what about creating an unsolicited event situation that is specifically
> masked to each control?  That would be an easy addition to the hda codec
> drivers (not sure about AC'97).

I can deal with that just fine, but I'd still need to somehow tell all
codecs (not just hda, ac97 -- let's make this generic) that I am providing
such an interface, and that I want an extra (monoaural in the case of
thinkpads, others might want stereo) global (volume/tone/whatever) mixer
control, that can produce such events.

And the interface needs to be bidirectional, so that I can update the
control.

And I need to be able to pinpoint which card should add this interface, so
that I can track down the correct embedded card (using model-specific
knowledge) and, e.g., exclude USB and CardBus sound cards...  that means I
need to somehow access for every card in the system what bus and busID it is
hanging off.

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
