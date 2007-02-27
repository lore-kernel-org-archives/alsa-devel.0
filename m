From: Theodore Tso <tytso-3s7WtUTddSA@public.gmane.org>
Subject: Re: [Alsa-devel] Adding a alsa mixer interface to
	ibm-acpi
Date: Mon, 26 Feb 2007 20:50:24 -0500
Message-ID: <20070227015024.GF8154@thunk.org>
References: <20070225012017.GA19039@khazad-dum.debian.net>
	<s5h649pue8z.wl%tiwai@suse.de>
	<20070226162819.GE2909@khazad-dum.debian.net>
	<s5hr6scswnp.wl%tiwai@suse.de>
	<20070226174145.GF2909@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070226174145.GF2909-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 26, 2007 at 02:41:45PM -0300, Henrique de Moraes Holschuh wrote:
> Well, adding a new card that only has a mixer and no PCM or other sound
> properties seems to work just fine, and it is *much* simpler than piggying
> back a new *system global* control on top of AC97, many HDA chips, etc.  It
> is also that much easier to deal with.
> 
> Can I keep it as a separate card?

I guess I'm wondering what value is added by exporting it as a
separate ALSA card.  Ideally it should be integrated into the
thinkpad's real sound card.  Otherwise sound applications will have no
idea that this separate mixer-only sound card has anything to do with
the main speaker output (as compared to the Skype headset I have
plugged into the USB port).  

I suppose it does mean you can use alsamixer to manipulate the sound,
but from the user's point of view, if it's not visible when they right
clock on the mixer applet (because it's not associated with the
laptop's primary sound card), is it really that useful?

Regards,

					- Ted

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
