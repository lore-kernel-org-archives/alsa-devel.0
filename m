From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: [Alsa-devel] Adding a alsa mixer interface to
	ibm-acpi
Date: Mon, 26 Feb 2007 13:28:19 -0300
Message-ID: <20070226162819.GE2909@khazad-dum.debian.net>
References: <20070225012017.GA19039@khazad-dum.debian.net>
	<s5h649pue8z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5h649pue8z.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
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
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Feb 2007, Takashi Iwai wrote:
> > The only issue was in userspace, apparently alsamixer ignores VOLATILE
> > controls and doesn't poll them for updates.  I wonder how widespread such
> > misbehaviour is?  I may have to write an in-driver polling thread so that I
> > can send notifications, if it is too widespread.
> 
> That's exactly the role of VOLATILE flag.  It's for controls with
> frequently changing elements (e.g. VU-meters) and thus not suitable
> for poll/select by a mixer app.  I think the case of volume buttons is
> OK to use normal controls without VOLATILE flag.

Well, since these controls change without notice (user might press a volme
button in the keyboard, and the firmware will change the volume by itself),
I will have to poll them myself and send notifications.

> > Anyway, the driver is *not* a stand-alone module, but rather just a small
> > part of ibm-acpi.  I suppose I could break it into two modules so that the
> > alsa mixer has its own module, but either it would *have* to depend on
> > ibm-acpi, or it would have to duplicate a lot of thinkpad specific stuff.
> > 
> > How do you guys feel about an in-tree module that has alsa stuff in it, but
> > is not part of the alsa tree?  Would that be a problem?
> 
> I'm basically for including it in ALSA driver (suppose intel8x0?) as
> long as it's directly related with the sound.  If you have a working
> patch, I'm willing to review and discuss more.

It is not directly related to the sound card *at* *all*.  It is done by the
thinkpad embedded controller firmware.

So, it really is a "different card", and doesn't belong in any of the many
sound card drivers that work on the various thinkpad models.  Since it is
only one extra mixer control, if the API allows it, we *could* piggy back it
on the mixer for the real sound card, but that looks like extra complexity
and layering violations for no good reason to me.

If I have it as a separate snd-thinkpadmixer module or somesuch, that module
will need some code from the main ibm-acpi module to work.  It needs the
ACPI bus, and also thinpad-specific knowledge...  sounds messy to have it on
a different tree, thus the question about how complicated would it be to
have it in the ibm-acpi driver instead of submitting it for the alsa tree.

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
