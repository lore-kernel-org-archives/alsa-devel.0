From: Mark Knecht <markknecht@attbi.com>
Subject: PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP
Date: 09 Dec 2002 19:42:23 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1039491744.1340.20.camel@Godzilla>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>, Alsa-List <linux-audio-user@music.columbia.edu>
List-Id: alsa-devel@alsa-project.org

Hi,
   Where are the definitions for PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP and
PCI_VENDOR_ID_XILINX kept in the alsa code? 

Thanks,
Mark


static struct pci_device_id snd_hdsp_ids[] __devinitdata = {
        {
                .vendor    = PCI_VENDOR_ID_XILINX,
                .device    = PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP,
                .subvendor = PCI_ANY_ID,
                .subdevice = PCI_ANY_ID,
        }, /* RME Hammerfall-DSP */
        { 0, },
};





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
