From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [V2 PATCH] ALSA: hda - Enable mute/mic-mute LEDs
 for more Thinkpads with Conexant codec
Date: Sat, 27 Jun 2015 12:50:44 -0300
Message-ID: <20150627155044.GA3054@khazad-dum.debian.net>
References: <53B52146.9050300@canonical.com> <55603F22.8070103@web.de>
 <CAN8cciZYZ4setSj7dgPqQUVrBrr98tSvofLrD_0zvyQqkWfd2Q@mail.gmail.com>
 <5560A93E.7060607@web.de> <558A4216.8010401@web.de>
 <558A6E80.7010003@canonical.com> <558BDFD4.9060301@web.de>
 <558CB778.5020307@canonical.com>
 <20150626224946.GA11254@khazad-dum.debian.net>
 <558E3BDE.5070708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 2F9D926062F
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 17:50:48 +0200 (CEST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 40C5220AC7
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 11:50:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <558E3BDE.5070708@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jan Kiszka <jan.kiszka@web.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Hui Wang <jason77.wang@gmail.com>, tiwai@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hui Wang <hui.wang@canonical.com>, alex.hung@canonical.com, Raymond Yau <superquad.vortex2@gmail.com>, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

On Sat, 27 Jun 2015, Jan Kiszka wrote:
> > Please explain _in detail_ what you mean with "changing a power button to a
> > reset button by acessing the SSMS ACPI method in a X121e".
> > 
> > Are we trigering a bug somewhere that crashes the x121e and causes it to
> > reboot?
> 
> Well, there aren't much details to describe in this case: When this
> patch is applied and I press the power button, the device performs a
> hard reset. It doesn't reveal if the kernel crashes catastrophically,
> causing a triple fault or so, or if the firmware decides to reset the
> platform. Reverting the patch or preventing its effect via a quirk
> filter like I posted [1] makes the issue go away.

Ok, so we crashing the firmware, and on a box that is not likely to get
further updates.  Well, this is a pretty clear case: blacklist.

Since calling SSMS in the X121e is unsafe, it needs to be blacklisted in
thinkpad-acpi.  I will need dmidecode output for that (please XXX-out UUIDs
and serial numbers in the dmidecode output before you send it to me, but do
keep model numbers intact).

We can also have a blacklist in ALSA to avoid the whole symbol_request() for
something that will have to fail, of course.  I leave that for the ALSA
maintainers to decide.

That said, you blacklisted in ALSA by full codec->subsystem_id.  Which
thinkpads have the 0x17aa21ec subsystem ID on the codec?  Just the x121e?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
