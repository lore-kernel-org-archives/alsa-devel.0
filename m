From: fmoraes@nc.rr.com
Subject: emu10k1x/AudigyLS period table
Date: Mon, 28 Jun 2004 22:49:43 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1e6ff561e6a898.1e6a8981e6ff56@southeast.rr.com>
Reply-To: fmoraes@nc.rr.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-language: en
Content-Disposition: inline
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

This the information that James Courtier-Dutton found about the AudigyLS that also works for the emu10k1x:

#define PLAYBACK_LIST_ADDR	0x00		/* Base DMA address of a list of pointers to each period/size */
						/* One list entry: 4 bytes for DMA address, 
						 * 4 bytes for period_size << 16.
						 * One list entry is 8 bytes long.
						 * One list entry for each period in the buffer.
						 */
#define PLAYBACK_LIST_SIZE	0x01		/* Size of list in bytes << 16. E.g. 8 periods -> 0x00380000  */
#define PLAYBACK_LIST_PTR	0x02		/* Pointer to the current period being played */

Is this in anyway similar to the emu10k1 PTB scatter-gather? Just wondering if they reused the design.

Francisco



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
