From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: USB disconnect problem.
Date: Wed, 16 Jul 2003 15:54:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F15671D.7090209@superbug.demon.co.uk>
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

Hi,

I have been doing tests with the alsa snd-usb-audio module.
If I have an application that calls: -
wait_result = snd_pcm_wait(this->audio_fd, 1000000);
and I happen to unplug the usb device during this call, it never ever 
returns from the call, even after the timeout.

Does anyone have a patch to fix this, or shall I start looking into it.
Cheers
James



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
