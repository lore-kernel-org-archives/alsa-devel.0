From: Djamel Ouerdane <ouerdane@nbi.dk>
Subject: buggy ESS maestro 2E driver
Date: Tue, 22 Jul 2003 18:22:56 +0200 (CEST)
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307221734110.20898-100000@hilux02.nbi.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-user-admin@lists.sourceforge.net>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I know this one is a known bug, as far as I could see from ealier messages
but I thought I would repeat it once more: the driver snd-es1968
handling the sound card ESS Maestro 2E that can be found in many laptops,
is buggy, you cannot record anything but garbage.

Ok, nothing new here but nowadays, sound utilities, programs, etc, use
ALSA and JACk quite a lot due to high quality and low latency
requirements. And that's great news for the linux community that
open-source projects can compete with professional and often non-free 
audio software. I just want to say here that since ALSA is getting close 
to version 1.0, which means a non development release, it is now urgent to 
get at least basic things to work, like simple sound capture (the OSS free 
driver works fine but many applications now require ALSA and JACK).

As an end user, I logically expect that such an ambitious project can deal
with such a wide spread sound card. I have therefore three options:
either I give up ALSA and all great stuff I could benefit from, 
or I buy a new soundcard (but I don't have any money to spend in it),
or finally, you fix the bug, which is by far the best option :) I guess 
I'm not the only frustrated user in the place, so please, remove the bug 
ASAP.

Thanks.
Djam



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
