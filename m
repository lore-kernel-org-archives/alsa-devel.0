From: Francisco Moraes <fmoraes@nc.rr.com>
Subject: Pate plugin problem?
Date: Mon, 05 Jul 2004 09:03:54 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40E951BA.1080609@nc.rr.com>
References: <40E59061.10605@superbug.demon.co.uk> <s5hd63e8hlm.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd63e8hlm.wl@alsa2.suse.de>
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

On the EMU10K1X driver, when I capture sound at 48000, everything sounds 
good. Whenever I use a lower sample rate, the sound has noticeble cracks.

It seems this is a problem in the rate conversion plugin. Has anyone 
tested this kind of downward rate conversion sucessfully? Any 
suggestions on how to find/fix the problem?

Francisco


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
