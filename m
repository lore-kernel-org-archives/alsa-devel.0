From: Andrei Boros <andrei@srr.ro>
Subject: sequencer module problems
Date: Wed, 19 Mar 2003 12:45:16 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E784A3C.133F177B@srr.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

First of all, my make is 3.77 and lacks support for the  $(if
CONDITION,THEN-PART[,ELSE-PART])
function. So I tried to replace it by some sort of equivalent selected
by existing conditionals. 

As make does not support the syntax below, it ignore it. 

in alsa-driver/alsa-kernel/core/seq:
#
# this function returns:
#   "m" - CONFIG_SND_SEQUENCER is m
#   <empty string> - CONFIG_SND_SEQUENCER is undefined
#   otherwise parameter #1 value
#

sequencer = $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(1),m),$(if
$(CONFIG_SND_SEQUENCER),$(1)))


After reading some docs, I understand the following:
CONFIG_SND_SEQUENCER=m (actually set to anything but "y") -> if $(1) is
defined -> sequencer=m
CONFIG_SND_SEQUENCER=y -> sequencer=$(1), since the subsequent test will
always see it defined.
CONFIG_SND_SEQUENCER undefined -> sequencer = 


I checked the configure script and CONFIG_SND_SEQUENCER is set to "m" if
--with-sequencer=yes or is left undefined otherwise. So any other value
for CONFIG_SND_SEQUENCER is not possible. 

I checked that Makefile again and I see that all calls to the function
sequencer add $(RAWMIDI_OBJS), only some add $(OPL3_OBJS) and some add
individual modules. 

Then I believe the following could be done:

-obj-$(CONFIG_SND_SEQUENCER) += snd-seq.o snd-seq-device.o
+obj-$(CONFIG_SND_SEQUENCER) += snd-seq.o snd-seq-device.o
$(RAWMIDI_OBJS)

Then, 

# Toplevel Module Dependency
obj-$(CONFIG_SND_VIRMIDI) += snd-seq-virmidi.o snd-seq-midi-event.o
ifeq ($(CONFIG_SND_SEQUENCER),m)
obj-$($(CONFIG_SND_SERIAL_U16550)) +=
obj-$($(CONFIG_SND_MTPAV)) += 
obj-$($(CONFIG_SND_MPU401)) += 
obj-$($(CONFIG_SND_ALS100)) += $(OPL3_OBJS)
obj-$($(CONFIG_SND_AZT2320)) += $(OPL3_OBJS)
obj-$($(CONFIG_SND_DT019X)) += $(OPL3_OBJS)
[snip]
obj-$($(CONFIG_SND_CS46XX)) += 
obj-$($(CONFIG_SND_EMU10K1)) += snd-seq-midi-emul.o snd-seq-virmidi.o
obj-$($(CONFIG_SND_TRIDENT)) += snd-seq-midi-emul.o snd-seq-instr.o
obj-$($(CONFIG_SND_YMFPCI)) += $(OPL3_OBJS)
obj-$($(CONFIG_SND_USB_AUDIO)) += 
obj-$($(CONFIG_SND_HDSP)) += 
endif

obj-m := $(sort $(obj-m))

Then, the sequencer function above is no longer needed.


-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
