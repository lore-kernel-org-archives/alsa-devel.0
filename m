From: Vincent Lejeune <vljn@ovi.com>
Subject: ASUS Phoebus (CMI8888) HDA Support
Date: Sun, 3 Aug 2014 14:05:44 -0700
Message-ID: <1407099944.1470.YahooMailNeo@web161503.mail.bf1.yahoo.com>
Reply-To: Vincent Lejeune <vljn@ovi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm12-vm0.bullet.mail.bf1.yahoo.com
 (nm12-vm0.bullet.mail.bf1.yahoo.com [98.139.213.140])
 by alsa0.perex.cz (Postfix) with ESMTP id C5EAF2652F4
 for <alsa-devel@alsa-project.org>; Sun,  3 Aug 2014 23:05:45 +0200 (CEST)
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

Hi,

I just found this thread http://thread.gmane.org/gmane.linux.alsa.devel/116=
096 =

I'm trying to find what can make the CMI8888 not work in non single_cmd mod=
e and it looks more and more like a DMA issue.
I don't have an "iommu mode" option in my bios like Geoffrey McRae, it look=
s like an AMD only option, and using bigger page size/alignement constraint=
 didnt solve the issue.
However I added some code to dump the content of the rirb buffer in the upd=
ate_rirb() function and I copied it below.

The first command seems to be correctly handled the second time it is send =
to the hardware. As the AZX_DCAPS_*DELAY_RIRB doesnt change anything, I'm s=
tarting to think
that the corb engine may require some delay to be processed.
Is there a way to spy the dma transfer request from the device point of vie=
w ? I'd like to know when the cmi8888 request a dma read from the corb buff=
er and when it requests a dma write to the rirb buffer
to determine if it parses the corb buffer correctly or not.

In addition the first value returned is very odd : 13f68888. The pci id of =
the phoebus is 13f6:5011.
What does the 100f0001 cmd mean ? hda-decode-verb tells me the verb is "0x0=
"...

[ 4038.467696] snd_hda_intel 0000:01:00.1: Handle VGA-switcheroo audio clie=
nt
[ 4038.467723] snd_hda_intel 0000:01:00.1: irq 50 for MSI/MSI-X
[ 4038.467836] snd_hda_intel 0000:02:00.0: Disabling MSI
[ 4038.469852] snd_hda_intel 0000:01:00.1: Pointers values : rirblbase : ff=
ff8800, corbbase : ffff8000
[ 4038.469887] snd_hda_intel 0000:01:00.1: no codecs initialized
[ 4038.471618] snd_hda_intel 0000:02:00.0: Pointers values : rirblbase : ff=
ff7800, corbbase : ffff7000
[ 4038.471721] snd_hda_intel 0000:02:00.0: corb write @ 1 value 100f0000
[ 4038.471780] snd_hda_intel 0000:02:00.0: rirb content @ 0 : 0 0
[ 4038.471782] snd_hda_intel 0000:02:00.0: rirb content @ 1 : 0 0
[ 4038.471783] snd_hda_intel 0000:02:00.0: rirb content @ 2 : 0 0
[ 4038.471784] snd_hda_intel 0000:02:00.0: rirb content @ 3 : 0 0
[ 4038.471785] snd_hda_intel 0000:02:00.0: rirb content @ 4 : 0 0
[ 4038.471785] snd_hda_intel 0000:02:00.0: rirb content @ 5 : 0 0
[ 4038.471786] snd_hda_intel 0000:02:00.0: rirb content @ 6 : 0 0
[ 4038.471787] snd_hda_intel 0000:02:00.0: rirb content @ 7 : 0 0
[ 4038.471788] snd_hda_intel 0000:02:00.0: rirb content @ 8 : 0 0
[ 4038.471789] snd_hda_intel 0000:02:00.0: rirb content @ 9 : 0 0
[ 4038.471789] snd_hda_intel 0000:02:00.0: rirb content @ 10 : 0 0
[ 4038.471790] snd_hda_intel 0000:02:00.0: rirb content @ 11 : 0 0
[ 4038.471791] snd_hda_intel 0000:02:00.0: rirb content @ 12 : 0 0
[ 4038.471792] snd_hda_intel 0000:02:00.0: rirb content @ 13 : 0 0
[ 4038.471792] snd_hda_intel 0000:02:00.0: rirb content @ 14 : 0 0
[ 4038.471793] snd_hda_intel 0000:02:00.0: rirb content @ 15 : 0 0
[ 4038.471794] snd_hda_intel 0000:02:00.0: rirb content @ 16 : 0 0
[ 4038.471794] snd_hda_intel 0000:02:00.0: rirb content @ 17 : 0 0
[ 4038.471795] snd_hda_intel 0000:02:00.0: rirb content @ 18 : 0 0
[ 4038.471796] snd_hda_intel 0000:02:00.0: rirb content @ 19 : 0 0
[ 4038.471797] snd_hda_intel 0000:02:00.0: rirb content @ 20 : 0 0
[ 4038.471797] snd_hda_intel 0000:02:00.0: rirb content @ 21 : 0 0
[ 4038.471798] snd_hda_intel 0000:02:00.0: rirb content @ 22 : 0 0
[ 4038.471799] snd_hda_intel 0000:02:00.0: rirb content @ 23 : 0 0
[ 4038.471800] snd_hda_intel 0000:02:00.0: rirb content @ 24 : 0 0
[ 4038.471800] snd_hda_intel 0000:02:00.0: rirb content @ 25 : 0 0
[ 4038.471801] snd_hda_intel 0000:02:00.0: rirb content @ 26 : 0 0
[ 4038.471802] snd_hda_intel 0000:02:00.0: rirb content @ 27 : 0 0
[ 4038.471803] snd_hda_intel 0000:02:00.0: rirb content @ 28 : 0 0
[ 4038.471803] snd_hda_intel 0000:02:00.0: rirb content @ 29 : 0 0
[ 4038.471804] snd_hda_intel 0000:02:00.0: rirb content @ 30 : 0 0
[ 4038.471805] snd_hda_intel 0000:02:00.0: rirb content @ 31 : 0 0
[ 4038.471806] snd_hda_intel 0000:02:00.0: rirb content @ 32 : 0 0
[ 4038.471806] snd_hda_intel 0000:02:00.0: rirb content @ 33 : 0 0
[ 4038.471807] snd_hda_intel 0000:02:00.0: rirb content @ 34 : 0 0
[ 4038.471808] snd_hda_intel 0000:02:00.0: rirb content @ 35 : 0 0
[ 4038.471809] snd_hda_intel 0000:02:00.0: rirb content @ 36 : 0 0
[ 4038.471809] snd_hda_intel 0000:02:00.0: rirb content @ 37 : 0 0
[ 4038.471810] snd_hda_intel 0000:02:00.0: rirb content @ 38 : 0 0
[ 4038.471811] snd_hda_intel 0000:02:00.0: rirb content @ 39 : 0 0
[ 4038.471811] snd_hda_intel 0000:02:00.0: rirb content @ 40 : 0 0
[ 4038.471812] snd_hda_intel 0000:02:00.0: rirb content @ 41 : 0 0
[ 4038.471813] snd_hda_intel 0000:02:00.0: rirb content @ 42 : 0 0
[ 4038.471814] snd_hda_intel 0000:02:00.0: rirb content @ 43 : 0 0
[ 4038.471814] snd_hda_intel 0000:02:00.0: rirb content @ 44 : 0 0
[ 4038.471815] snd_hda_intel 0000:02:00.0: rirb content @ 45 : 0 0
[ 4038.471816] snd_hda_intel 0000:02:00.0: rirb content @ 46 : 0 0
[ 4038.471816] snd_hda_intel 0000:02:00.0: rirb content @ 47 : 0 0
[ 4038.471817] snd_hda_intel 0000:02:00.0: rirb content @ 48 : 0 0
[ 4038.471818] snd_hda_intel 0000:02:00.0: rirb content @ 49 : 0 0
[ 4038.471819] snd_hda_intel 0000:02:00.0: rirb content @ 50 : 0 0
[ 4038.471819] snd_hda_intel 0000:02:00.0: rirb content @ 51 : 0 0
[ 4038.471820] snd_hda_intel 0000:02:00.0: rirb content @ 52 : 0 0
[ 4038.471821] snd_hda_intel 0000:02:00.0: rirb content @ 53 : 0 0
[ 4038.471821] snd_hda_intel 0000:02:00.0: rirb content @ 54 : 0 0
[ 4038.471822] snd_hda_intel 0000:02:00.0: rirb content @ 55 : 0 0
[ 4038.471823] snd_hda_intel 0000:02:00.0: rirb content @ 56 : 0 0
[ 4038.471824] snd_hda_intel 0000:02:00.0: rirb content @ 57 : 0 0
[ 4038.471824] snd_hda_intel 0000:02:00.0: rirb content @ 58 : 0 0
[ 4038.471825] snd_hda_intel 0000:02:00.0: rirb content @ 59 : 0 0
[ 4038.471826] snd_hda_intel 0000:02:00.0: rirb content @ 60 : 0 0
[ 4038.471827] snd_hda_intel 0000:02:00.0: rirb content @ 61 : 0 0
[ 4038.471828] snd_hda_intel 0000:02:00.0: rirb content @ 62 : 0 0
[ 4038.471828] snd_hda_intel 0000:02:00.0: rirb content @ 63 : 0 0
[ 4038.471829] snd_hda_intel 0000:02:00.0: rirb content @ 64 : 0 0
[ 4038.471830] snd_hda_intel 0000:02:00.0: rirb content @ 65 : 0 0
[ 4038.471831] snd_hda_intel 0000:02:00.0: rirb content @ 66 : 0 0
[ 4038.471831] snd_hda_intel 0000:02:00.0: rirb content @ 67 : 0 0
[ 4038.471832] snd_hda_intel 0000:02:00.0: rirb content @ 68 : 0 0
[ 4038.471833] snd_hda_intel 0000:02:00.0: rirb content @ 69 : 0 0
[ 4038.471833] snd_hda_intel 0000:02:00.0: rirb content @ 70 : 0 0
[ 4038.471834] snd_hda_intel 0000:02:00.0: rirb content @ 71 : 0 0
[ 4038.471835] snd_hda_intel 0000:02:00.0: rirb content @ 72 : 0 0
[ 4038.471836] snd_hda_intel 0000:02:00.0: rirb content @ 73 : 0 0
[ 4038.471836] snd_hda_intel 0000:02:00.0: rirb content @ 74 : 0 0
[ 4038.471837] snd_hda_intel 0000:02:00.0: rirb content @ 75 : 0 0
[ 4038.471838] snd_hda_intel 0000:02:00.0: rirb content @ 76 : 0 0
[ 4038.471838] snd_hda_intel 0000:02:00.0: rirb content @ 77 : 0 0
[ 4038.471839] snd_hda_intel 0000:02:00.0: rirb content @ 78 : 0 0
[ 4038.471840] snd_hda_intel 0000:02:00.0: rirb content @ 79 : 0 0
[ 4038.471841] snd_hda_intel 0000:02:00.0: rirb content @ 80 : 0 0
[ 4038.471841] snd_hda_intel 0000:02:00.0: rirb content @ 81 : 0 0
[ 4038.471842] snd_hda_intel 0000:02:00.0: rirb content @ 82 : 0 0
[ 4038.471843] snd_hda_intel 0000:02:00.0: rirb content @ 83 : 0 0
[ 4038.471844] snd_hda_intel 0000:02:00.0: rirb content @ 84 : 0 0
[ 4038.471844] snd_hda_intel 0000:02:00.0: rirb content @ 85 : 0 0
[ 4038.471845] snd_hda_intel 0000:02:00.0: rirb content @ 86 : 0 0
[ 4038.471846] snd_hda_intel 0000:02:00.0: rirb content @ 87 : 0 0
[ 4038.471846] snd_hda_intel 0000:02:00.0: rirb content @ 88 : 0 0
[ 4038.471847] snd_hda_intel 0000:02:00.0: rirb content @ 89 : 0 0
[ 4038.471848] snd_hda_intel 0000:02:00.0: rirb content @ 90 : 0 0
[ 4038.471849] snd_hda_intel 0000:02:00.0: rirb content @ 91 : 0 0
[ 4038.471849] snd_hda_intel 0000:02:00.0: rirb content @ 92 : 0 0
[ 4038.471850] snd_hda_intel 0000:02:00.0: rirb content @ 93 : 0 0
[ 4038.471851] snd_hda_intel 0000:02:00.0: rirb content @ 94 : 0 0
[ 4038.471851] snd_hda_intel 0000:02:00.0: rirb content @ 95 : 0 0
[ 4038.471852] snd_hda_intel 0000:02:00.0: rirb content @ 96 : 0 0
[ 4038.471853] snd_hda_intel 0000:02:00.0: rirb content @ 97 : 0 0
[ 4038.471854] snd_hda_intel 0000:02:00.0: rirb content @ 98 : 0 0
[ 4038.471854] snd_hda_intel 0000:02:00.0: rirb content @ 99 : 0 0
[ 4038.471855] snd_hda_intel 0000:02:00.0: rirb content @ 100 : 0 0
[ 4038.471856] snd_hda_intel 0000:02:00.0: rirb content @ 101 : 0 0
[ 4038.471857] snd_hda_intel 0000:02:00.0: rirb content @ 102 : 0 0
[ 4038.471858] snd_hda_intel 0000:02:00.0: rirb content @ 103 : 0 0
[ 4038.471858] snd_hda_intel 0000:02:00.0: rirb content @ 104 : 0 0
[ 4038.471859] snd_hda_intel 0000:02:00.0: rirb content @ 105 : 0 0
[ 4038.471860] snd_hda_intel 0000:02:00.0: rirb content @ 106 : 0 0
[ 4038.471860] snd_hda_intel 0000:02:00.0: rirb content @ 107 : 0 0
[ 4038.471861] snd_hda_intel 0000:02:00.0: rirb content @ 108 : 0 0
[ 4038.471862] snd_hda_intel 0000:02:00.0: rirb content @ 109 : 0 0
[ 4038.471863] snd_hda_intel 0000:02:00.0: rirb content @ 110 : 0 0
[ 4038.471863] snd_hda_intel 0000:02:00.0: rirb content @ 111 : 0 0
[ 4038.471864] snd_hda_intel 0000:02:00.0: rirb content @ 112 : 0 0
[ 4038.471865] snd_hda_intel 0000:02:00.0: rirb content @ 113 : 0 0
[ 4038.471866] snd_hda_intel 0000:02:00.0: rirb content @ 114 : 0 0
[ 4038.471866] snd_hda_intel 0000:02:00.0: rirb content @ 115 : 0 0
[ 4038.471867] snd_hda_intel 0000:02:00.0: rirb content @ 116 : 0 0
[ 4038.471868] snd_hda_intel 0000:02:00.0: rirb content @ 117 : 0 0
[ 4038.471868] snd_hda_intel 0000:02:00.0: rirb content @ 118 : 0 0
[ 4038.471869] snd_hda_intel 0000:02:00.0: rirb content @ 119 : 0 0
[ 4038.471870] snd_hda_intel 0000:02:00.0: rirb content @ 120 : 0 0
[ 4038.471871] snd_hda_intel 0000:02:00.0: rirb content @ 121 : 0 0
[ 4038.471871] snd_hda_intel 0000:02:00.0: rirb content @ 122 : 0 0
[ 4038.471872] snd_hda_intel 0000:02:00.0: rirb content @ 123 : 0 0
[ 4038.471873] snd_hda_intel 0000:02:00.0: rirb content @ 124 : 0 0
[ 4038.471873] snd_hda_intel 0000:02:00.0: rirb content @ 125 : 0 0
[ 4038.471874] snd_hda_intel 0000:02:00.0: rirb content @ 126 : 0 0
[ 4038.471875] snd_hda_intel 0000:02:00.0: rirb content @ 127 : 0 0
[ 4038.471876] snd_hda_intel 0000:02:00.0: rirb content @ 128 : 0 0
[ 4038.471876] snd_hda_intel 0000:02:00.0: rirb content @ 129 : 0 0
[ 4038.471877] snd_hda_intel 0000:02:00.0: rirb content @ 130 : 0 0
[ 4038.471878] snd_hda_intel 0000:02:00.0: rirb content @ 131 : 0 0
[ 4038.471878] snd_hda_intel 0000:02:00.0: rirb content @ 132 : 0 0
[ 4038.471879] snd_hda_intel 0000:02:00.0: rirb content @ 133 : 0 0
[ 4038.471880] snd_hda_intel 0000:02:00.0: rirb content @ 134 : 0 0
[ 4038.471881] snd_hda_intel 0000:02:00.0: rirb content @ 135 : 0 0
[ 4038.471881] snd_hda_intel 0000:02:00.0: rirb content @ 136 : 0 0
[ 4038.471882] snd_hda_intel 0000:02:00.0: rirb content @ 137 : 0 0
[ 4038.471883] snd_hda_intel 0000:02:00.0: rirb content @ 138 : 0 0
[ 4038.471884] snd_hda_intel 0000:02:00.0: rirb content @ 139 : 0 0
[ 4038.471885] snd_hda_intel 0000:02:00.0: rirb content @ 140 : 0 0
[ 4038.471885] snd_hda_intel 0000:02:00.0: rirb content @ 141 : 0 0
[ 4038.471886] snd_hda_intel 0000:02:00.0: rirb content @ 142 : 0 0
[ 4038.471887] snd_hda_intel 0000:02:00.0: rirb content @ 143 : 0 0
[ 4038.471888] snd_hda_intel 0000:02:00.0: rirb content @ 144 : 0 0
[ 4038.471888] snd_hda_intel 0000:02:00.0: rirb content @ 145 : 0 0
[ 4038.471889] snd_hda_intel 0000:02:00.0: rirb content @ 146 : 0 0
[ 4038.471890] snd_hda_intel 0000:02:00.0: rirb content @ 147 : 0 0
[ 4038.471891] snd_hda_intel 0000:02:00.0: rirb content @ 148 : 0 0
[ 4038.471891] snd_hda_intel 0000:02:00.0: rirb content @ 149 : 0 0
[ 4038.471892] snd_hda_intel 0000:02:00.0: rirb content @ 150 : 0 0
[ 4038.471893] snd_hda_intel 0000:02:00.0: rirb content @ 151 : 0 0
[ 4038.471893] snd_hda_intel 0000:02:00.0: rirb content @ 152 : 0 0
[ 4038.471894] snd_hda_intel 0000:02:00.0: rirb content @ 153 : 0 0
[ 4038.471895] snd_hda_intel 0000:02:00.0: rirb content @ 154 : 0 0
[ 4038.471896] snd_hda_intel 0000:02:00.0: rirb content @ 155 : 0 0
[ 4038.471896] snd_hda_intel 0000:02:00.0: rirb content @ 156 : 0 0
[ 4038.471897] snd_hda_intel 0000:02:00.0: rirb content @ 157 : 0 0
[ 4038.471898] snd_hda_intel 0000:02:00.0: rirb content @ 158 : 0 0
[ 4038.471898] snd_hda_intel 0000:02:00.0: rirb content @ 159 : 0 0
[ 4038.471899] snd_hda_intel 0000:02:00.0: rirb content @ 160 : 0 0
[ 4038.471900] snd_hda_intel 0000:02:00.0: rirb content @ 161 : 0 0
[ 4038.471901] snd_hda_intel 0000:02:00.0: rirb content @ 162 : 0 0
[ 4038.471901] snd_hda_intel 0000:02:00.0: rirb content @ 163 : 0 0
[ 4038.471902] snd_hda_intel 0000:02:00.0: rirb content @ 164 : 0 0
[ 4038.471903] snd_hda_intel 0000:02:00.0: rirb content @ 165 : 0 0
[ 4038.471903] snd_hda_intel 0000:02:00.0: rirb content @ 166 : 0 0
[ 4038.471904] snd_hda_intel 0000:02:00.0: rirb content @ 167 : 0 0
[ 4038.471905] snd_hda_intel 0000:02:00.0: rirb content @ 168 : 0 0
[ 4038.471906] snd_hda_intel 0000:02:00.0: rirb content @ 169 : 0 0
[ 4038.471906] snd_hda_intel 0000:02:00.0: rirb content @ 170 : 0 0
[ 4038.471907] snd_hda_intel 0000:02:00.0: rirb content @ 171 : 0 0
[ 4038.471908] snd_hda_intel 0000:02:00.0: rirb content @ 172 : 0 0
[ 4038.471909] snd_hda_intel 0000:02:00.0: rirb content @ 173 : 0 0
[ 4038.471909] snd_hda_intel 0000:02:00.0: rirb content @ 174 : 0 0
[ 4038.471910] snd_hda_intel 0000:02:00.0: rirb content @ 175 : 0 0
[ 4038.471911] snd_hda_intel 0000:02:00.0: rirb content @ 176 : 0 0
[ 4038.471912] snd_hda_intel 0000:02:00.0: rirb content @ 177 : 0 0
[ 4038.471912] snd_hda_intel 0000:02:00.0: rirb content @ 178 : 0 0
[ 4038.471913] snd_hda_intel 0000:02:00.0: rirb content @ 179 : 0 0
[ 4038.471914] snd_hda_intel 0000:02:00.0: rirb content @ 180 : 0 0
[ 4038.471915] snd_hda_intel 0000:02:00.0: rirb content @ 181 : 0 0
[ 4038.471915] snd_hda_intel 0000:02:00.0: rirb content @ 182 : 0 0
[ 4038.471916] snd_hda_intel 0000:02:00.0: rirb content @ 183 : 0 0
[ 4038.471917] snd_hda_intel 0000:02:00.0: rirb content @ 184 : 0 0
[ 4038.471917] snd_hda_intel 0000:02:00.0: rirb content @ 185 : 0 0
[ 4038.471918] snd_hda_intel 0000:02:00.0: rirb content @ 186 : 0 0
[ 4038.471919] snd_hda_intel 0000:02:00.0: rirb content @ 187 : 0 0
[ 4038.471920] snd_hda_intel 0000:02:00.0: rirb content @ 188 : 0 0
[ 4038.471920] snd_hda_intel 0000:02:00.0: rirb content @ 189 : 0 0
[ 4038.471921] snd_hda_intel 0000:02:00.0: rirb content @ 190 : 0 0
[ 4038.471922] snd_hda_intel 0000:02:00.0: rirb content @ 191 : 0 0
[ 4038.471922] snd_hda_intel 0000:02:00.0: rirb content @ 192 : 0 0
[ 4038.471923] snd_hda_intel 0000:02:00.0: rirb content @ 193 : 0 0
[ 4038.471924] snd_hda_intel 0000:02:00.0: rirb content @ 194 : 0 0
[ 4038.471925] snd_hda_intel 0000:02:00.0: rirb content @ 195 : 0 0
[ 4038.471925] snd_hda_intel 0000:02:00.0: rirb content @ 196 : 0 0
[ 4038.471926] snd_hda_intel 0000:02:00.0: rirb content @ 197 : 0 0
[ 4038.471927] snd_hda_intel 0000:02:00.0: rirb content @ 198 : 0 0
[ 4038.471928] snd_hda_intel 0000:02:00.0: rirb content @ 199 : 0 0
[ 4038.471928] snd_hda_intel 0000:02:00.0: rirb content @ 200 : 0 0
[ 4038.471929] snd_hda_intel 0000:02:00.0: rirb content @ 201 : 0 0
[ 4038.471930] snd_hda_intel 0000:02:00.0: rirb content @ 202 : 0 0
[ 4038.471930] snd_hda_intel 0000:02:00.0: rirb content @ 203 : 0 0
[ 4038.471931] snd_hda_intel 0000:02:00.0: rirb content @ 204 : 0 0
[ 4038.471932] snd_hda_intel 0000:02:00.0: rirb content @ 205 : 0 0
[ 4038.471933] snd_hda_intel 0000:02:00.0: rirb content @ 206 : 0 0
[ 4038.471933] snd_hda_intel 0000:02:00.0: rirb content @ 207 : 0 0
[ 4038.471934] snd_hda_intel 0000:02:00.0: rirb content @ 208 : 0 0
[ 4038.471935] snd_hda_intel 0000:02:00.0: rirb content @ 209 : 0 0
[ 4038.471935] snd_hda_intel 0000:02:00.0: rirb content @ 210 : 0 0
[ 4038.471936] snd_hda_intel 0000:02:00.0: rirb content @ 211 : 0 0
[ 4038.471937] snd_hda_intel 0000:02:00.0: rirb content @ 212 : 0 0
[ 4038.471938] snd_hda_intel 0000:02:00.0: rirb content @ 213 : 0 0
[ 4038.471938] snd_hda_intel 0000:02:00.0: rirb content @ 214 : 0 0
[ 4038.471939] snd_hda_intel 0000:02:00.0: rirb content @ 215 : 0 0
[ 4038.471940] snd_hda_intel 0000:02:00.0: rirb content @ 216 : 0 0
[ 4038.471941] snd_hda_intel 0000:02:00.0: rirb content @ 217 : 0 0
[ 4038.471941] snd_hda_intel 0000:02:00.0: rirb content @ 218 : 0 0
[ 4038.471942] snd_hda_intel 0000:02:00.0: rirb content @ 219 : 0 0
[ 4038.471943] snd_hda_intel 0000:02:00.0: rirb content @ 220 : 0 0
[ 4038.471944] snd_hda_intel 0000:02:00.0: rirb content @ 221 : 0 0
[ 4038.471944] snd_hda_intel 0000:02:00.0: rirb content @ 222 : 0 0
[ 4038.471945] snd_hda_intel 0000:02:00.0: rirb content @ 223 : 0 0
[ 4038.471946] snd_hda_intel 0000:02:00.0: rirb content @ 224 : 0 0
[ 4038.471947] snd_hda_intel 0000:02:00.0: rirb content @ 225 : 0 0
[ 4038.471947] snd_hda_intel 0000:02:00.0: rirb content @ 226 : 0 0
[ 4038.471948] snd_hda_intel 0000:02:00.0: rirb content @ 227 : 0 0
[ 4038.471949] snd_hda_intel 0000:02:00.0: rirb content @ 228 : 0 0
[ 4038.471949] snd_hda_intel 0000:02:00.0: rirb content @ 229 : 0 0
[ 4038.471950] snd_hda_intel 0000:02:00.0: rirb content @ 230 : 0 0
[ 4038.471951] snd_hda_intel 0000:02:00.0: rirb content @ 231 : 0 0
[ 4038.471952] snd_hda_intel 0000:02:00.0: rirb content @ 232 : 0 0
[ 4038.471952] snd_hda_intel 0000:02:00.0: rirb content @ 233 : 0 0
[ 4038.471953] snd_hda_intel 0000:02:00.0: rirb content @ 234 : 0 0
[ 4038.471954] snd_hda_intel 0000:02:00.0: rirb content @ 235 : 0 0
[ 4038.471954] snd_hda_intel 0000:02:00.0: rirb content @ 236 : 0 0
[ 4038.471955] snd_hda_intel 0000:02:00.0: rirb content @ 237 : 0 0
[ 4038.471956] snd_hda_intel 0000:02:00.0: rirb content @ 238 : 0 0
[ 4038.471957] snd_hda_intel 0000:02:00.0: rirb content @ 239 : 0 0
[ 4038.471957] snd_hda_intel 0000:02:00.0: rirb content @ 240 : 0 0
[ 4038.471958] snd_hda_intel 0000:02:00.0: rirb content @ 241 : 0 0
[ 4038.471959] snd_hda_intel 0000:02:00.0: rirb content @ 242 : 0 0
[ 4038.471959] snd_hda_intel 0000:02:00.0: rirb content @ 243 : 0 0
[ 4038.471960] snd_hda_intel 0000:02:00.0: rirb content @ 244 : 0 0
[ 4038.471961] snd_hda_intel 0000:02:00.0: rirb content @ 245 : 0 0
[ 4038.471962] snd_hda_intel 0000:02:00.0: rirb content @ 246 : 0 0
[ 4038.471962] snd_hda_intel 0000:02:00.0: rirb content @ 247 : 0 0
[ 4038.471963] snd_hda_intel 0000:02:00.0: rirb content @ 248 : 0 0
[ 4038.471964] snd_hda_intel 0000:02:00.0: rirb content @ 249 : 0 0
[ 4038.471965] snd_hda_intel 0000:02:00.0: rirb content @ 250 : 0 0
[ 4038.471965] snd_hda_intel 0000:02:00.0: rirb content @ 251 : 0 0
[ 4038.471966] snd_hda_intel 0000:02:00.0: rirb content @ 252 : 0 0
[ 4038.471967] snd_hda_intel 0000:02:00.0: rirb content @ 253 : 0 0
[ 4038.471968] snd_hda_intel 0000:02:00.0: rirb content @ 254 : 0 0
[ 4038.471968] snd_hda_intel 0000:02:00.0: rirb content @ 255 : 0 0
[ 4038.471969] snd_hda_intel 0000:02:00.0: rirb pos 1 : 0 0
[ 4038.471970] snd_hda_intel 0000:02:00.0: spurious response 0x0:0x0, rp =
=3D 1, wp =3D 1
[ 4038.471971] ------------[ cut here ]------------
[ 4038.471973] WARNING: CPU: 0 PID: 0 at sound/pci/hda/hda_controller.c:121=
2 azx_update_rirb+0x1a5/0x220 [snd_hda_controller]()
[ 4038.471974] BUG?
[ 4038.471974] Modules linked in: snd_hda_intel snd_hda_controller snd_hda_=
codec_generic snd_hda_codec snd_hwdep snd_pcm nls_utf8 isofs fuse ip6t_rpfi=
lter bnep bluetooth ip6t_REJECT cfg80211 xt_conntrack rfkill ebtable_nat eb=
table_broute bridge stp llc ebtable_filter ebtables ip6table_nat nf_conntra=
ck_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security ip6tab=
le_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_i=
pv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_security iptable=
_raw x86_pkg_temp_thermal coretemp kvm_intel vfat fat uas kvm usb_storage m=
xm_wmi snd_seq snd_seq_device crct10dif_pclmul crc32_pclmul crc32c_intel jo=
ydev snd_timer ghash_clmulni_intel mei_me snd mei microcode serio_raw pcspk=
r soundcore shpchp wmi video i2c_hid dw_dmac dw_dmac_core i2c_designware_pl=
atform
[ 4038.471995]=A0 acpi_pad i2c_designware_core radeon i2c_algo_bit drm_kms_=
helper ttm drm sdhci_acpi sdhci mmc_core alx i2c_core mdio [last unloaded: =
snd_hda_controller]
[ 4038.472001] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G=A0=A0=A0=A0=A0=A0=
=A0 W=A0=A0=A0=A0 3.16.0-rc4+ #2
[ 4038.472001] Hardware name: Gigabyte Technology Co., Ltd. G1.Sniper Z97/G=
1.Sniper Z97, BIOS F6 05/30/2014
[ 4038.472002]=A0 0000000000000000 92922082461d2d28 ffff88021ec03d90 ffffff=
ff816ff2e2
[ 4038.472003]=A0 ffff88021ec03dd8 ffff88021ec03dc8 ffffffff8108bead ffff88=
00d79d3800
[ 4038.472005]=A0 0000000000000000 0000000000000001 0000000000000000 000000=
0000000000
[ 4038.472006] Call Trace:
[ 4038.472007]=A0 <IRQ>=A0 [<ffffffff816ff2e2>] dump_stack+0x45/0x56
[ 4038.472013]=A0 [<ffffffff8108bead>] warn_slowpath_common+0x7d/0xa0
[ 4038.472014]=A0 [<ffffffff8108bf2c>] warn_slowpath_fmt+0x5c/0x80
[ 4038.472016]=A0 [<ffffffffa0304645>] azx_update_rirb+0x1a5/0x220 [snd_hda=
_controller]
[ 4038.472017]=A0 [<ffffffffa03048c9>] azx_interrupt+0x179/0x1c0 [snd_hda_c=
ontroller]
[ 4038.472020]=A0 [<ffffffff810e697e>] handle_irq_event_percpu+0x3e/0x1a0
[ 4038.472021]=A0 [<ffffffff810e6b16>] handle_irq_event+0x36/0x60
[ 4038.472023]=A0 [<ffffffff810e9ebc>] handle_fasteoi_irq+0x7c/0x140
[ 4038.472026]=A0 [<ffffffff81015eff>] handle_irq+0xbf/0x150
[ 4038.472029]=A0 [<ffffffff810b33fa>] ? atomic_notifier_call_chain+0x1a/0x=
20
[ 4038.472032]=A0 [<ffffffff8170968f>] do_IRQ+0x4f/0xf0
[ 4038.472033]=A0 [<ffffffff8170746d>] common_interrupt+0x6d/0x6d
[ 4038.472033]=A0 <EOI>=A0 [<ffffffff81597792>] ? cpuidle_enter_state+0x52/=
0xc0
[ 4038.472037]=A0 [<ffffffff815978b7>] cpuidle_enter+0x17/0x20
[ 4038.472039]=A0 [<ffffffff810d3035>] cpu_startup_entry+0x315/0x440
[ 4038.472042]=A0 [<ffffffff816f1427>] rest_init+0x77/0x80
[ 4038.472045]=A0 [<ffffffff81d280e1>] start_kernel+0x465/0x486
[ 4038.472046]=A0 [<ffffffff81d27a85>] ? set_init_arg+0x53/0x53
[ 4038.472048]=A0 [<ffffffff81d27120>] ? early_idt_handlers+0x120/0x120
[ 4038.472049]=A0 [<ffffffff81d275ee>] x86_64_start_reservations+0x2a/0x2c
[ 4038.472050]=A0 [<ffffffff81d2773d>] x86_64_start_kernel+0x14d/0x170
[ 4038.472051] ---[ end trace 63c0b6054db2a1ea ]---
[ 4039.472815] snd_hda_intel 0000:02:00.0: Codec #1 probe error; disabling =
it...
[ 4039.477032] snd_hda_intel 0000:02:00.0: Pointers values : rirblbase : ff=
ff7800, corbbase : ffff7000
[ 4039.477038] snd_hda_intel 0000:02:00.0: corb write @ 1 value 100f0000
[ 4039.477113] snd_hda_intel 0000:02:00.0: rirb content @ 0 : 0 0
[ 4039.477115] snd_hda_intel 0000:02:00.0: rirb content @ 1 : 13f68888 1
[ 4039.477116] snd_hda_intel 0000:02:00.0: rirb content @ 2 : 0 0
[ 4039.477117] snd_hda_intel 0000:02:00.0: rirb content @ 3 : 0 0
[ 4039.477118] snd_hda_intel 0000:02:00.0: rirb content @ 4 : 0 0
[ 4039.477118] snd_hda_intel 0000:02:00.0: rirb content @ 5 : 0 0
[ 4039.477119] snd_hda_intel 0000:02:00.0: rirb content @ 6 : 0 0
[ 4039.477120] snd_hda_intel 0000:02:00.0: rirb content @ 7 : 0 0
[ 4039.477121] snd_hda_intel 0000:02:00.0: rirb content @ 8 : 0 0
[ 4039.477121] snd_hda_intel 0000:02:00.0: rirb content @ 9 : 0 0
[ 4039.477122] snd_hda_intel 0000:02:00.0: rirb content @ 10 : 0 0
[ 4039.477123] snd_hda_intel 0000:02:00.0: rirb content @ 11 : 0 0
[ 4039.477124] snd_hda_intel 0000:02:00.0: rirb content @ 12 : 0 0
[ 4039.477125] snd_hda_intel 0000:02:00.0: rirb content @ 13 : 0 0
[ 4039.477125] snd_hda_intel 0000:02:00.0: rirb content @ 14 : 0 0
[ 4039.477126] snd_hda_intel 0000:02:00.0: rirb content @ 15 : 0 0
[ 4039.477127] snd_hda_intel 0000:02:00.0: rirb content @ 16 : 0 0
[ 4039.477128] snd_hda_intel 0000:02:00.0: rirb content @ 17 : 0 0
[ 4039.477128] snd_hda_intel 0000:02:00.0: rirb content @ 18 : 0 0
[ 4039.477129] snd_hda_intel 0000:02:00.0: rirb content @ 19 : 0 0
[ 4039.477130] snd_hda_intel 0000:02:00.0: rirb content @ 20 : 0 0
[ 4039.477131] snd_hda_intel 0000:02:00.0: rirb content @ 21 : 0 0
[ 4039.477131] snd_hda_intel 0000:02:00.0: rirb content @ 22 : 0 0
[ 4039.477132] snd_hda_intel 0000:02:00.0: rirb content @ 23 : 0 0
[ 4039.477133] snd_hda_intel 0000:02:00.0: rirb content @ 24 : 0 0
[ 4039.477134] snd_hda_intel 0000:02:00.0: rirb content @ 25 : 0 0
[ 4039.477134] snd_hda_intel 0000:02:00.0: rirb content @ 26 : 0 0
[ 4039.477135] snd_hda_intel 0000:02:00.0: rirb content @ 27 : 0 0
[ 4039.477136] snd_hda_intel 0000:02:00.0: rirb content @ 28 : 0 0
[ 4039.477137] snd_hda_intel 0000:02:00.0: rirb content @ 29 : 0 0
[ 4039.477137] snd_hda_intel 0000:02:00.0: rirb content @ 30 : 0 0
[ 4039.477138] snd_hda_intel 0000:02:00.0: rirb content @ 31 : 0 0
[ 4039.477139] snd_hda_intel 0000:02:00.0: rirb content @ 32 : 0 0
[ 4039.477140] snd_hda_intel 0000:02:00.0: rirb content @ 33 : 0 0
[ 4039.477140] snd_hda_intel 0000:02:00.0: rirb content @ 34 : 0 0
[ 4039.477141] snd_hda_intel 0000:02:00.0: rirb content @ 35 : 0 0
[ 4039.477142] snd_hda_intel 0000:02:00.0: rirb content @ 36 : 0 0
[ 4039.477143] snd_hda_intel 0000:02:00.0: rirb content @ 37 : 0 0
[ 4039.477143] snd_hda_intel 0000:02:00.0: rirb content @ 38 : 0 0
[ 4039.477144] snd_hda_intel 0000:02:00.0: rirb content @ 39 : 0 0
[ 4039.477145] snd_hda_intel 0000:02:00.0: rirb content @ 40 : 0 0
[ 4039.477146] snd_hda_intel 0000:02:00.0: rirb content @ 41 : 0 0
[ 4039.477146] snd_hda_intel 0000:02:00.0: rirb content @ 42 : 0 0
[ 4039.477147] snd_hda_intel 0000:02:00.0: rirb content @ 43 : 0 0
[ 4039.477148] snd_hda_intel 0000:02:00.0: rirb content @ 44 : 0 0
[ 4039.477149] snd_hda_intel 0000:02:00.0: rirb content @ 45 : 0 0
[ 4039.477149] snd_hda_intel 0000:02:00.0: rirb content @ 46 : 0 0
[ 4039.477150] snd_hda_intel 0000:02:00.0: rirb content @ 47 : 0 0
[ 4039.477151] snd_hda_intel 0000:02:00.0: rirb content @ 48 : 0 0
[ 4039.477152] snd_hda_intel 0000:02:00.0: rirb content @ 49 : 0 0
[ 4039.477152] snd_hda_intel 0000:02:00.0: rirb content @ 50 : 0 0
[ 4039.477153] snd_hda_intel 0000:02:00.0: rirb content @ 51 : 0 0
[ 4039.477154] snd_hda_intel 0000:02:00.0: rirb content @ 52 : 0 0
[ 4039.477155] snd_hda_intel 0000:02:00.0: rirb content @ 53 : 0 0
[ 4039.477155] snd_hda_intel 0000:02:00.0: rirb content @ 54 : 0 0
[ 4039.477156] snd_hda_intel 0000:02:00.0: rirb content @ 55 : 0 0
[ 4039.477157] snd_hda_intel 0000:02:00.0: rirb content @ 56 : 0 0
[ 4039.477158] snd_hda_intel 0000:02:00.0: rirb content @ 57 : 0 0
[ 4039.477158] snd_hda_intel 0000:02:00.0: rirb content @ 58 : 0 0
[ 4039.477159] snd_hda_intel 0000:02:00.0: rirb content @ 59 : 0 0
[ 4039.477160] snd_hda_intel 0000:02:00.0: rirb content @ 60 : 0 0
[ 4039.477161] snd_hda_intel 0000:02:00.0: rirb content @ 61 : 0 0
[ 4039.477161] snd_hda_intel 0000:02:00.0: rirb content @ 62 : 0 0
[ 4039.477162] snd_hda_intel 0000:02:00.0: rirb content @ 63 : 0 0
[ 4039.477163] snd_hda_intel 0000:02:00.0: rirb content @ 64 : 0 0
[ 4039.477164] snd_hda_intel 0000:02:00.0: rirb content @ 65 : 0 0
[ 4039.477164] snd_hda_intel 0000:02:00.0: rirb content @ 66 : 0 0
[ 4039.477165] snd_hda_intel 0000:02:00.0: rirb content @ 67 : 0 0
[ 4039.477166] snd_hda_intel 0000:02:00.0: rirb content @ 68 : 0 0
[ 4039.477167] snd_hda_intel 0000:02:00.0: rirb content @ 69 : 0 0
[ 4039.477167] snd_hda_intel 0000:02:00.0: rirb content @ 70 : 0 0
[ 4039.477168] snd_hda_intel 0000:02:00.0: rirb content @ 71 : 0 0
[ 4039.477169] snd_hda_intel 0000:02:00.0: rirb content @ 72 : 0 0
[ 4039.477170] snd_hda_intel 0000:02:00.0: rirb content @ 73 : 0 0
[ 4039.477170] snd_hda_intel 0000:02:00.0: rirb content @ 74 : 0 0
[ 4039.477171] snd_hda_intel 0000:02:00.0: rirb content @ 75 : 0 0
[ 4039.477172] snd_hda_intel 0000:02:00.0: rirb content @ 76 : 0 0
[ 4039.477173] snd_hda_intel 0000:02:00.0: rirb content @ 77 : 0 0
[ 4039.477174] snd_hda_intel 0000:02:00.0: rirb content @ 78 : 0 0
[ 4039.477174] snd_hda_intel 0000:02:00.0: rirb content @ 79 : 0 0
[ 4039.477175] snd_hda_intel 0000:02:00.0: rirb content @ 80 : 0 0
[ 4039.477176] snd_hda_intel 0000:02:00.0: rirb content @ 81 : 0 0
[ 4039.477177] snd_hda_intel 0000:02:00.0: rirb content @ 82 : 0 0
[ 4039.477177] snd_hda_intel 0000:02:00.0: rirb content @ 83 : 0 0
[ 4039.477178] snd_hda_intel 0000:02:00.0: rirb content @ 84 : 0 0
[ 4039.477179] snd_hda_intel 0000:02:00.0: rirb content @ 85 : 0 0
[ 4039.477180] snd_hda_intel 0000:02:00.0: rirb content @ 86 : 0 0
[ 4039.477180] snd_hda_intel 0000:02:00.0: rirb content @ 87 : 0 0
[ 4039.477181] snd_hda_intel 0000:02:00.0: rirb content @ 88 : 0 0
[ 4039.477182] snd_hda_intel 0000:02:00.0: rirb content @ 89 : 0 0
[ 4039.477183] snd_hda_intel 0000:02:00.0: rirb content @ 90 : 0 0
[ 4039.477183] snd_hda_intel 0000:02:00.0: rirb content @ 91 : 0 0
[ 4039.477184] snd_hda_intel 0000:02:00.0: rirb content @ 92 : 0 0
[ 4039.477185] snd_hda_intel 0000:02:00.0: rirb content @ 93 : 0 0
[ 4039.477186] snd_hda_intel 0000:02:00.0: rirb content @ 94 : 0 0
[ 4039.477186] snd_hda_intel 0000:02:00.0: rirb content @ 95 : 0 0
[ 4039.477187] snd_hda_intel 0000:02:00.0: rirb content @ 96 : 0 0
[ 4039.477188] snd_hda_intel 0000:02:00.0: rirb content @ 97 : 0 0
[ 4039.477189] snd_hda_intel 0000:02:00.0: rirb content @ 98 : 0 0
[ 4039.477189] snd_hda_intel 0000:02:00.0: rirb content @ 99 : 0 0
[ 4039.477190] snd_hda_intel 0000:02:00.0: rirb content @ 100 : 0 0
[ 4039.477191] snd_hda_intel 0000:02:00.0: rirb content @ 101 : 0 0
[ 4039.477192] snd_hda_intel 0000:02:00.0: rirb content @ 102 : 0 0
[ 4039.477192] snd_hda_intel 0000:02:00.0: rirb content @ 103 : 0 0
[ 4039.477193] snd_hda_intel 0000:02:00.0: rirb content @ 104 : 0 0
[ 4039.477194] snd_hda_intel 0000:02:00.0: rirb content @ 105 : 0 0
[ 4039.477195] snd_hda_intel 0000:02:00.0: rirb content @ 106 : 0 0
[ 4039.477195] snd_hda_intel 0000:02:00.0: rirb content @ 107 : 0 0
[ 4039.477196] snd_hda_intel 0000:02:00.0: rirb content @ 108 : 0 0
[ 4039.477197] snd_hda_intel 0000:02:00.0: rirb content @ 109 : 0 0
[ 4039.477198] snd_hda_intel 0000:02:00.0: rirb content @ 110 : 0 0
[ 4039.477199] snd_hda_intel 0000:02:00.0: rirb content @ 111 : 0 0
[ 4039.477199] snd_hda_intel 0000:02:00.0: rirb content @ 112 : 0 0
[ 4039.477200] snd_hda_intel 0000:02:00.0: rirb content @ 113 : 0 0
[ 4039.477201] snd_hda_intel 0000:02:00.0: rirb content @ 114 : 0 0
[ 4039.477202] snd_hda_intel 0000:02:00.0: rirb content @ 115 : 0 0
[ 4039.477203] snd_hda_intel 0000:02:00.0: rirb content @ 116 : 0 0
[ 4039.477203] snd_hda_intel 0000:02:00.0: rirb content @ 117 : 0 0
[ 4039.477204] snd_hda_intel 0000:02:00.0: rirb content @ 118 : 0 0
[ 4039.477205] snd_hda_intel 0000:02:00.0: rirb content @ 119 : 0 0
[ 4039.477206] snd_hda_intel 0000:02:00.0: rirb content @ 120 : 0 0
[ 4039.477206] snd_hda_intel 0000:02:00.0: rirb content @ 121 : 0 0
[ 4039.477207] snd_hda_intel 0000:02:00.0: rirb content @ 122 : 0 0
[ 4039.477208] snd_hda_intel 0000:02:00.0: rirb content @ 123 : 0 0
[ 4039.477209] snd_hda_intel 0000:02:00.0: rirb content @ 124 : 0 0
[ 4039.477209] snd_hda_intel 0000:02:00.0: rirb content @ 125 : 0 0
[ 4039.477210] snd_hda_intel 0000:02:00.0: rirb content @ 126 : 0 0
[ 4039.477211] snd_hda_intel 0000:02:00.0: rirb content @ 127 : 0 0
[ 4039.477212] snd_hda_intel 0000:02:00.0: rirb content @ 128 : 0 0
[ 4039.477213] snd_hda_intel 0000:02:00.0: rirb content @ 129 : 0 0
[ 4039.477213] snd_hda_intel 0000:02:00.0: rirb content @ 130 : 0 0
[ 4039.477214] snd_hda_intel 0000:02:00.0: rirb content @ 131 : 0 0
[ 4039.477215] snd_hda_intel 0000:02:00.0: rirb content @ 132 : 0 0
[ 4039.477215] snd_hda_intel 0000:02:00.0: rirb content @ 133 : 0 0
[ 4039.477216] snd_hda_intel 0000:02:00.0: rirb content @ 134 : 0 0
[ 4039.477217] snd_hda_intel 0000:02:00.0: rirb content @ 135 : 0 0
[ 4039.477218] snd_hda_intel 0000:02:00.0: rirb content @ 136 : 0 0
[ 4039.477219] snd_hda_intel 0000:02:00.0: rirb content @ 137 : 0 0
[ 4039.477219] snd_hda_intel 0000:02:00.0: rirb content @ 138 : 0 0
[ 4039.477220] snd_hda_intel 0000:02:00.0: rirb content @ 139 : 0 0
[ 4039.477221] snd_hda_intel 0000:02:00.0: rirb content @ 140 : 0 0
[ 4039.477221] snd_hda_intel 0000:02:00.0: rirb content @ 141 : 0 0
[ 4039.477222] snd_hda_intel 0000:02:00.0: rirb content @ 142 : 0 0
[ 4039.477223] snd_hda_intel 0000:02:00.0: rirb content @ 143 : 0 0
[ 4039.477224] snd_hda_intel 0000:02:00.0: rirb content @ 144 : 0 0
[ 4039.477224] snd_hda_intel 0000:02:00.0: rirb content @ 145 : 0 0
[ 4039.477225] snd_hda_intel 0000:02:00.0: rirb content @ 146 : 0 0
[ 4039.477226] snd_hda_intel 0000:02:00.0: rirb content @ 147 : 0 0
[ 4039.477227] snd_hda_intel 0000:02:00.0: rirb content @ 148 : 0 0
[ 4039.477228] snd_hda_intel 0000:02:00.0: rirb content @ 149 : 0 0
[ 4039.477228] snd_hda_intel 0000:02:00.0: rirb content @ 150 : 0 0
[ 4039.477229] snd_hda_intel 0000:02:00.0: rirb content @ 151 : 0 0
[ 4039.477230] snd_hda_intel 0000:02:00.0: rirb content @ 152 : 0 0
[ 4039.477231] snd_hda_intel 0000:02:00.0: rirb content @ 153 : 0 0
[ 4039.477232] snd_hda_intel 0000:02:00.0: rirb content @ 154 : 0 0
[ 4039.477232] snd_hda_intel 0000:02:00.0: rirb content @ 155 : 0 0
[ 4039.477233] snd_hda_intel 0000:02:00.0: rirb content @ 156 : 0 0
[ 4039.477234] snd_hda_intel 0000:02:00.0: rirb content @ 157 : 0 0
[ 4039.477235] snd_hda_intel 0000:02:00.0: rirb content @ 158 : 0 0
[ 4039.477235] snd_hda_intel 0000:02:00.0: rirb content @ 159 : 0 0
[ 4039.477236] snd_hda_intel 0000:02:00.0: rirb content @ 160 : 0 0
[ 4039.477237] snd_hda_intel 0000:02:00.0: rirb content @ 161 : 0 0
[ 4039.477238] snd_hda_intel 0000:02:00.0: rirb content @ 162 : 0 0
[ 4039.477238] snd_hda_intel 0000:02:00.0: rirb content @ 163 : 0 0
[ 4039.477239] snd_hda_intel 0000:02:00.0: rirb content @ 164 : 0 0
[ 4039.477240] snd_hda_intel 0000:02:00.0: rirb content @ 165 : 0 0
[ 4039.477240] snd_hda_intel 0000:02:00.0: rirb content @ 166 : 0 0
[ 4039.477241] snd_hda_intel 0000:02:00.0: rirb content @ 167 : 0 0
[ 4039.477242] snd_hda_intel 0000:02:00.0: rirb content @ 168 : 0 0
[ 4039.477243] snd_hda_intel 0000:02:00.0: rirb content @ 169 : 0 0
[ 4039.477244] snd_hda_intel 0000:02:00.0: rirb content @ 170 : 0 0
[ 4039.477244] snd_hda_intel 0000:02:00.0: rirb content @ 171 : 0 0
[ 4039.477245] snd_hda_intel 0000:02:00.0: rirb content @ 172 : 0 0
[ 4039.477246] snd_hda_intel 0000:02:00.0: rirb content @ 173 : 0 0
[ 4039.477246] snd_hda_intel 0000:02:00.0: rirb content @ 174 : 0 0
[ 4039.477247] snd_hda_intel 0000:02:00.0: rirb content @ 175 : 0 0
[ 4039.477248] snd_hda_intel 0000:02:00.0: rirb content @ 176 : 0 0
[ 4039.477249] snd_hda_intel 0000:02:00.0: rirb content @ 177 : 0 0
[ 4039.477249] snd_hda_intel 0000:02:00.0: rirb content @ 178 : 0 0
[ 4039.477250] snd_hda_intel 0000:02:00.0: rirb content @ 179 : 0 0
[ 4039.477251] snd_hda_intel 0000:02:00.0: rirb content @ 180 : 0 0
[ 4039.477252] snd_hda_intel 0000:02:00.0: rirb content @ 181 : 0 0
[ 4039.477252] snd_hda_intel 0000:02:00.0: rirb content @ 182 : 0 0
[ 4039.477253] snd_hda_intel 0000:02:00.0: rirb content @ 183 : 0 0
[ 4039.477254] snd_hda_intel 0000:02:00.0: rirb content @ 184 : 0 0
[ 4039.477255] snd_hda_intel 0000:02:00.0: rirb content @ 185 : 0 0
[ 4039.477255] snd_hda_intel 0000:02:00.0: rirb content @ 186 : 0 0
[ 4039.477256] snd_hda_intel 0000:02:00.0: rirb content @ 187 : 0 0
[ 4039.477257] snd_hda_intel 0000:02:00.0: rirb content @ 188 : 0 0
[ 4039.477258] snd_hda_intel 0000:02:00.0: rirb content @ 189 : 0 0
[ 4039.477259] snd_hda_intel 0000:02:00.0: rirb content @ 190 : 0 0
[ 4039.477259] snd_hda_intel 0000:02:00.0: rirb content @ 191 : 0 0
[ 4039.477260] snd_hda_intel 0000:02:00.0: rirb content @ 192 : 0 0
[ 4039.477261] snd_hda_intel 0000:02:00.0: rirb content @ 193 : 0 0
[ 4039.477262] snd_hda_intel 0000:02:00.0: rirb content @ 194 : 0 0
[ 4039.477262] snd_hda_intel 0000:02:00.0: rirb content @ 195 : 0 0
[ 4039.477263] snd_hda_intel 0000:02:00.0: rirb content @ 196 : 0 0
[ 4039.477264] snd_hda_intel 0000:02:00.0: rirb content @ 197 : 0 0
[ 4039.477265] snd_hda_intel 0000:02:00.0: rirb content @ 198 : 0 0
[ 4039.477265] snd_hda_intel 0000:02:00.0: rirb content @ 199 : 0 0
[ 4039.477266] snd_hda_intel 0000:02:00.0: rirb content @ 200 : 0 0
[ 4039.477267] snd_hda_intel 0000:02:00.0: rirb content @ 201 : 0 0
[ 4039.477268] snd_hda_intel 0000:02:00.0: rirb content @ 202 : 0 0
[ 4039.477268] snd_hda_intel 0000:02:00.0: rirb content @ 203 : 0 0
[ 4039.477269] snd_hda_intel 0000:02:00.0: rirb content @ 204 : 0 0
[ 4039.477270] snd_hda_intel 0000:02:00.0: rirb content @ 205 : 0 0
[ 4039.477271] snd_hda_intel 0000:02:00.0: rirb content @ 206 : 0 0
[ 4039.477271] snd_hda_intel 0000:02:00.0: rirb content @ 207 : 0 0
[ 4039.477272] snd_hda_intel 0000:02:00.0: rirb content @ 208 : 0 0
[ 4039.477273] snd_hda_intel 0000:02:00.0: rirb content @ 209 : 0 0
[ 4039.477274] snd_hda_intel 0000:02:00.0: rirb content @ 210 : 0 0
[ 4039.477274] snd_hda_intel 0000:02:00.0: rirb content @ 211 : 0 0
[ 4039.477275] snd_hda_intel 0000:02:00.0: rirb content @ 212 : 0 0
[ 4039.477276] snd_hda_intel 0000:02:00.0: rirb content @ 213 : 0 0
[ 4039.477276] snd_hda_intel 0000:02:00.0: rirb content @ 214 : 0 0
[ 4039.477277] snd_hda_intel 0000:02:00.0: rirb content @ 215 : 0 0
[ 4039.477278] snd_hda_intel 0000:02:00.0: rirb content @ 216 : 0 0
[ 4039.477279] snd_hda_intel 0000:02:00.0: rirb content @ 217 : 0 0
[ 4039.477279] snd_hda_intel 0000:02:00.0: rirb content @ 218 : 0 0
[ 4039.477280] snd_hda_intel 0000:02:00.0: rirb content @ 219 : 0 0
[ 4039.477281] snd_hda_intel 0000:02:00.0: rirb content @ 220 : 0 0
[ 4039.477282] snd_hda_intel 0000:02:00.0: rirb content @ 221 : 0 0
[ 4039.477282] snd_hda_intel 0000:02:00.0: rirb content @ 222 : 0 0
[ 4039.477283] snd_hda_intel 0000:02:00.0: rirb content @ 223 : 0 0
[ 4039.477284] snd_hda_intel 0000:02:00.0: rirb content @ 224 : 0 0
[ 4039.477285] snd_hda_intel 0000:02:00.0: rirb content @ 225 : 0 0
[ 4039.477286] snd_hda_intel 0000:02:00.0: rirb content @ 226 : 0 0
[ 4039.477286] snd_hda_intel 0000:02:00.0: rirb content @ 227 : 0 0
[ 4039.477287] snd_hda_intel 0000:02:00.0: rirb content @ 228 : 0 0
[ 4039.477288] snd_hda_intel 0000:02:00.0: rirb content @ 229 : 0 0
[ 4039.477289] snd_hda_intel 0000:02:00.0: rirb content @ 230 : 0 0
[ 4039.477289] snd_hda_intel 0000:02:00.0: rirb content @ 231 : 0 0
[ 4039.477290] snd_hda_intel 0000:02:00.0: rirb content @ 232 : 0 0
[ 4039.477291] snd_hda_intel 0000:02:00.0: rirb content @ 233 : 0 0
[ 4039.477292] snd_hda_intel 0000:02:00.0: rirb content @ 234 : 0 0
[ 4039.477292] snd_hda_intel 0000:02:00.0: rirb content @ 235 : 0 0
[ 4039.477293] snd_hda_intel 0000:02:00.0: rirb content @ 236 : 0 0
[ 4039.477294] snd_hda_intel 0000:02:00.0: rirb content @ 237 : 0 0
[ 4039.477295] snd_hda_intel 0000:02:00.0: rirb content @ 238 : 0 0
[ 4039.477295] snd_hda_intel 0000:02:00.0: rirb content @ 239 : 0 0
[ 4039.477296] snd_hda_intel 0000:02:00.0: rirb content @ 240 : 0 0
[ 4039.477297] snd_hda_intel 0000:02:00.0: rirb content @ 241 : 0 0
[ 4039.477298] snd_hda_intel 0000:02:00.0: rirb content @ 242 : 0 0
[ 4039.477298] snd_hda_intel 0000:02:00.0: rirb content @ 243 : 0 0
[ 4039.477299] snd_hda_intel 0000:02:00.0: rirb content @ 244 : 0 0
[ 4039.477300] snd_hda_intel 0000:02:00.0: rirb content @ 245 : 0 0
[ 4039.477300] snd_hda_intel 0000:02:00.0: rirb content @ 246 : 0 0
[ 4039.477301] snd_hda_intel 0000:02:00.0: rirb content @ 247 : 0 0
[ 4039.477302] snd_hda_intel 0000:02:00.0: rirb content @ 248 : 0 0
[ 4039.477303] snd_hda_intel 0000:02:00.0: rirb content @ 249 : 0 0
[ 4039.477303] snd_hda_intel 0000:02:00.0: rirb content @ 250 : 0 0
[ 4039.477304] snd_hda_intel 0000:02:00.0: rirb content @ 251 : 0 0
[ 4039.477305] snd_hda_intel 0000:02:00.0: rirb content @ 252 : 0 0
[ 4039.477306] snd_hda_intel 0000:02:00.0: rirb content @ 253 : 0 0
[ 4039.477306] snd_hda_intel 0000:02:00.0: rirb content @ 254 : 0 0
[ 4039.477307] snd_hda_intel 0000:02:00.0: rirb content @ 255 : 0 0
[ 4039.477308] snd_hda_intel 0000:02:00.0: rirb pos 1 : 13f68888 1
[ 4039.477318] snd_hda_intel 0000:02:00.0: corb write @ 2 value 100f0001
[ 4039.477373] snd_hda_intel 0000:02:00.0: rirb content @ 0 : 0 0
[ 4039.477374] snd_hda_intel 0000:02:00.0: rirb content @ 1 : 13f68888 1
[ 4039.477375] snd_hda_intel 0000:02:00.0: rirb content @ 2 : 0 0
[ 4039.477376] snd_hda_intel 0000:02:00.0: rirb content @ 3 : 0 0
[ 4039.477376] snd_hda_intel 0000:02:00.0: rirb content @ 4 : 0 0
[ 4039.477377] snd_hda_intel 0000:02:00.0: rirb content @ 5 : 0 0
[ 4039.477378] snd_hda_intel 0000:02:00.0: rirb content @ 6 : 0 0
[ 4039.477379] snd_hda_intel 0000:02:00.0: rirb content @ 7 : 0 0
[ 4039.477379] snd_hda_intel 0000:02:00.0: rirb content @ 8 : 0 0
[ 4039.477380] snd_hda_intel 0000:02:00.0: rirb content @ 9 : 0 0
[ 4039.477381] snd_hda_intel 0000:02:00.0: rirb content @ 10 : 0 0
[ 4039.477382] snd_hda_intel 0000:02:00.0: rirb content @ 11 : 0 0
[ 4039.477383] snd_hda_intel 0000:02:00.0: rirb content @ 12 : 0 0
[ 4039.477384] snd_hda_intel 0000:02:00.0: rirb content @ 13 : 0 0
[ 4039.477384] snd_hda_intel 0000:02:00.0: rirb content @ 14 : 0 0
[ 4039.477385] snd_hda_intel 0000:02:00.0: rirb content @ 15 : 0 0
[ 4039.477386] snd_hda_intel 0000:02:00.0: rirb content @ 16 : 0 0
[ 4039.477387] snd_hda_intel 0000:02:00.0: rirb content @ 17 : 0 0
[ 4039.477387] snd_hda_intel 0000:02:00.0: rirb content @ 18 : 0 0
[ 4039.477388] snd_hda_intel 0000:02:00.0: rirb content @ 19 : 0 0
[ 4039.477389] snd_hda_intel 0000:02:00.0: rirb content @ 20 : 0 0
[ 4039.477390] snd_hda_intel 0000:02:00.0: rirb content @ 21 : 0 0
[ 4039.477390] snd_hda_intel 0000:02:00.0: rirb content @ 22 : 0 0
[ 4039.477391] snd_hda_intel 0000:02:00.0: rirb content @ 23 : 0 0
[ 4039.477392] snd_hda_intel 0000:02:00.0: rirb content @ 24 : 0 0
[ 4039.477393] snd_hda_intel 0000:02:00.0: rirb content @ 25 : 0 0
[ 4039.477393] snd_hda_intel 0000:02:00.0: rirb content @ 26 : 0 0
[ 4039.477394] snd_hda_intel 0000:02:00.0: rirb content @ 27 : 0 0
[ 4039.477395] snd_hda_intel 0000:02:00.0: rirb content @ 28 : 0 0
[ 4039.477396] snd_hda_intel 0000:02:00.0: rirb content @ 29 : 0 0
[ 4039.477396] snd_hda_intel 0000:02:00.0: rirb content @ 30 : 0 0
[ 4039.477397] snd_hda_intel 0000:02:00.0: rirb content @ 31 : 0 0
[ 4039.477398] snd_hda_intel 0000:02:00.0: rirb content @ 32 : 0 0
[ 4039.477399] snd_hda_intel 0000:02:00.0: rirb content @ 33 : 0 0
[ 4039.477399] snd_hda_intel 0000:02:00.0: rirb content @ 34 : 0 0
[ 4039.477400] snd_hda_intel 0000:02:00.0: rirb content @ 35 : 0 0
[ 4039.477401] snd_hda_intel 0000:02:00.0: rirb content @ 36 : 0 0
[ 4039.477402] snd_hda_intel 0000:02:00.0: rirb content @ 37 : 0 0
[ 4039.477402] snd_hda_intel 0000:02:00.0: rirb content @ 38 : 0 0
[ 4039.477403] snd_hda_intel 0000:02:00.0: rirb content @ 39 : 0 0
[ 4039.477404] snd_hda_intel 0000:02:00.0: rirb content @ 40 : 0 0
[ 4039.477405] snd_hda_intel 0000:02:00.0: rirb content @ 41 : 0 0
[ 4039.477405] snd_hda_intel 0000:02:00.0: rirb content @ 42 : 0 0
[ 4039.477406] snd_hda_intel 0000:02:00.0: rirb content @ 43 : 0 0
[ 4039.477407] snd_hda_intel 0000:02:00.0: rirb content @ 44 : 0 0
[ 4039.477408] snd_hda_intel 0000:02:00.0: rirb content @ 45 : 0 0
[ 4039.477409] snd_hda_intel 0000:02:00.0: rirb content @ 46 : 0 0
[ 4039.477409] snd_hda_intel 0000:02:00.0: rirb content @ 47 : 0 0
[ 4039.477410] snd_hda_intel 0000:02:00.0: rirb content @ 48 : 0 0
[ 4039.477411] snd_hda_intel 0000:02:00.0: rirb content @ 49 : 0 0
[ 4039.477412] snd_hda_intel 0000:02:00.0: rirb content @ 50 : 0 0
[ 4039.477412] snd_hda_intel 0000:02:00.0: rirb content @ 51 : 0 0
[ 4039.477413] snd_hda_intel 0000:02:00.0: rirb content @ 52 : 0 0
[ 4039.477414] snd_hda_intel 0000:02:00.0: rirb content @ 53 : 0 0
[ 4039.477415] snd_hda_intel 0000:02:00.0: rirb content @ 54 : 0 0
[ 4039.477415] snd_hda_intel 0000:02:00.0: rirb content @ 55 : 0 0
[ 4039.477416] snd_hda_intel 0000:02:00.0: rirb content @ 56 : 0 0
[ 4039.477417] snd_hda_intel 0000:02:00.0: rirb content @ 57 : 0 0
[ 4039.477418] snd_hda_intel 0000:02:00.0: rirb content @ 58 : 0 0
[ 4039.477419] snd_hda_intel 0000:02:00.0: rirb content @ 59 : 0 0
[ 4039.477420] snd_hda_intel 0000:02:00.0: rirb content @ 60 : 0 0
[ 4039.477421] snd_hda_intel 0000:02:00.0: rirb content @ 61 : 0 0
[ 4039.477421] snd_hda_intel 0000:02:00.0: rirb content @ 62 : 0 0
[ 4039.477422] snd_hda_intel 0000:02:00.0: rirb content @ 63 : 0 0
[ 4039.477423] snd_hda_intel 0000:02:00.0: rirb content @ 64 : 0 0
[ 4039.477424] snd_hda_intel 0000:02:00.0: rirb content @ 65 : 0 0
[ 4039.477424] snd_hda_intel 0000:02:00.0: rirb content @ 66 : 0 0
[ 4039.477425] snd_hda_intel 0000:02:00.0: rirb content @ 67 : 0 0
[ 4039.477426] snd_hda_intel 0000:02:00.0: rirb content @ 68 : 0 0
[ 4039.477427] snd_hda_intel 0000:02:00.0: rirb content @ 69 : 0 0
[ 4039.477427] snd_hda_intel 0000:02:00.0: rirb content @ 70 : 0 0
[ 4039.477428] snd_hda_intel 0000:02:00.0: rirb content @ 71 : 0 0
[ 4039.477429] snd_hda_intel 0000:02:00.0: rirb content @ 72 : 0 0
[ 4039.477430] snd_hda_intel 0000:02:00.0: rirb content @ 73 : 0 0
[ 4039.477430] snd_hda_intel 0000:02:00.0: rirb content @ 74 : 0 0
[ 4039.477431] snd_hda_intel 0000:02:00.0: rirb content @ 75 : 0 0
[ 4039.477432] snd_hda_intel 0000:02:00.0: rirb content @ 76 : 0 0
[ 4039.477433] snd_hda_intel 0000:02:00.0: rirb content @ 77 : 0 0
[ 4039.477433] snd_hda_intel 0000:02:00.0: rirb content @ 78 : 0 0
[ 4039.477434] snd_hda_intel 0000:02:00.0: rirb content @ 79 : 0 0
[ 4039.477435] snd_hda_intel 0000:02:00.0: rirb content @ 80 : 0 0
[ 4039.477436] snd_hda_intel 0000:02:00.0: rirb content @ 81 : 0 0
[ 4039.477437] snd_hda_intel 0000:02:00.0: rirb content @ 82 : 0 0
[ 4039.477437] snd_hda_intel 0000:02:00.0: rirb content @ 83 : 0 0
[ 4039.477438] snd_hda_intel 0000:02:00.0: rirb content @ 84 : 0 0
[ 4039.477439] snd_hda_intel 0000:02:00.0: rirb content @ 85 : 0 0
[ 4039.477440] snd_hda_intel 0000:02:00.0: rirb content @ 86 : 0 0
[ 4039.477440] snd_hda_intel 0000:02:00.0: rirb content @ 87 : 0 0
[ 4039.477441] snd_hda_intel 0000:02:00.0: rirb content @ 88 : 0 0
[ 4039.477442] snd_hda_intel 0000:02:00.0: rirb content @ 89 : 0 0
[ 4039.477443] snd_hda_intel 0000:02:00.0: rirb content @ 90 : 0 0
[ 4039.477443] snd_hda_intel 0000:02:00.0: rirb content @ 91 : 0 0
[ 4039.477444] snd_hda_intel 0000:02:00.0: rirb content @ 92 : 0 0
[ 4039.477445] snd_hda_intel 0000:02:00.0: rirb content @ 93 : 0 0
[ 4039.477446] snd_hda_intel 0000:02:00.0: rirb content @ 94 : 0 0
[ 4039.477446] snd_hda_intel 0000:02:00.0: rirb content @ 95 : 0 0
[ 4039.477447] snd_hda_intel 0000:02:00.0: rirb content @ 96 : 0 0
[ 4039.477448] snd_hda_intel 0000:02:00.0: rirb content @ 97 : 0 0
[ 4039.477449] snd_hda_intel 0000:02:00.0: rirb content @ 98 : 0 0
[ 4039.477449] snd_hda_intel 0000:02:00.0: rirb content @ 99 : 0 0
[ 4039.477450] snd_hda_intel 0000:02:00.0: rirb content @ 100 : 0 0
[ 4039.477451] snd_hda_intel 0000:02:00.0: rirb content @ 101 : 0 0
[ 4039.477452] snd_hda_intel 0000:02:00.0: rirb content @ 102 : 0 0
[ 4039.477452] snd_hda_intel 0000:02:00.0: rirb content @ 103 : 0 0
[ 4039.477453] snd_hda_intel 0000:02:00.0: rirb content @ 104 : 0 0
[ 4039.477454] snd_hda_intel 0000:02:00.0: rirb content @ 105 : 0 0
[ 4039.477455] snd_hda_intel 0000:02:00.0: rirb content @ 106 : 0 0
[ 4039.477455] snd_hda_intel 0000:02:00.0: rirb content @ 107 : 0 0
[ 4039.477456] snd_hda_intel 0000:02:00.0: rirb content @ 108 : 0 0
[ 4039.477457] snd_hda_intel 0000:02:00.0: rirb content @ 109 : 0 0
[ 4039.477458] snd_hda_intel 0000:02:00.0: rirb content @ 110 : 0 0
[ 4039.477458] snd_hda_intel 0000:02:00.0: rirb content @ 111 : 0 0
[ 4039.477459] snd_hda_intel 0000:02:00.0: rirb content @ 112 : 0 0
[ 4039.477460] snd_hda_intel 0000:02:00.0: rirb content @ 113 : 0 0
[ 4039.477461] snd_hda_intel 0000:02:00.0: rirb content @ 114 : 0 0
[ 4039.477461] snd_hda_intel 0000:02:00.0: rirb content @ 115 : 0 0
[ 4039.477462] snd_hda_intel 0000:02:00.0: rirb content @ 116 : 0 0
[ 4039.477463] snd_hda_intel 0000:02:00.0: rirb content @ 117 : 0 0
[ 4039.477464] snd_hda_intel 0000:02:00.0: rirb content @ 118 : 0 0
[ 4039.477464] snd_hda_intel 0000:02:00.0: rirb content @ 119 : 0 0
[ 4039.477465] snd_hda_intel 0000:02:00.0: rirb content @ 120 : 0 0
[ 4039.477466] snd_hda_intel 0000:02:00.0: rirb content @ 121 : 0 0
[ 4039.477467] snd_hda_intel 0000:02:00.0: rirb content @ 122 : 0 0
[ 4039.477468] snd_hda_intel 0000:02:00.0: rirb content @ 123 : 0 0
[ 4039.477469] snd_hda_intel 0000:02:00.0: rirb content @ 124 : 0 0
[ 4039.477469] snd_hda_intel 0000:02:00.0: rirb content @ 125 : 0 0
[ 4039.477470] snd_hda_intel 0000:02:00.0: rirb content @ 126 : 0 0
[ 4039.477471] snd_hda_intel 0000:02:00.0: rirb content @ 127 : 0 0
[ 4039.477472] snd_hda_intel 0000:02:00.0: rirb content @ 128 : 0 0
[ 4039.477473] snd_hda_intel 0000:02:00.0: rirb content @ 129 : 0 0
[ 4039.477474] snd_hda_intel 0000:02:00.0: rirb content @ 130 : 0 0
[ 4039.477475] snd_hda_intel 0000:02:00.0: rirb content @ 131 : 0 0
[ 4039.477475] snd_hda_intel 0000:02:00.0: rirb content @ 132 : 0 0
[ 4039.477476] snd_hda_intel 0000:02:00.0: rirb content @ 133 : 0 0
[ 4039.477477] snd_hda_intel 0000:02:00.0: rirb content @ 134 : 0 0
[ 4039.477478] snd_hda_intel 0000:02:00.0: rirb content @ 135 : 0 0
[ 4039.477478] snd_hda_intel 0000:02:00.0: rirb content @ 136 : 0 0
[ 4039.477479] snd_hda_intel 0000:02:00.0: rirb content @ 137 : 0 0
[ 4039.477480] snd_hda_intel 0000:02:00.0: rirb content @ 138 : 0 0
[ 4039.477481] snd_hda_intel 0000:02:00.0: rirb content @ 139 : 0 0
[ 4039.477481] snd_hda_intel 0000:02:00.0: rirb content @ 140 : 0 0
[ 4039.477482] snd_hda_intel 0000:02:00.0: rirb content @ 141 : 0 0
[ 4039.477483] snd_hda_intel 0000:02:00.0: rirb content @ 142 : 0 0
[ 4039.477484] snd_hda_intel 0000:02:00.0: rirb content @ 143 : 0 0
[ 4039.477484] snd_hda_intel 0000:02:00.0: rirb content @ 144 : 0 0
[ 4039.477485] snd_hda_intel 0000:02:00.0: rirb content @ 145 : 0 0
[ 4039.477486] snd_hda_intel 0000:02:00.0: rirb content @ 146 : 0 0
[ 4039.477487] snd_hda_intel 0000:02:00.0: rirb content @ 147 : 0 0
[ 4039.477487] snd_hda_intel 0000:02:00.0: rirb content @ 148 : 0 0
[ 4039.477488] snd_hda_intel 0000:02:00.0: rirb content @ 149 : 0 0
[ 4039.477489] snd_hda_intel 0000:02:00.0: rirb content @ 150 : 0 0
[ 4039.477490] snd_hda_intel 0000:02:00.0: rirb content @ 151 : 0 0
[ 4039.477490] snd_hda_intel 0000:02:00.0: rirb content @ 152 : 0 0
[ 4039.477491] snd_hda_intel 0000:02:00.0: rirb content @ 153 : 0 0
[ 4039.477492] snd_hda_intel 0000:02:00.0: rirb content @ 154 : 0 0
[ 4039.477493] snd_hda_intel 0000:02:00.0: rirb content @ 155 : 0 0
[ 4039.477494] snd_hda_intel 0000:02:00.0: rirb content @ 156 : 0 0
[ 4039.477494] snd_hda_intel 0000:02:00.0: rirb content @ 157 : 0 0
[ 4039.477495] snd_hda_intel 0000:02:00.0: rirb content @ 158 : 0 0
[ 4039.477496] snd_hda_intel 0000:02:00.0: rirb content @ 159 : 0 0
[ 4039.477497] snd_hda_intel 0000:02:00.0: rirb content @ 160 : 0 0
[ 4039.477497] snd_hda_intel 0000:02:00.0: rirb content @ 161 : 0 0
[ 4039.477498] snd_hda_intel 0000:02:00.0: rirb content @ 162 : 0 0
[ 4039.477499] snd_hda_intel 0000:02:00.0: rirb content @ 163 : 0 0
[ 4039.477500] snd_hda_intel 0000:02:00.0: rirb content @ 164 : 0 0
[ 4039.477501] snd_hda_intel 0000:02:00.0: rirb content @ 165 : 0 0
[ 4039.477501] snd_hda_intel 0000:02:00.0: rirb content @ 166 : 0 0
[ 4039.477502] snd_hda_intel 0000:02:00.0: rirb content @ 167 : 0 0
[ 4039.477503] snd_hda_intel 0000:02:00.0: rirb content @ 168 : 0 0
[ 4039.477504] snd_hda_intel 0000:02:00.0: rirb content @ 169 : 0 0
[ 4039.477504] snd_hda_intel 0000:02:00.0: rirb content @ 170 : 0 0
[ 4039.477505] snd_hda_intel 0000:02:00.0: rirb content @ 171 : 0 0
[ 4039.477506] snd_hda_intel 0000:02:00.0: rirb content @ 172 : 0 0
[ 4039.477507] snd_hda_intel 0000:02:00.0: rirb content @ 173 : 0 0
[ 4039.477507] snd_hda_intel 0000:02:00.0: rirb content @ 174 : 0 0
[ 4039.477508] snd_hda_intel 0000:02:00.0: rirb content @ 175 : 0 0
[ 4039.477509] snd_hda_intel 0000:02:00.0: rirb content @ 176 : 0 0
[ 4039.477510] snd_hda_intel 0000:02:00.0: rirb content @ 177 : 0 0
[ 4039.477510] snd_hda_intel 0000:02:00.0: rirb content @ 178 : 0 0
[ 4039.477511] snd_hda_intel 0000:02:00.0: rirb content @ 179 : 0 0
[ 4039.477512] snd_hda_intel 0000:02:00.0: rirb content @ 180 : 0 0
[ 4039.477513] snd_hda_intel 0000:02:00.0: rirb content @ 181 : 0 0
[ 4039.477513] snd_hda_intel 0000:02:00.0: rirb content @ 182 : 0 0
[ 4039.477514] snd_hda_intel 0000:02:00.0: rirb content @ 183 : 0 0
[ 4039.477515] snd_hda_intel 0000:02:00.0: rirb content @ 184 : 0 0
[ 4039.477516] snd_hda_intel 0000:02:00.0: rirb content @ 185 : 0 0
[ 4039.477516] snd_hda_intel 0000:02:00.0: rirb content @ 186 : 0 0
[ 4039.477517] snd_hda_intel 0000:02:00.0: rirb content @ 187 : 0 0
[ 4039.477518] snd_hda_intel 0000:02:00.0: rirb content @ 188 : 0 0
[ 4039.477519] snd_hda_intel 0000:02:00.0: rirb content @ 189 : 0 0
[ 4039.477520] snd_hda_intel 0000:02:00.0: rirb content @ 190 : 0 0
[ 4039.477521] snd_hda_intel 0000:02:00.0: rirb content @ 191 : 0 0
[ 4039.477522] snd_hda_intel 0000:02:00.0: rirb content @ 192 : 0 0
[ 4039.477522] snd_hda_intel 0000:02:00.0: rirb content @ 193 : 0 0
[ 4039.477523] snd_hda_intel 0000:02:00.0: rirb content @ 194 : 0 0
[ 4039.477524] snd_hda_intel 0000:02:00.0: rirb content @ 195 : 0 0
[ 4039.477525] snd_hda_intel 0000:02:00.0: rirb content @ 196 : 0 0
[ 4039.477526] snd_hda_intel 0000:02:00.0: rirb content @ 197 : 0 0
[ 4039.477526] snd_hda_intel 0000:02:00.0: rirb content @ 198 : 0 0
[ 4039.477527] snd_hda_intel 0000:02:00.0: rirb content @ 199 : 0 0
[ 4039.477528] snd_hda_intel 0000:02:00.0: rirb content @ 200 : 0 0
[ 4039.477529] snd_hda_intel 0000:02:00.0: rirb content @ 201 : 0 0
[ 4039.477529] snd_hda_intel 0000:02:00.0: rirb content @ 202 : 0 0
[ 4039.477530] snd_hda_intel 0000:02:00.0: rirb content @ 203 : 0 0
[ 4039.477531] snd_hda_intel 0000:02:00.0: rirb content @ 204 : 0 0
[ 4039.477532] snd_hda_intel 0000:02:00.0: rirb content @ 205 : 0 0
[ 4039.477532] snd_hda_intel 0000:02:00.0: rirb content @ 206 : 0 0
[ 4039.477533] snd_hda_intel 0000:02:00.0: rirb content @ 207 : 0 0
[ 4039.477534] snd_hda_intel 0000:02:00.0: rirb content @ 208 : 0 0
[ 4039.477535] snd_hda_intel 0000:02:00.0: rirb content @ 209 : 0 0
[ 4039.477535] snd_hda_intel 0000:02:00.0: rirb content @ 210 : 0 0
[ 4039.477536] snd_hda_intel 0000:02:00.0: rirb content @ 211 : 0 0
[ 4039.477537] snd_hda_intel 0000:02:00.0: rirb content @ 212 : 0 0
[ 4039.477538] snd_hda_intel 0000:02:00.0: rirb content @ 213 : 0 0
[ 4039.477538] snd_hda_intel 0000:02:00.0: rirb content @ 214 : 0 0
[ 4039.477539] snd_hda_intel 0000:02:00.0: rirb content @ 215 : 0 0
[ 4039.477540] snd_hda_intel 0000:02:00.0: rirb content @ 216 : 0 0
[ 4039.477541] snd_hda_intel 0000:02:00.0: rirb content @ 217 : 0 0
[ 4039.477541] snd_hda_intel 0000:02:00.0: rirb content @ 218 : 0 0
[ 4039.477542] snd_hda_intel 0000:02:00.0: rirb content @ 219 : 0 0
[ 4039.477543] snd_hda_intel 0000:02:00.0: rirb content @ 220 : 0 0
[ 4039.477544] snd_hda_intel 0000:02:00.0: rirb content @ 221 : 0 0
[ 4039.477544] snd_hda_intel 0000:02:00.0: rirb content @ 222 : 0 0
[ 4039.477545] snd_hda_intel 0000:02:00.0: rirb content @ 223 : 0 0
[ 4039.477546] snd_hda_intel 0000:02:00.0: rirb content @ 224 : 0 0
[ 4039.477547] snd_hda_intel 0000:02:00.0: rirb content @ 225 : 0 0
[ 4039.477547] snd_hda_intel 0000:02:00.0: rirb content @ 226 : 0 0
[ 4039.477548] snd_hda_intel 0000:02:00.0: rirb content @ 227 : 0 0
[ 4039.477549] snd_hda_intel 0000:02:00.0: rirb content @ 228 : 0 0
[ 4039.477550] snd_hda_intel 0000:02:00.0: rirb content @ 229 : 0 0
[ 4039.477550] snd_hda_intel 0000:02:00.0: rirb content @ 230 : 0 0
[ 4039.477551] snd_hda_intel 0000:02:00.0: rirb content @ 231 : 0 0
[ 4039.477552] snd_hda_intel 0000:02:00.0: rirb content @ 232 : 0 0
[ 4039.477553] snd_hda_intel 0000:02:00.0: rirb content @ 233 : 0 0
[ 4039.477553] snd_hda_intel 0000:02:00.0: rirb content @ 234 : 0 0
[ 4039.477554] snd_hda_intel 0000:02:00.0: rirb content @ 235 : 0 0
[ 4039.477555] snd_hda_intel 0000:02:00.0: rirb content @ 236 : 0 0
[ 4039.477556] snd_hda_intel 0000:02:00.0: rirb content @ 237 : 0 0
[ 4039.477556] snd_hda_intel 0000:02:00.0: rirb content @ 238 : 0 0
[ 4039.477557] snd_hda_intel 0000:02:00.0: rirb content @ 239 : 0 0
[ 4039.477558] snd_hda_intel 0000:02:00.0: rirb content @ 240 : 0 0
[ 4039.477559] snd_hda_intel 0000:02:00.0: rirb content @ 241 : 0 0
[ 4039.477559] snd_hda_intel 0000:02:00.0: rirb content @ 242 : 0 0
[ 4039.477560] snd_hda_intel 0000:02:00.0: rirb content @ 243 : 0 0
[ 4039.477561] snd_hda_intel 0000:02:00.0: rirb content @ 244 : 0 0
[ 4039.477562] snd_hda_intel 0000:02:00.0: rirb content @ 245 : 0 0
[ 4039.477562] snd_hda_intel 0000:02:00.0: rirb content @ 246 : 0 0
[ 4039.477563] snd_hda_intel 0000:02:00.0: rirb content @ 247 : 0 0
[ 4039.477564] snd_hda_intel 0000:02:00.0: rirb content @ 248 : 0 0
[ 4039.477565] snd_hda_intel 0000:02:00.0: rirb content @ 249 : 0 0
[ 4039.477565] snd_hda_intel 0000:02:00.0: rirb content @ 250 : 0 0
[ 4039.477566] snd_hda_intel 0000:02:00.0: rirb content @ 251 : 0 0
[ 4039.477567] snd_hda_intel 0000:02:00.0: rirb content @ 252 : 0 0
[ 4039.477568] snd_hda_intel 0000:02:00.0: rirb content @ 253 : 0 0
[ 4039.477568] snd_hda_intel 0000:02:00.0: rirb content @ 254 : 0 0
[ 4039.477569] snd_hda_intel 0000:02:00.0: rirb content @ 255 : 0 0
[ 4039.477570] snd_hda_intel 0000:02:00.0: rirb pos 2 : 0 0
[ 4039.477571] snd_hda_intel 0000:02:00.0: spurious response 0x0:0x0, rp =
=3D 2, wp =3D 2
[ 4039.477572] ------------[ cut here ]------------
[ 4039.477575] WARNING: CPU: 0 PID: 0 at sound/pci/hda/hda_controller.c:121=
2 azx_update_rirb+0x1a5/0x220 [snd_hda_controller]()
[ 4039.477576] BUG?
[ 4039.477576] Modules linked in: snd_hda_intel snd_hda_controller snd_hda_=
codec_generic snd_hda_codec snd_hwdep snd_pcm nls_utf8 isofs fuse ip6t_rpfi=
lter bnep bluetooth ip6t_REJECT cfg80211 xt_conntrack rfkill ebtable_nat eb=
table_broute bridge stp llc ebtable_filter ebtables ip6table_nat nf_conntra=
ck_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security ip6tab=
le_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_i=
pv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_security iptable=
_raw x86_pkg_temp_thermal coretemp kvm_intel vfat fat uas kvm usb_storage m=
xm_wmi snd_seq snd_seq_device crct10dif_pclmul crc32_pclmul crc32c_intel jo=
ydev snd_timer ghash_clmulni_intel mei_me snd mei microcode serio_raw pcspk=
r soundcore shpchp wmi video i2c_hid dw_dmac dw_dmac_core i2c_designware_pl=
atform
[ 4039.477599]=A0 acpi_pad i2c_designware_core radeon i2c_algo_bit drm_kms_=
helper ttm drm sdhci_acpi sdhci mmc_core alx i2c_core mdio [last unloaded: =
snd_hda_controller]
[ 4039.477605] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G=A0=A0=A0=A0=A0=A0=
=A0 W=A0=A0=A0=A0 3.16.0-rc4+ #2
[ 4039.477606] Hardware name: Gigabyte Technology Co., Ltd. G1.Sniper Z97/G=
1.Sniper Z97, BIOS F6 05/30/2014
[ 4039.477607]=A0 0000000000000000 92922082461d2d28 ffff88021ec03d90 ffffff=
ff816ff2e2
[ 4039.477608]=A0 ffff88021ec03dd8 ffff88021ec03dc8 ffffffff8108bead ffff88=
00d79d3800
[ 4039.477609]=A0 0000000000000000 0000000000000002 0000000000000000 000000=
0000000000
[ 4039.477611] Call Trace:
[ 4039.477612]=A0 <IRQ>=A0 [<ffffffff816ff2e2>] dump_stack+0x45/0x56
[ 4039.477617]=A0 [<ffffffff8108bead>] warn_slowpath_common+0x7d/0xa0
[ 4039.477619]=A0 [<ffffffff8108bf2c>] warn_slowpath_fmt+0x5c/0x80
[ 4039.477620]=A0 [<ffffffffa0304645>] azx_update_rirb+0x1a5/0x220 [snd_hda=
_controller]
[ 4039.477622]=A0 [<ffffffffa03048c9>] azx_interrupt+0x179/0x1c0 [snd_hda_c=
ontroller]
[ 4039.477624]=A0 [<ffffffff810e697e>] handle_irq_event_percpu+0x3e/0x1a0
[ 4039.477626]=A0 [<ffffffff810e6b16>] handle_irq_event+0x36/0x60
[ 4039.477628]=A0 [<ffffffff810e9ebc>] handle_fasteoi_irq+0x7c/0x140
[ 4039.477631]=A0 [<ffffffff81015eff>] handle_irq+0xbf/0x150
[ 4039.477633]=A0 [<ffffffff810b33fa>] ? atomic_notifier_call_chain+0x1a/0x=
20
[ 4039.477636]=A0 [<ffffffff8170968f>] do_IRQ+0x4f/0xf0
[ 4039.477637]=A0 [<ffffffff8170746d>] common_interrupt+0x6d/0x6d
[ 4039.477638]=A0 <EOI>=A0 [<ffffffff81597792>] ? cpuidle_enter_state+0x52/=
0xc0
[ 4039.477641]=A0 [<ffffffff815978b7>] cpuidle_enter+0x17/0x20
[ 4039.477643]=A0 [<ffffffff810d3035>] cpu_startup_entry+0x315/0x440
[ 4039.477646]=A0 [<ffffffff816f1427>] rest_init+0x77/0x80
[ 4039.477649]=A0 [<ffffffff81d280e1>] start_kernel+0x465/0x486
[ 4039.477651]=A0 [<ffffffff81d27a85>] ? set_init_arg+0x53/0x53
[ 4039.477652]=A0 [<ffffffff81d27120>] ? early_idt_handlers+0x120/0x120
[ 4039.477654]=A0 [<ffffffff81d275ee>] x86_64_start_reservations+0x2a/0x2c
[ 4039.477655]=A0 [<ffffffff81d2773d>] x86_64_start_kernel+0x14d/0x170
[ 4039.477656] ---[ end trace 63c0b6054db2a1eb ]---


Regards,
Vincent
