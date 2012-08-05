From: "Brand, Mark (Mr) (Summerstrand Campus South)" <Mark.Brand@nmmu.ac.za>
Subject: Gitcompile for Kernel 3.2?
Date: Sun, 5 Aug 2012 13:25:18 +0000
Message-ID: <35FE09CFAB387A4BA7ACDDED49F345181D00D8@CRETE.nmmu.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from osiris.nmmu.ac.za (osiris.nmmu.ac.za [196.21.198.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 81AA126532C
 for <alsa-devel@alsa-project.org>; Sun,  5 Aug 2012 14:55:53 +0200 (CEST)
Received: from TUKTUK.nmmu.ac.za (tuktuk.nmmu.ac.za [10.103.121.195])
 by osiris.nmmu.ac.za (8.13.8/8.13.8) with ESMTP id q75DPMli030638
 for <alsa-devel@alsa-project.org>; Sun, 5 Aug 2012 15:25:26 +0200
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

Having cloned alsa-driver and alsa-kmirror, my gitcompile and sudo make install-modules goes smoothly.  However, the modules won't load.  First errors in dmesg are:
[   24.415466] snd_hwdep: disagrees about version of symbol snd_info_register
[   24.415475] snd_hwdep: Unknown symbol snd_info_register (err -22)
[   24.415489] snd_hwdep: disagrees about version of symbol snd_info_create_module_entry
[   24.415495] snd_hwdep: Unknown symbol snd_info_create_module_entry (err -22)
... and so on.  My initial assumption is that kmirror is specific to a 2.6 kernel, while I'm running 3.2, though some of what I've read seems to contradict this.  I've tried foregoing kmirror for a full 3.2 kernel source, but that failed on gitcompile.  I also tried with kmirror on a 2.6 kernel, but those modules also failed to load.  I initially thought my problems stemmed from trying to do this against a lowlatency kernel, but I've subsequently had the same against vanilla Ubuntu kernels.  Would someone kindly point me in the right direction?
* Is it possible to compile and load a subset of alsa modules without having full kernel sources on hand?
* If so, is this restricted to particular kernels (docs seem to suggest 2.6, 3.0 and 3.2 are supported)?
* If not, is alsa-driver expected to compile against 3.2 sources as is (mine fails on some of the patching - presumably the make dep step)?
* Does the alsa-driver.new.git merge address this, or is development expected to take place in a 2.6 environment?

Sorry if any or all of this is incoherent (please help me to clarify), but any pointers would be greatly appreciated.  What might be pertinent: Ubuntu 12.04 (kernels 3.2.0 and 2.6.38 tested), gcc 4.6.3, anything else?  I am attempting to add device support for a multi-port MIDI interface.  I managed to get a working prototype running a year ago, but had to shelve the project due to work pressures.  I'd really love to get it back up and submitted.

Kind regards,
Mark Brand.


________________________________

NOTICE: Please note that this eMail, and the contents thereof, is subject to the standard NMMU eMail disclaimer which may be found at:
http://www.nmmu.ac.za/disclaimer/email.htm
