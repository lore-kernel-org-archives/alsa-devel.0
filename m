From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] Adding a alsa mixer interface to
	ibm-acpi
Date: Mon, 26 Feb 2007 14:41:45 -0300
Message-ID: <20070226174145.GF2909@khazad-dum.debian.net>
References: <20070225012017.GA19039@khazad-dum.debian.net>
	<s5h649pue8z.wl%tiwai@suse.de>
	<20070226162819.GE2909@khazad-dum.debian.net>
	<s5hr6scswnp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hr6scswnp.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ibm-acpi-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Feb 2007, Takashi Iwai wrote:
> > It is not directly related to the sound card *at* *all*.  It is done by the
> > thinkpad embedded controller firmware.
> > 
> > So, it really is a "different card", and doesn't belong in any of the many
> > sound card drivers that work on the various thinkpad models.  Since it is
> > only one extra mixer control, if the API allows it, we *could* piggy back it
> > on the mixer for the real sound card, but that looks like extra complexity
> > and layering violations for no good reason to me.
> 
> Hm, I think the problem is how to export the sound card object to the
> outside.  Currently the created instance is closed in the ALSA tree,
> and there is no direct way to get the pointer from another driver.
> That's why I thought of including the code in the ALSA tree.  But, we
> can add an export to enable the hook in each card driver code.

Well, adding a new card that only has a mixer and no PCM or other sound
properties seems to work just fine, and it is *much* simpler than piggying
back a new *system global* control on top of AC97, many HDA chips, etc.  It
is also that much easier to deal with.

Can I keep it as a separate card?

> > If I have it as a separate snd-thinkpadmixer module or somesuch, that module
> > will need some code from the main ibm-acpi module to work.  It needs the
> > ACPI bus, and also thinpad-specific knowledge...  sounds messy to have it on
> > a different tree, thus the question about how complicated would it be to
> > have it in the ibm-acpi driver instead of submitting it for the alsa tree.
> 
> I think it's no big problem to leave it in another tree since the
> control API is fairly stable right now.

Then I should have a proper version of the thinkpad volume control as an
alsa mixer ready soon, registering it as a separate card.  I can change that
to a piggy-back mixer control later, if you'd rather I did that.

The ibm-acpi module does not follow the module parameter specs of alsa sound
modules, is that a problem?  I don't expect alsa configurator tools to ever
deal with the ibm-acpi mixer, but...

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
