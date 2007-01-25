From: Konstantin Kletschke <konsti@ku-gbr.de>
Subject: Re: A: VIA Technologies Inc. VT1720/24
Date: Thu, 25 Jan 2007 15:22:28 +0100
Message-ID: <20070125142227.GA11256@synertronixx3>
References: <45AFE785.6020307@informatik.uni-oldenburg.de>
	<45B74CC0.4060905@svs.Informatik.Uni-Oldenburg.de>
	<s5hac08cvct.wl%tiwai@suse.de>
	<20070125101319.GA3340@titan.lahn.de>
	<20070125123620.GA8634@synertronixx3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20070125123620.GA8634@synertronixx3>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am 2007-01-25 13:36 +0100 schrieb Konstantin Kletschke:

> ALSA /XXX/alsa-kernel/pci/ice1712/aureon.c:1921: No CS8415
> chip. Skipping CS8415 controls.
> 
> In the note (0014176) I am trying to search it at the i2c address it
> should appear at. Still I did not found it :-)

Okay, I got the CS8451 at the i2c bus, I had to left shift my bitmask
to get the idea of how i2c addressing works:

        printk(KERN_DEBUG "addr_cs: %02x value 0x7F: %02x\n",
               addr_cs, snd_vt1724_read_i2c(ice, addr_cs, CS8415_ID));
        printk(KERN_DEBUG "addr_cs: %02x value 0x7F: %02x\n",
               addr_cs, snd_vt1724_read_i2c(ice, addr_cs+1,
	       CS8415_ID));
gives:

i2c_read: [0x2e,0x7f] = 0x41
addr_cs: 2e value 0x7F: 41
i2c_read: [0x2f,0x7f] = 0x41
addr_cs: 2e value 0x7F: 41

Hmmm...


-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
