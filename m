From: Free Ekanayaka <free@centrotemporeale.it>
Subject: Re: Cards PCI ids
Date: Wed, 6 Nov 2002 11:27:13 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211061122110.1250-100000@localhost>
References: <s5hlm479b77.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlm479b77.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 05/11/02  Takashi Iwai wrote...


> > static struct pci_device_id snd_audiopci_ids[] __devinitdata = {
> > #ifdef CHIP1370
> >         { 0x1274, 0x5000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /*
> > ES1370 */
> > #endif
> > #ifdef CHIP1371
> >         { 0x1274, 0x1371, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /*
> > ES1371 */
> >         { 0x1274, 0x5880, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /*
> > ES1373 - CT5880 */
> >         { 0x1102, 0x8938, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /*
> > Ectiva EV1938 */
> > #endif
> >         { 0, }
> > };
> >
> > I hope it will help you.
>
> or, you can check the file /lib/modules/VERSION/modules.pcimap,
> which holds the all entries for pci modules (although it's a bit
> cryptic :)
>
>

Thank you a lot for the indication. I think modules.pcimap is the
straighter way, as it simply contains what I want:

module_name vedor_id device_id (+other information, useless in this case)

Free




-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
