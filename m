From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Error: firmware not found
Date: Mon, 24 Jan 2005 09:41:43 +0100 (CET)
Message-ID: <XFMail.20050124094143.pochini@shiny.it>
References: <1106447855.2368.29.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1106447855.2368.29.camel@cmn37.stanford.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 23-Jan-2005 Fernando Lopez-Lezcano wrote:

>> - In /etc/hotplug/pci.agent:pci_map_modules() at line 123 I had to rem=
ove
>> the break, otherwise the loop stops as soon as it finds the first matc=
hing
>> PCI ID. This is not good because some cards (in my case the Layla3G an=
d the
>> Gina3G) have the same PCI card, but different external module.
>
> Could you expand on this? What is the result of using an unmodified
> hotplug? Wrong firmware loaded? (fc3 ships with hotplug-2004_04_01-8.1
> which I presume would have the problem)

I don't know if there are other devices that have the same PCI card
and different "box" (not necessarily an audio device). The Gina3G
and Layla3G have different driver, but same PCI card. For example I
have a Gina3G. If in /lib/modules/x.x.x/modules.pcimap the Layla3G
module is listed before the Gina3G the original hotplug script loads
snd-layla3g *only* which, obviously, fails.
With that change pci_map_modules() return all matching modules, so
it fixes the problem. BUT, there is a comment before that function
that says it returns "ONE" (all uppercase) module only. It means
it was done on purpose, but I can't see why.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
