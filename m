From: Patrice Tisserand <Patrice.Tisserand@ircam.fr>
Subject: Re: Cards PCI ids
Date: 04 Nov 2002 16:24:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1036423472.9417.75.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0211041430060.1776-100000@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0211041430060.1776-100000@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Free Ekanayaka <free@centrotemporeale.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2002-11-04 at 15:35, Free Ekanayaka wrote:
> 
> Hi,
> 	I'd like to modify the discover library
> (http://hackers.progeny.com/discover) to use ALSA
> modules names instead of OSS ones when detecting sound devices.
> 
> Is there a place where I can found a mapping like:
> 
> soundcard PCI Id ---> ALSA module name
> 
> ?
> 
Hi, 
I don't know where you can find a such mapping, but maybe you can
extract it from drivers source code.
As far as I know, each pci driver contains a pci_device_id array
initialize with VENDOR_ID and DEVICE_ID of supported pci device.

For example, if you look into ens1370.c you will find:
static struct pci_device_id snd_audiopci_ids[] __devinitdata = {
#ifdef CHIP1370
        { 0x1274, 0x5000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /*
ES1370 */
#endif
#ifdef CHIP1371
        { 0x1274, 0x1371, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /*
ES1371 */
        { 0x1274, 0x5880, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /*
ES1373 - CT5880 */
        { 0x1102, 0x8938, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /*
Ectiva EV1938 */
#endif
        { 0, }
};

I hope it will help you.

Best regards
-- 
Patrice Tisserand --- email:mailto:Patrice.Tisserand@ircam.fr
IRCAM 1 place Stravinsky 75004 Paris FRANCE




-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
