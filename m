From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Sound card DMA questions.
Date: Tue, 20 Jul 2004 02:18:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40FC72D4.1040900@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

With DMA accesses, one has a sound card connected to a PCI bus, which is 
then connected to the RAM.

The sound card will schedule a DMA transfer.

My questions are:
1) What size is the DMA transfer?
2) Are the min/max limits on how many bytes can be passed on a transfer?
3) When does the transfer happen. At period boundarys or when ?
4) What triggers a user land poll() to return. An irq based 
snd_period_elapsed() call, or something else?

And finally,
5) if I am reverse engineering a card, how can I discover these min/max 
values?

James


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
