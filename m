From: Marcus Andersson <054185595@telia.com>
Subject: HDSP start problem
Date: Mon, 24 Jun 2002 19:17:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D17542B.FCCC63EB@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I sometimes get this output when trying to start ALSA:

Starting sound driver: snd-hdsp PCI: Found IRQ 10 for device 00:0d.0
PCI: Sharing IRQ 10 with 00:07.2
PCI: Sharing IRQ 10 with 00:07.3
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:452: wait for FIFO status <= 0
failed 
after 100 iterations
looks like a multiface
done

When this happens, the card will not work. I must reboot and hope it
doesn't happen again.

Marcus


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
