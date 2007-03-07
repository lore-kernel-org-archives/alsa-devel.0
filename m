From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: [Alsa-devel] Adding a alsa mixer interface to
	ibm-acpi
Date: Wed, 7 Mar 2007 20:02:50 -0300
Message-ID: <20070307230249.GB1796@khazad-dum.debian.net>
References: <20070225012017.GA19039@khazad-dum.debian.net>
	<s5h649pue8z.wl%tiwai@suse.de>
	<20070226162819.GE2909@khazad-dum.debian.net>
	<s5hr6scswnp.wl%tiwai@suse.de>
	<20070226174145.GF2909@khazad-dum.debian.net>
	<20070227015024.GF8154@thunk.org>
	<20070227021402.GC6828@khazad-dum.debian.net>
	<s5hd53kaf5r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5hd53kaf5r.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Theodore Tso <tytso-3s7WtUTddSA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 07 Mar 2007, Takashi Iwai wrote:
> Well, it's a question whether this should be an add-on module or a
> built-in to the sound driver.  From the usability viewpoint, the
> latter is much easier.  Then we have no module loading order problem
> and need no API extension.  Of course, the drawback is that the
> unnecessary growth of the code / binary size for non-thinkpad users.

Which is quite a serious drawback.  I am not at all opposed to writing a
mixer piggy-back, but IMHO if we are going to do it that way, it would be
best to create an API that allows an alsa module to extend the functionality
of another module, *and* provide the proper callbacks to have it work in
full hotplug mode (i.e. it will do the right thing no matter in which way
the modules are loaded, and also if the device is hotplugged or
hotunplugged).

> > > I suppose it does mean you can use alsamixer to manipulate the sound,
> > > but from the user's point of view, if it's not visible when they right
> > > clock on the mixer applet (because it's not associated with the
> > > laptop's primary sound card), is it really that useful?
> > 
> > If they got a mixer applet worth something, it will list two cards, or allow
> > them to have two instances, one for each card.
> 
> I guess it's rather confusing.  Both controls the very same device for
> the very same role in the end, so it'd be better to be merged in some
> level, IMO.

Very well.  Do you want me to start a "requirements" document for the API,
so that we can start walking down that road?

On the ibm-acpi side, I can just merge in the mixer as a separate card for
now, with the proper notices that it is not a stable interface and that it
will go away in the future.

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
