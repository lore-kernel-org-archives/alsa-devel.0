From: Joachim Blaabjerg <styx@gentoo.org>
Subject: Re: Fwd: [Alsa-user] VIA VT8235 (ALC201) problems
Date: Wed, 16 Oct 2002 18:03:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210161803.48330.styx@gentoo.org>
References: <200210161628.19666.styx@gentoo.org> <s5hk7ki5rdp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk7ki5rdp.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 16 October 2002 17:34, Takashi Iwai wrote:
> Hi,
>
> please try the cvs version.
> the via8233 (and via686) driver has been changed much on cvs since
> 0.9.0rc3.  now they are merged as a unifed module "snd-via82xx".

Thanks for the tip. Didn't make a difference, though. Alsa-mixer now sees t=
he=20
card as "VIA 8233A/C" as opposed to "VIA 8233", but it's still not "VIA=20
8235". Looking at the comment at the top of the file, it seems to be=20
supported, but looking at the code, I see this:

    switch (chip_type) {
    case TYPE_VIA686:
        strcpy(card->driver, "VIA686A");
        strcpy(card->shortname, "VIA 82C686A/B");
        break;
    case TYPE_VIA8233:
        strcpy(card->driver, "VIA8233");
        strcpy(card->shortname, "VIA 8233A/C");
        break;
    default:
[...]

And this:

static struct pci_device_id snd_via82xx_ids[] __devinitdata =3D {
    { 0x1106, 0x3058, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_VIA686, }, /* 686A=
 */
    { 0x1106, 0x3059, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_VIA8233, },    /*=
=20
VT8233 */
    { 0, }
};

It doesn't look to me like the 8235 chip is supported..?

Best Regards,


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
