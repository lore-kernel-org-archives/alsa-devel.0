From: fmoraes@nc.rr.com
Subject: emu10k1 emumpu401.c again
Date: Tue, 20 Jul 2004 19:59:53 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <23bc05323b53fb.23b53fb23bc053@southeast.rr.com>
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

Ok, I've got MIDI working on the emu10k1x now (tested input with a real keyboard), so I am getting ready to submit my patch, but I'd like to make the code more common, given that the AudigyLS driver will probably work the same way.

So, instead of changing the existing code too much, what about adding some #ifdef's in the existing emumpu401.c code to:
- not include any files (so that the emu10k1x/audigyls drivers can have their includes and structures)
- have an #ifdef to disable the audigy 2 MIDI ports code

This should minimize all changes to that module and allow for code reuse.

If the owner of the file disagrees, I will just submit my patch as is, with the code inlined (no changes other than change which structure is used as I define which interrupts are used for TX/RX) and what the PTR register is.

Please let me know, so that I can submit all my current changes tomorrow.

Francisco



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
