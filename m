From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Strange alsa mixer controls
Date: Wed, 16 Jul 2003 18:16:49 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F158881.5090904@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Simple mixer control 'Mic Select',0
   Capabilities:
   Mono:

I get this with a SB Live and also other sound cards.
I think that it should be an on/off switch, but there seems to be no way 
to actually switch it on and off in amixer or alsamixer.

Other entries are like
Simple mixer control 'Mic Boost (+20dB)',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [off]
which is fine.

So, what are these controls like "Mic Select" for, and how does one get 
them to work in alsamixer.

Cheers
James



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
