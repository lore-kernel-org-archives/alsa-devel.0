From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Adding a alsa mixer interface to ibm-acpi
Date: Sat, 24 Feb 2007 23:20:17 -0200
Message-ID: <20070225012017.GA19039@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hello,

I am the current maintainer of the ibm-acpi driver for the Linux kernel.
Those of you that own a ThinkPad notebook probably know what I am talking
about.

A ThinkPad notebook has a hardware mixer for volume control (two functions:
volume and mute).  The user can interact with this volume control using
three buttons (up/down/mute), and it is completely implemented in firmware.

ibm-acpi currently exports those controls through a procfs interface, but I
am trying to get rid of it, and instead of just porting the interface to
sysfs attributes, I tried to write a proof-of-concept alsa mixer -- if it is
a mixer, it should be exported as one, not as some driver-specific sysfs
attributes, IMHO :-)

It worked almost perfectly, and it was easy to write.  Many thanks to
Takashi Iwai for his excellent docs at
http://www.alsa-project.org/~iwai/writing-an-alsa-driver/index.html.

The only issue was in userspace, apparently alsamixer ignores VOLATILE
controls and doesn't poll them for updates.  I wonder how widespread such
misbehaviour is?  I may have to write an in-driver polling thread so that I
can send notifications, if it is too widespread.

Anyway, the driver is *not* a stand-alone module, but rather just a small
part of ibm-acpi.  I suppose I could break it into two modules so that the
alsa mixer has its own module, but either it would *have* to depend on
ibm-acpi, or it would have to duplicate a lot of thinkpad specific stuff.

How do you guys feel about an in-tree module that has alsa stuff in it, but
is not part of the alsa tree?  Would that be a problem?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
