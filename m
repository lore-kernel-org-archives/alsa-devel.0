From: Francisco Moraes <fmoraes@nc.rr.com>
Subject: EMU10K1X and MIDI
Date: Mon, 05 Jul 2004 22:15:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40EA0B37.7040409@nc.rr.com>
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

I added MIDI support for the EMU10K1X driver by slightly adapting the 
code in th emumpu401.c file. Given that I barely changed anything in 
that file, I was thinking about moving all the code into a .h file which 
can be parametrized with some #define's and #ifdef's. Then, both the 
current file, the emu10k1x.c and audigyls.c drivers can reuse the same 
code without having to duplicate it.

Is that ok with everyone?

Francisco


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
