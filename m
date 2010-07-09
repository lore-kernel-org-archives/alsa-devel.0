From: Val Krutov <vkrutov@gmail.com>
Subject: Envy24HT (VT1721) 192kHz digital out capable?
Date: Fri, 9 Jul 2010 12:48:16 -0700
Message-ID: <AANLkTikNsWWqmxqmISxqwqBRigTV9soS1BlnD8spqkbD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 40677243BC
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jul 2010 21:48:18 +0200 (CEST)
Received: by iwn39 with SMTP id 39so2573035iwn.38
	for <alsa-devel@alsa-project.org>; Fri, 09 Jul 2010 12:48:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Could anybody get 192kHz out of VT1721 on spdif output working correctly?
If yes please name your card.

I have two cards on VT1721 chip, Audiotrak HD2 Advance DE and Chaintech
AV-710. Both can work properly only up to 96kHz. The 192kHz samples play at
96kHz according to my receiver display sample rate input but alsamixer
reports 192kHz which is incorrect. I believe my receiver' indication rather
than alsamixer.

Here is my register settings output for Chaintech AV-710 at playng 192kHz
sample and everything there looks right to me but my receiver reports it is
96kHz.  I just modified the card's ID and others eeprom settings as
otherwise spdif can work only at 44.1 and 48 kHz.


ICEnsemble ICE1724 at 0x2c40, irq 26

EEPROM:
  Subvendor        : 0x12142419
  Size             : 28 bytes
  Version          : 1
  System Config    : 0x2
  ACLink           : 0x82
  I2S              : 0x78
  S/PDIF           : 0xc1
  GPIO direction   : 0xff
  GPIO mask        : 0xff
  GPIO state       : 0xff
  Extra #18        : 0x1
  Extra #19        : 0x0
  Extra #20        : 0x0
  Extra #21        : 0x0
  Extra #22        : 0x0
  Extra #23        : 0x0
  Extra #24        : 0x0
  Extra #25        : 0x0
  Extra #26        : 0x0
  Extra #27        : 0x0

Registers:
  PSDOUT03 : 0x00000000
  CCS00    : 0x00
  CCS01    : 0xa0
  CCS02    : 0x00
  CCS03    : 0x00
  CCS04    : 0x02
  CCS05    : 0x82
  CCS06    : 0x78
  CCS07    : 0xc1
  CCS08    : 0x00
  CCS09    : 0x00
  CCS0a    : 0x00
  CCS0b    : 0x00
  CCS0c    : 0x00
  CCS0d    : 0x0a
  CCS0e    : 0x00
  CCS0f    : 0x00
  CCS10    : 0xa0
  CCS11    : 0x1b
  CCS12    : 0x00
  CCS13    : 0x80
  CCS14    : 0x00
  CCS15    : 0xaa
  CCS16    : 0xff
  CCS17    : 0x00
  CCS18    : 0xff
  CCS19    : 0x00
  CCS1a    : 0x00
  CCS1b    : 0x00
  CCS1c    : 0x00
  CCS1d    : 0x00
  CCS1e    : 0x2a
  CCS1f    : 0x00
  MT00     : 0x00
  MT01     : 0x0e
  MT02     : 0x08
  MT03     : 0x08
  MT04     : 0x00
  MT05     : 0x00
  MT06     : 0x00
  MT07     : 0x00
  MT08     : 0x00
  MT09     : 0x00
  MT0a     : 0x00
  MT0b     : 0x00
  MT0c     : 0x00
  MT0d     : 0x00
  MT0e     : 0x00
  MT0f     : 0x00
  MT10     : 0x00
  MT11     : 0x00
  MT12     : 0x00
  MT13     : 0x00
  MT14     : 0x00
  MT15     : 0x00
  MT16     : 0x00
  MT17     : 0x00
  MT18     : 0x80
  MT19     : 0x00
  MT1a     : 0x00
  MT1b     : 0x00
  MT1c     : 0x00
  MT1d     : 0x00
  MT1e     : 0x00
  MT1f     : 0x00
  MT20     : 0x00
  MT21     : 0x00
  MT22     : 0x00
  MT23     : 0x00
  MT24     : 0x00
  MT25     : 0x00
  MT26     : 0x00
  MT27     : 0x00
  MT28     : 0x00
  MT29     : 0x00
  MT2a     : 0x00
  MT2b     : 0x00
  MT2c     : 0x00
  MT2d     : 0x00
  MT2e     : 0x00
  MT2f     : 0x00
  MT30     : 0x00
  MT31     : 0x00
  MT32     : 0x00
  MT33     : 0x00
  MT34     : 0x00
  MT35     : 0x00
  MT36     : 0x00
  MT37     : 0x00
  MT38     : 0x00
  MT39     : 0x00
  MT3a     : 0x00
  MT3b     : 0x00
  MT3c     : 0x00
  MT3d     : 0x60
  MT3e     : 0x00
  MT3f     : 0x00
  MT40     : 0x80
  MT41     : 0x48
  MT42     : 0x98
  MT43     : 0x32
  MT44     : 0xdf
  MT45     : 0xed
  MT46     : 0xff
  MT47     : 0x3f
  MT48     : 0x00
  MT49     : 0x00
  MT4a     : 0x00
  MT4b     : 0x00
  MT4c     : 0x00
  MT4d     : 0x00
  MT4e     : 0x00
  MT4f     : 0x00
  MT50     : 0x00
  MT51     : 0x00
  MT52     : 0x00
  MT53     : 0x00
  MT54     : 0x00
  MT55     : 0x00
  MT56     : 0x00
  MT57     : 0x00
  MT58     : 0x00
  MT59     : 0x00
  MT5a     : 0x00
  MT5b     : 0x00
  MT5c     : 0x00
  MT5d     : 0x00
  MT5e     : 0x00
  MT5f     : 0x00
  MT60     : 0x00
  MT61     : 0x00
  MT62     : 0x00
  MT63     : 0x00
  MT64     : 0x00
  MT65     : 0x00
  MT66     : 0x00
  MT67     : 0x00
  MT68     : 0x00
  MT69     : 0x00
  MT6a     : 0x00
  MT6b     : 0x00
  MT6c     : 0x00
  MT6d     : 0x00
  MT6e     : 0x00
  MT6f     : 0x00
  MT70     : 0x00
  MT71     : 0x00
  MT72     : 0x00
  MT73     : 0x00
  MT74     : 0x00
  MT75     : 0x00
  MT76     : 0x00
  MT77     : 0x00

Valera
