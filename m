From: Manuel Jander <manuel.jander@gmail.com>
Subject: iPAQ H5xxx audio driver
Date: Wed, 08 Mar 2006 23:33:15 +0100
Message-ID: <1141857195.24748.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi everyone,

After hacking some code snippets and patches together (inluding the
duplex locking patch), I got a partially working ALSA driver for the
AK4535 codec found on iPAQ H5xxx handhelds.

Native ALSA apps cause a segfault when accesing the device (inside of
snd_pcm_writei() ), but when using the OSS emulation, it works fairly
stable.

Playing around with the ..._MMAP and ..._MMAP_VALID info changed
somewhat the segfaulting behaviour, so I guess that kernel mmap
functionality could be part of the problem. For some few times aplay did
even work without segfaulting, when the ...MMAP_VALID flag was removed
from the info field.

The iPAQ does not seem to have a PCI bus and the current ALSA driver
tree does not compile cleanly for this target (requires some few
preprocessor macro changes). I'm using (at least I think I do so) ISA
bus coherent memory allocation methods for the DMA buffers.

I'm using familiar's linux 2.4.19-rmk6-hh37 kernel on a iPAQ H5550 with
Familiar 8.3 (Did anyone got linux 2.6 working on this thing ?) I really
would like to use a "most close to" vanilla kernel, but I not having
success with that so far.

Has anyone any experience to tell with this device ?

Thanks.

Manuel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
