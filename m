From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Audigy 2 emu10k2 with 24bit audio samples.
Date: Mon, 17 May 2004 12:40:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40A8A499.7070504@superbug.demon.co.uk>
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
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I understand the the Audigy 2 DSP (emu10k2) handles 24bits in the DSP at 
a max rate of 48Khz. It uses an as yet undocumented extra chip for 
96/192 Khz.

Does anyone know how we could get the alsa emu10k1 live/audigy driver to 
accept 24bit audio from the application.
At the moment, when I send alsa-lib a 24bit audio sample, it reaches the 
sound card as 16bit.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
