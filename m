From: Robert Joop <rj@rainbow.in-berlin.de>
Subject: Re: help needed for my AD1816A based soundcard
Date: Sun, 31 Mar 2002 01:48:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020331004854.GH707@rainbow.internal>
References: <20020329230421.GD707@rainbow.internal> <20020330202713.GF707@rainbow.internal> <20020330225341F.siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020330225341F.siemer@panorama.hadiko.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Robert Siemer <siemer@panorama.hadiko.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 02-03-30 22:53:41 MET, Robert Siemer wrote:
> From: Robert Joop <rj@rainbow.in-berlin.de>
> 
> > what makes me wonder is:
> > - at boot time, the BIOS says it initializes the plug and play cards
> >   and detects the sound card, it prints its name.
> > - but the linux ISA PNP does not seem to detect it:
> >   Mar 30 19:20:13 moonbow kernel: isapnp: Scanning for PnP cards...
> >   Mar 30 19:20:13 moonbow kernel: isapnp: No Plug & Play device found
> > - nor does the soundcard driver:
> >   Mar 30 19:20:18 moonbow kernel: ALSA card-ad1816a.c:348: no
> >   AD1816A based soundcards found.
> >
> > i've tried to make some sense of the output of pnpdump(1) and added
> > an entry to snd_ad1816a_pnpids[], but it hasn't helped.
> 
> pnpdump does find the card and 'kernel isapnp' does not? You have a
> problem beyound ALSA.
> 
> What is pnpdump saying? Maybe some parameters to isa-pnp.o can
> help. At least isapnp_verbose I think. Look for MODULE_PARM in 
> linux/drivers/pnp/isapnp.c

isapnp_verbose=2 doesn't produce more output, i've even inserted a printk
line into isapnp_init() to make sure the variable setting in
/etc/modules.conf actually worked...
if i understand the code correctly, the variable ist set to 1 by default
and would have listed all cards found anyway.

Mar 31 01:16:36 moonbow kernel: isapnp: isapnp_verbose=2 [rj]
Mar 31 01:16:36 moonbow kernel: isapnp: Scanning for PnP cards...
Mar 31 01:16:36 moonbow kernel: isapnp: No Plug & Play device found

the pnpdump output is appended.
the line i inserted into
/usr/src/modules/alsa-driver/cards/card-ad1816a.c is

        ISAPNP_AD1816A('L','W','C',0x1060,'A','D','S',0x7180,0x7181),

(but it made no difference).

any suggestions?

--rj

# $Id: pnpdump_main.c,v 1.27 2001/04/30 21:54:53 fox Exp $
# Release isapnptools-1.26
# 
# This is free software, see the sources for details.
# This software has NO WARRANTY, use at your OWN RISK
# 
# For details of the output file format, see isapnp.conf(5)
# 
# For latest information and FAQ on isapnp and pnpdump see:
# http://www.roestock.demon.co.uk/isapnptools/
# 
# Compiler flags:  -DREALTIME -DHAVE_PROC -DENABLE_PCI -DHAVE_SCHED_SETSCHEDULER -DHAVE_NANOSLEEP -DWANT_TO_VALIDATE
# 
# Trying port address 0273
# Board 1 has serial identifier 00 ff ff ff ff 60 10 e3 32

# (DEBUG)
(READPORT 0x0273)
(ISOLATE PRESERVE)
(IDENTIFY *)
(VERBOSITY 2)
(CONFLICT (IO FATAL)(IRQ FATAL)(DMA FATAL)(MEM FATAL)) # or WARNING

# Card 1: (serial identifier 00 ff ff ff ff 60 10 e3 32)
# Vendor Id LWC1060, No Serial Number (-1), checksum 0x00.
# Version 1.0, Vendor version 1.4
# ANSI string -->HIGHSCREEN SOUNDBOOSTAR 32 WAVE 3D<--
#
# Logical device id ADS7180
#     Device supports I/O range check register
#     Device supports vendor reserved register @ 0x3a
#     Device supports vendor reserved register @ 0x3b
#     Device supports vendor reserved register @ 0x3d
#
# Edit the entries below to uncomment out the configuration required.
# Note that only the first value of any range is given, this may be changed if required
# Don't forget to uncomment the activate (ACT Y) when happy

(CONFIGURE LWC1060/-1 (LD 0

# Multiple choice time, choose one only !

#     Start dependent functions: priority preferred
#       IRQ 5.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 5 (MODE +E)))
#       First DMA channel 1.
#             8 bit DMA only
#             Logical device is not a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed type F
# (DMA 0 (CHANNEL 1))
#       Next DMA channel 3.
#             8 bit DMA only
#             Logical device is not a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed type F
# (DMA 1 (CHANNEL 3))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0220
#             Maximum IO base address 0x0220
#             IO base alignment 32 bytes
#             Number of IO addresses required: 16
# (IO 0 (SIZE 16) (BASE 0x0220) (CHECK))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0388
#             Maximum IO base address 0x0388
#             IO base alignment 8 bytes
#             Number of IO addresses required: 4
# (IO 1 (SIZE 4) (BASE 0x0388) (CHECK))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0530
#             Maximum IO base address 0x0530
#             IO base alignment 8 bytes
#             Number of IO addresses required: 16
# (IO 2 (SIZE 16) (BASE 0x0530) (CHECK))

#       Start dependent functions: priority acceptable
#       IRQ 5 or 7.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 5 (MODE +E)))
#       First DMA channel 0, 1 or 3.
#             8 bit DMA only
#             Logical device is not a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed type F
# (DMA 0 (CHANNEL 0))
#       Next DMA channel 0, 1 or 3.
#             8 bit DMA only
#             Logical device is not a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed type F
# (DMA 1 (CHANNEL 0))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0220
#             Maximum IO base address 0x0240
#             IO base alignment 32 bytes
#             Number of IO addresses required: 16
# (IO 0 (SIZE 16) (BASE 0x0220) (CHECK))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0388
#             Maximum IO base address 0x0388
#             IO base alignment 8 bytes
#             Number of IO addresses required: 4
# (IO 1 (SIZE 4) (BASE 0x0388) (CHECK))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0530
#             Maximum IO base address 0x0530
#             IO base alignment 16 bytes
#             Number of IO addresses required: 16
# (IO 2 (SIZE 16) (BASE 0x0530) (CHECK))

#       Start dependent functions: priority functional
#       IRQ 5, 7 or 10.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 5 (MODE +E)))
#       First DMA channel 0, 1 or 3.
#             8 bit DMA only
#             Logical device is not a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed type F
# (DMA 0 (CHANNEL 0))
#       Next DMA channel 0, 1 or 3.
#             8 bit DMA only
#             Logical device is not a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed type F
# (DMA 1 (CHANNEL 0))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0220
#             Maximum IO base address 0x0280
#             IO base alignment 32 bytes
#             Number of IO addresses required: 16
# (IO 0 (SIZE 16) (BASE 0x0220) (CHECK))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0388
#             Maximum IO base address 0x03b8
#             IO base alignment 8 bytes
#             Number of IO addresses required: 4
# (IO 1 (SIZE 4) (BASE 0x0388) (CHECK))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0500
#             Maximum IO base address 0x0560
#             IO base alignment 16 bytes
#             Number of IO addresses required: 16
# (IO 2 (SIZE 16) (BASE 0x0500) (CHECK))

#       Start dependent functions: priority functional
#       IRQ 5, 7, 10 or 11.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 5 (MODE +E)))
#       First DMA channel 0, 1 or 3.
#             8 bit DMA only
#             Logical device is not a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed type F
# (DMA 0 (CHANNEL 0))
#       *** ERROR *** No DMA channel specified!
#             8 bit DMA only
#             Logical device is not a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed type F
# (DMA 1 (CHANNEL 4))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0220
#             Maximum IO base address 0x0280
#             IO base alignment 32 bytes
#             Number of IO addresses required: 16
# (IO 0 (SIZE 16) (BASE 0x0220) (CHECK))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0388
#             Maximum IO base address 0x03b8
#             IO base alignment 8 bytes
#             Number of IO addresses required: 4
# (IO 1 (SIZE 4) (BASE 0x0388) (CHECK))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0500
#             Maximum IO base address 0x0620
#             IO base alignment 16 bytes
#             Number of IO addresses required: 16
# (IO 2 (SIZE 16) (BASE 0x0500) (CHECK))

#       Start dependent functions: priority functional
#       IRQ 5, 7, 9, 10, 11 or 15.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 5 (MODE +E)))
#       First DMA channel 0, 1 or 3.
#             8 bit DMA only
#             Logical device is not a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed type F
# (DMA 0 (CHANNEL 0))
#       *** ERROR *** No DMA channel specified!
#             8 bit DMA only
#             Logical device is not a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed type F
# (DMA 1 (CHANNEL 4))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0220
#             Maximum IO base address 0x0280
#             IO base alignment 32 bytes
#             Number of IO addresses required: 16
# (IO 0 (SIZE 16) (BASE 0x0220) (CHECK))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0388
#             Maximum IO base address 0x03b8
#             IO base alignment 8 bytes
#             Number of IO addresses required: 4
# (IO 1 (SIZE 4) (BASE 0x0388) (CHECK))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0500
#             Maximum IO base address 0x0620
#             IO base alignment 16 bytes
#             Number of IO addresses required: 16
# (IO 2 (SIZE 16) (BASE 0x0500) (CHECK))

#     End dependent functions
 (NAME "LWC1060/-1[0]{HIGHSCREEN SOUNDBOOSTAR 32 WAVE 3D}")
# (ACT Y)
))
#
# Logical device id ADS7181
#     Device supports I/O range check register
#     Device supports vendor reserved register @ 0x3b
#     Device supports vendor reserved register @ 0x3c
#     Device supports vendor reserved register @ 0x3e
#
# Edit the entries below to uncomment out the configuration required.
# Note that only the first value of any range is given, this may be changed if required
# Don't forget to uncomment the activate (ACT Y) when happy

(CONFIGURE LWC1060/-1 (LD 1
#     Compatible device id PNPb006

# Multiple choice time, choose one only !

#     Start dependent functions: priority preferred
#       IRQ 9.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 9 (MODE +E)))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0330
#             Maximum IO base address 0x0330
#             IO base alignment 16 bytes
#             Number of IO addresses required: 2
# (IO 0 (SIZE 2) (BASE 0x0330) (CHECK))

#       Start dependent functions: priority acceptable
#       IRQ 9.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 9 (MODE +E)))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0300
#             Maximum IO base address 0x0330
#             IO base alignment 16 bytes
#             Number of IO addresses required: 2
# (IO 0 (SIZE 2) (BASE 0x0300) (CHECK))

#       Start dependent functions: priority functional
#       IRQ 9, 10, 11 or 15.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 9 (MODE +E)))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0300
#             Maximum IO base address 0x0330
#             IO base alignment 16 bytes
#             Number of IO addresses required: 2
# (IO 0 (SIZE 2) (BASE 0x0300) (CHECK))

#     End dependent functions
 (NAME "LWC1060/-1[1]{HIGHSCREEN SOUNDBOOSTAR 32 WAVE 3D}")
# (ACT Y)
))
#
# Logical device id ADS7182
#     Device supports I/O range check register
#     Device supports vendor reserved register @ 0x3b
#     Device supports vendor reserved register @ 0x3c
#     Device supports vendor reserved register @ 0x3e
#
# Edit the entries below to uncomment out the configuration required.
# Note that only the first value of any range is given, this may be changed if required
# Don't forget to uncomment the activate (ACT Y) when happy

(CONFIGURE LWC1060/-1 (LD 2
#     Compatible device id PNPb02f

# Multiple choice time, choose one only !

#     Start dependent functions: priority preferred
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0200
#             Maximum IO base address 0x0200
#             IO base alignment 8 bytes
#             Number of IO addresses required: 8
# (IO 0 (SIZE 8) (BASE 0x0200) (CHECK))

#       Start dependent functions: priority acceptable
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0200
#             Maximum IO base address 0x0208
#             IO base alignment 8 bytes
#             Number of IO addresses required: 8
# (IO 0 (SIZE 8) (BASE 0x0200) (CHECK))

#     End dependent functions
 (NAME "LWC1060/-1[2]{HIGHSCREEN SOUNDBOOSTAR 32 WAVE 3D}")
# (ACT Y)
))
#
# Logical device id TER2211
#     Device supports I/O range check register
#     Device supports vendor reserved register @ 0x3b
#     Device supports vendor reserved register @ 0x3c
#     Device supports vendor reserved register @ 0x3e
#
# Edit the entries below to uncomment out the configuration required.
# Note that only the first value of any range is given, this may be changed if required
# Don't forget to uncomment the activate (ACT Y) when happy

(CONFIGURE LWC1060/-1 (LD 3

# Multiple choice time, choose one only !

#     Start dependent functions: priority preferred
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0590
#             Maximum IO base address 0x0590
#             IO base alignment 8 bytes
#             Number of IO addresses required: 8
# (IO 0 (SIZE 8) (BASE 0x0590) (CHECK))

#       Start dependent functions: priority acceptable
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0590
#             Maximum IO base address 0x05a8
#             IO base alignment 8 bytes
#             Number of IO addresses required: 8
# (IO 0 (SIZE 8) (BASE 0x0590) (CHECK))

#       Start dependent functions: priority functional
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0590
#             Maximum IO base address 0x05c8
#             IO base alignment 8 bytes
#             Number of IO addresses required: 8
# (IO 0 (SIZE 8) (BASE 0x0590) (CHECK))

#     End dependent functions
 (NAME "LWC1060/-1[3]{HIGHSCREEN SOUNDBOOSTAR 32 WAVE 3D}")
# (ACT Y)
))
# End tag... Checksum 0x00 (OK)

# Returns all cards to the "Wait for Key" state
(WAITFORKEY)
