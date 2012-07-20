From: David Henningsson <david.henningsson@canonical.com>
Subject: [PULL REQUEST] hda-emu: Alsa info for Canonical
	certified systems
Date: Fri, 20 Jul 2012 12:03:43 +0200
Message-ID: <1342778623-7236-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F259265308
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2012 12:03:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 6e0c8f66e0a657c30d9d965d887af054cfae3eaf:

  Add a dummy linux/kernel.h (2012-07-16 11:34:08 +0200)

are available in the git repository at:

  git://kernel.ubuntu.com/diwic/hda-emu.git for-tiwai

for you to fetch changes up to fb3b3a7654452bdba188166ef9815baa15042e6f:

  hda-emu: Add alsa info for Canonical certified systems (2012-07-20 11:47:46 +0200)

----------------------------------------------------------------
David Henningsson (1):
      hda-emu: Add alsa info for Canonical certified systems

 .../92hd71b7x-dell-inspiron-1545-ccert-200910-4252 |  956 +++++++++++
 .../92hd71b7x-dell-inspiron-1545-ccert-200912-4896 |  961 +++++++++++
 .../92hd71b7x-dell-inspiron-1545-ccert-200912-4897 |  968 +++++++++++
 ...92hd73c1x5-dell-studio-xps-13-ccert-200910-4256 | 1107 +++++++++++++
 ...hd73c1x5-dell-studio-xps-1340-ccert-200912-4895 | 1100 +++++++++++++
 .../92hd75b3x5-hp-probook-6550b-ccert-201101-6954  | 1147 +++++++++++++
 ...2hd81b1c5-dell-latitude-e6410-ccert-201001-5167 | 1387 ++++++++++++++++
 ...hd81b1c5-dell-precision-m6500-ccert-201004-5601 | 1062 ++++++++++++
 .../92hd81b1c5-dell-vostro-1720-ccert-200910-4255  |  789 +++++++++
 .../92hd81b1x5-dell-inspiron-15r-ccert-201010-6645 |  949 +++++++++++
 ...2hd81b1x5-dell-latitude-e4310-ccert-201103-7379 | 1071 ++++++++++++
 .../92hd81b1x5-dell-vostro-3300-ccert-201001-4955  |  785 +++++++++
 .../92hd81b1x5-dell-vostro-3300-ccert-201004-5576  |  781 +++++++++
 .../92hd81b1x5-dell-vostro-3400-ccert-201004-5571  |  944 +++++++++++
 .../92hd81b1x5-dell-vostro-3500-ccert-201001-4959  |  962 +++++++++++
 ...1-3-dell-inspiron-15r--n5110--ccert-201012-6931 |  923 +++++++++++
 ...2hd87b1-3-dell-inspiron-m5110-ccert-201105-8042 |  904 +++++++++++
 ...2hd87b1-3-dell-inspiron-m5110-ccert-201105-8043 |  892 ++++++++++
 .../92hd87b1-3-dell-vostro-1440-ccert-201105-8046  |  916 +++++++++++
 .../92hd87b1-3-dell-vostro-3350-ccert-201101-6951  |  921 +++++++++++
 .../92hd87b1-3-dell-vostro-3550-ccert-201012-6933  |  969 +++++++++++
 ...92hd90bxx-dell-latitude-e5420-ccert-201107-8259 | 1170 +++++++++++++
 ...2hd90bxx-dell-latitude-e5420m-ccert-201101-7173 |  967 +++++++++++
 ...92hd90bxx-dell-latitude-e6220-ccert-201101-7178 | 1170 +++++++++++++
 ...92hd90bxx-dell-latitude-e6220-ccert-201102-7187 | 1168 +++++++++++++
 ...92hd90bxx-dell-latitude-e6220-ccert-201102-7188 | 1157 +++++++++++++
 .../92hd90bxx-dell-latitude-xt3-ccert-201104-7784  | 1182 ++++++++++++++
 ...2hd93bxx-dell-latitude-e6230-ccert-201202-10551 | 1164 +++++++++++++
 ...d1984a-dell-optiplex-360-usff-ccert-200908-3578 | 1145 +++++++++++++
 ...c259-dell-m101z-inspiron-1120-ccert-201103-7380 |  956 +++++++++++
 .../alc262-hp-z200-workstation-ccert-201011-6751   | 1102 +++++++++++++
 .../alc262-hp-z210-workstation-ccert-201107-8279   | 1270 +++++++++++++++
 .../alc262-hp-z400-workstation-ccert-201011-6753   | 1263 +++++++++++++++
 .../alc262-hp-z600-workstation-ccert-201103-7457   | 1640 +++++++++++++++++++
 .../alc262-hp-z800-workstation-ccert-201011-6754   | 1121 +++++++++++++
 ...l--satellite-pro-s500--intel--ccert-201002-5345 |  957 +++++++++++
 ...oshiba-tecra-s11-m11--nvidia--ccert-201002-5346 | 1319 +++++++++++++++
 .../alc269-asus-eee-pc-701sd-ccert-200903-2140     |  820 ++++++++++
 .../alc269-dell-latitude-13-ccert-201004-5570      |  815 ++++++++++
 .../alc269-dell-vostro-v13-ccert-201004-5572       |  804 +++++++++
 .../alc269-dell-vostro-v13-ccert-201004-5575       |  810 +++++++++
 .../alc269-dell-vostro-v13-ccert-201004-5578       |  805 +++++++++
 ...lc269-lenovo-thinkpad-edge-14-ccert-201011-6825 | 1022 ++++++++++++
 ...lc269-lenovo-thinkpad-edge-14-ccert-201101-6972 | 1016 ++++++++++++
 ...lc269-lenovo-thinkpad-edge-15-ccert-201011-6828 | 1013 ++++++++++++
 ...lc269-lenovo-thinkpad-edge-15-ccert-201101-6965 |  998 ++++++++++++
 .../alc269-lenovo-thinkpad-l512-ccert-201101-6973  | 1185 ++++++++++++++
 .../alc269-lenovo-thinkpad-sl410-ccert-201011-6829 |  934 +++++++++++
 .../alc269-lenovo-thinkpad-sl510-ccert-201011-6830 | 1017 ++++++++++++
 ...9vb-dell-inspiron-17r--n7110--ccert-201101-6957 | 1008 ++++++++++++
 ...9vb-dell-inspiron-17r--n7110--ccert-201101-6983 | 1009 ++++++++++++
 .../alc269vb-dell-inspiron-m4110-ccert-201105-8044 |  970 +++++++++++
 ...9vb-dell-inspiron-r14--n4110--ccert-201101-6952 |  987 +++++++++++
 .../alc269vb-dell-latitude-2110-ccert-201003-5427  |  824 ++++++++++
 .../alc269vb-dell-latitude-2110-ccert-201003-5428  |  824 ++++++++++
 .../alc269vb-dell-latitude-2110-ccert-201003-5429  |  813 ++++++++++
 .../alc269vb-dell-latitude-2120-ccert-201009-6529  |  826 ++++++++++
 .../alc269vb-dell-optiplex-790-ccert-201011-6873   | 1126 +++++++++++++
 .../alc269vb-dell-optiplex-980-ccert-201004-5593   | 1104 +++++++++++++
 .../alc269vb-dell-optiplex-xe-ccert-201005-5775    |  761 +++++++++
 .../alc269vb-toshiba-tecra-r700-ccert-201010-6637  | 1055 ++++++++++++
 ...ra-r850---r840---r830--intel--ccert-201103-7412 | 1077 ++++++++++++
 ...72-acer-aspire-one--za3-751h--ccert-200910-4251 |  891 ++++++++++
 ...alc272-dell-inspiron-one-2205-ccert-201009-6504 |  922 +++++++++++
 ...alc272-dell-inspiron-one-2305-ccert-201103-7378 | 1017 ++++++++++++
 ...alc272-dell-inspiron-one-2310-ccert-201009-6503 |  986 +++++++++++
 ...72-dell-mini-10-inspiron-1018-ccert-201010-6646 |  822 ++++++++++
 .../alc272-dell-vostro-330-ccert-201101-6960       |  907 +++++++++++
 ...62-rev1-acer-emachines-er1401-ccert-201006-5930 |  973 +++++++++++
 .../alc662-rev1-asus-eee-pc-900-ccert-200903-2141  |  863 ++++++++++
 ...662-rev1-dell-precision-t1500-ccert-201004-5590 | 1130 +++++++++++++
 .../alc662-rev1-dell-vostro-430-ccert-201004-5591  | 1666 +++++++++++++++++++
 ...lc662-rev1-hp-compaq-6005-pro-ccert-201011-6697 |  906 +++++++++++
 ...662-rev1-hp-compaq-8100-elite-ccert-201011-6701 | 1105 +++++++++++++
 .../alc662-rev1-hp-pro-2000-ccert-201011-6700      |  899 ++++++++++
 .../alc662-rev1-hp-pro-3000-mt-ccert-201011-6699   |  981 +++++++++++
 .../alc662-rev1-hp-rp5800-ccert-201202-10626       | 1091 +++++++++++++
 ...c662-rev1-hp-z210-workstation-ccert-201107-8280 | 1612 ++++++++++++++++++
 .../alc887-dell-inspiron-560-ccert-201010-6632     | 1398 ++++++++++++++++
 .../alc887-dell-inspiron-580-ccert-201010-6631     | 1512 +++++++++++++++++
 .../alc887-dell-studio-xps-ccert-200908-3521       | 1712 ++++++++++++++++++++
 .../alc887-vd-asus-et2012e-ccert-201201-10354      | 1160 +++++++++++++
 .../alc887-vd-dell-vostro-460-ccert-201009-6589    |  825 ++++++++++
 ...gic-id-4213-dell-vostro-3360-ccert-201203-10657 |  675 ++++++++
 .../cx20585-dell-vostro-1015-ccert-201010-6649     |  728 +++++++++
 .../cx20585-lenovo-thinkpad-t410-ccert-201101-7180 | 1458 +++++++++++++++++
 .../cx20585-lenovo-thinkpad-t410-ccert-201103-7376 | 1239 ++++++++++++++
 .../cx20585-lenovo-thinkpad-t510-ccert-201101-7181 | 1234 ++++++++++++++
 .../cx20585-lenovo-thinkpad-w510-ccert-201101-6974 | 1233 ++++++++++++++
 .../cx20585-lenovo-x201-ccert-201102-7305          | 1062 ++++++++++++
 .../cx20590-dell-inspiron-5420-ccert-201202-10511  | 1003 ++++++++++++
 .../cx20590-dell-inspiron-5520-ccert-201201-10377  |  994 ++++++++++++
 .../cx20590-dell-inspiron-7520-ccert-201203-10678  | 1005 ++++++++++++
 ...l-inspiron-n411z-inspiron-14z-ccert-201106-8252 | 1084 +++++++++++++
 .../cx20590-dell-vostro-3460-ccert-201202-10527    | 1017 ++++++++++++
 .../cx20590-dell-vostro-v131-ccert-201105-8048     |  826 ++++++++++
 .../cx20590-dell-vostro-v131-ccert-201105-8049     |  844 ++++++++++
 ...590-lenovo-thinkpad-edge-e320-ccert-201106-8229 |  866 ++++++++++
 ...90-lenovo-thinkpad-edge-e420s-ccert-201103-7425 |  866 ++++++++++
 ...590-lenovo-thinkpad-edge-e525-ccert-201107-8258 | 1036 ++++++++++++
 .../cx20590-lenovo-thinkpad-t420-ccert-201102-7230 | 1026 ++++++++++++
 .../cx20590-lenovo-thinkpad-t520-ccert-201102-7229 | 1266 +++++++++++++++
 .../canonical/cx20590-lenovo-x1-ccert-201104-7945  | 1032 ++++++++++++
 .../cx20590-lenovo-x121e-ccert-201106-8092         |  857 ++++++++++
 .../cx20641-dell-inspiron-620-ccert-201103-7434    | 1198 ++++++++++++++
 .../cx20641-dell-inspiron-620-ccert-201103-7435    | 1131 +++++++++++++
 .../cx20641-dell-optiplex-390-ccert-201101-7165    | 1166 +++++++++++++
 .../cx20641-dell-optiplex-390-ccert-201101-7166    | 1089 +++++++++++++
 .../cx20641-dell-optiplex-390-ccert-201101-7167    | 1164 +++++++++++++
 .../id-2c06-dell-inspiron-1525-ccert-200804-253    | 1191 ++++++++++++++
 .../stac9200-dell-inspiron-6400-ccert-200705-83    |  659 ++++++++
 .../stac9200-dell-inspiron-6400-ccert-200712-207   |  678 ++++++++
 .../stac9228-dell-inspiron-1420-ccert-200708-95    | 1066 ++++++++++++
 113 files changed, 116939 insertions(+)
 create mode 100644 codecs/canonical/92hd71b7x-dell-inspiron-1545-ccert-200910-4252
 create mode 100644 codecs/canonical/92hd71b7x-dell-inspiron-1545-ccert-200912-4896
 create mode 100644 codecs/canonical/92hd71b7x-dell-inspiron-1545-ccert-200912-4897
 create mode 100644 codecs/canonical/92hd73c1x5-dell-studio-xps-13-ccert-200910-4256
 create mode 100644 codecs/canonical/92hd73c1x5-dell-studio-xps-1340-ccert-200912-4895
 create mode 100644 codecs/canonical/92hd75b3x5-hp-probook-6550b-ccert-201101-6954
 create mode 100644 codecs/canonical/92hd81b1c5-dell-latitude-e6410-ccert-201001-5167
 create mode 100644 codecs/canonical/92hd81b1c5-dell-precision-m6500-ccert-201004-5601
 create mode 100644 codecs/canonical/92hd81b1c5-dell-vostro-1720-ccert-200910-4255
 create mode 100644 codecs/canonical/92hd81b1x5-dell-inspiron-15r-ccert-201010-6645
 create mode 100644 codecs/canonical/92hd81b1x5-dell-latitude-e4310-ccert-201103-7379
 create mode 100644 codecs/canonical/92hd81b1x5-dell-vostro-3300-ccert-201001-4955
 create mode 100644 codecs/canonical/92hd81b1x5-dell-vostro-3300-ccert-201004-5576
 create mode 100644 codecs/canonical/92hd81b1x5-dell-vostro-3400-ccert-201004-5571
 create mode 100644 codecs/canonical/92hd81b1x5-dell-vostro-3500-ccert-201001-4959
 create mode 100644 codecs/canonical/92hd87b1-3-dell-inspiron-15r--n5110--ccert-201012-6931
 create mode 100644 codecs/canonical/92hd87b1-3-dell-inspiron-m5110-ccert-201105-8042
 create mode 100644 codecs/canonical/92hd87b1-3-dell-inspiron-m5110-ccert-201105-8043
 create mode 100644 codecs/canonical/92hd87b1-3-dell-vostro-1440-ccert-201105-8046
 create mode 100644 codecs/canonical/92hd87b1-3-dell-vostro-3350-ccert-201101-6951
 create mode 100644 codecs/canonical/92hd87b1-3-dell-vostro-3550-ccert-201012-6933
 create mode 100644 codecs/canonical/92hd90bxx-dell-latitude-e5420-ccert-201107-8259
 create mode 100644 codecs/canonical/92hd90bxx-dell-latitude-e5420m-ccert-201101-7173
 create mode 100644 codecs/canonical/92hd90bxx-dell-latitude-e6220-ccert-201101-7178
 create mode 100644 codecs/canonical/92hd90bxx-dell-latitude-e6220-ccert-201102-7187
 create mode 100644 codecs/canonical/92hd90bxx-dell-latitude-e6220-ccert-201102-7188
 create mode 100644 codecs/canonical/92hd90bxx-dell-latitude-xt3-ccert-201104-7784
 create mode 100644 codecs/canonical/92hd93bxx-dell-latitude-e6230-ccert-201202-10551
 create mode 100644 codecs/canonical/ad1984a-dell-optiplex-360-usff-ccert-200908-3578
 create mode 100644 codecs/canonical/alc259-dell-m101z-inspiron-1120-ccert-201103-7380
 create mode 100644 codecs/canonical/alc262-hp-z200-workstation-ccert-201011-6751
 create mode 100644 codecs/canonical/alc262-hp-z210-workstation-ccert-201107-8279
 create mode 100644 codecs/canonical/alc262-hp-z400-workstation-ccert-201011-6753
 create mode 100644 codecs/canonical/alc262-hp-z600-workstation-ccert-201103-7457
 create mode 100644 codecs/canonical/alc262-hp-z800-workstation-ccert-201011-6754
 create mode 100644 codecs/canonical/alc268-toshiba-tecra-a11-m11--intel--satellite-pro-s500--intel--ccert-201002-5345
 create mode 100644 codecs/canonical/alc268-toshiba-tecra-s11-m11--nvidia--ccert-201002-5346
 create mode 100644 codecs/canonical/alc269-asus-eee-pc-701sd-ccert-200903-2140
 create mode 100644 codecs/canonical/alc269-dell-latitude-13-ccert-201004-5570
 create mode 100644 codecs/canonical/alc269-dell-vostro-v13-ccert-201004-5572
 create mode 100644 codecs/canonical/alc269-dell-vostro-v13-ccert-201004-5575
 create mode 100644 codecs/canonical/alc269-dell-vostro-v13-ccert-201004-5578
 create mode 100644 codecs/canonical/alc269-lenovo-thinkpad-edge-14-ccert-201011-6825
 create mode 100644 codecs/canonical/alc269-lenovo-thinkpad-edge-14-ccert-201101-6972
 create mode 100644 codecs/canonical/alc269-lenovo-thinkpad-edge-15-ccert-201011-6828
 create mode 100644 codecs/canonical/alc269-lenovo-thinkpad-edge-15-ccert-201101-6965
 create mode 100644 codecs/canonical/alc269-lenovo-thinkpad-l512-ccert-201101-6973
 create mode 100644 codecs/canonical/alc269-lenovo-thinkpad-sl410-ccert-201011-6829
 create mode 100644 codecs/canonical/alc269-lenovo-thinkpad-sl510-ccert-201011-6830
 create mode 100644 codecs/canonical/alc269vb-dell-inspiron-17r--n7110--ccert-201101-6957
 create mode 100644 codecs/canonical/alc269vb-dell-inspiron-17r--n7110--ccert-201101-6983
 create mode 100644 codecs/canonical/alc269vb-dell-inspiron-m4110-ccert-201105-8044
 create mode 100644 codecs/canonical/alc269vb-dell-inspiron-r14--n4110--ccert-201101-6952
 create mode 100644 codecs/canonical/alc269vb-dell-latitude-2110-ccert-201003-5427
 create mode 100644 codecs/canonical/alc269vb-dell-latitude-2110-ccert-201003-5428
 create mode 100644 codecs/canonical/alc269vb-dell-latitude-2110-ccert-201003-5429
 create mode 100644 codecs/canonical/alc269vb-dell-latitude-2120-ccert-201009-6529
 create mode 100644 codecs/canonical/alc269vb-dell-optiplex-790-ccert-201011-6873
 create mode 100644 codecs/canonical/alc269vb-dell-optiplex-980-ccert-201004-5593
 create mode 100644 codecs/canonical/alc269vb-dell-optiplex-xe-ccert-201005-5775
 create mode 100644 codecs/canonical/alc269vb-toshiba-tecra-r700-ccert-201010-6637
 create mode 100644 codecs/canonical/alc269vb-toshiba-tecra-r850---r840---r830--intel--ccert-201103-7412
 create mode 100644 codecs/canonical/alc272-acer-aspire-one--za3-751h--ccert-200910-4251
 create mode 100644 codecs/canonical/alc272-dell-inspiron-one-2205-ccert-201009-6504
 create mode 100644 codecs/canonical/alc272-dell-inspiron-one-2305-ccert-201103-7378
 create mode 100644 codecs/canonical/alc272-dell-inspiron-one-2310-ccert-201009-6503
 create mode 100644 codecs/canonical/alc272-dell-mini-10-inspiron-1018-ccert-201010-6646
 create mode 100644 codecs/canonical/alc272-dell-vostro-330-ccert-201101-6960
 create mode 100644 codecs/canonical/alc662-rev1-acer-emachines-er1401-ccert-201006-5930
 create mode 100644 codecs/canonical/alc662-rev1-asus-eee-pc-900-ccert-200903-2141
 create mode 100644 codecs/canonical/alc662-rev1-dell-precision-t1500-ccert-201004-5590
 create mode 100644 codecs/canonical/alc662-rev1-dell-vostro-430-ccert-201004-5591
 create mode 100644 codecs/canonical/alc662-rev1-hp-compaq-6005-pro-ccert-201011-6697
 create mode 100644 codecs/canonical/alc662-rev1-hp-compaq-8100-elite-ccert-201011-6701
 create mode 100644 codecs/canonical/alc662-rev1-hp-pro-2000-ccert-201011-6700
 create mode 100644 codecs/canonical/alc662-rev1-hp-pro-3000-mt-ccert-201011-6699
 create mode 100644 codecs/canonical/alc662-rev1-hp-rp5800-ccert-201202-10626
 create mode 100644 codecs/canonical/alc662-rev1-hp-z210-workstation-ccert-201107-8280
 create mode 100644 codecs/canonical/alc887-dell-inspiron-560-ccert-201010-6632
 create mode 100644 codecs/canonical/alc887-dell-inspiron-580-ccert-201010-6631
 create mode 100644 codecs/canonical/alc887-dell-studio-xps-ccert-200908-3521
 create mode 100644 codecs/canonical/alc887-vd-asus-et2012e-ccert-201201-10354
 create mode 100644 codecs/canonical/alc887-vd-dell-vostro-460-ccert-201009-6589
 create mode 100644 codecs/canonical/cirrus-logic-id-4213-dell-vostro-3360-ccert-201203-10657
 create mode 100644 codecs/canonical/cx20585-dell-vostro-1015-ccert-201010-6649
 create mode 100644 codecs/canonical/cx20585-lenovo-thinkpad-t410-ccert-201101-7180
 create mode 100644 codecs/canonical/cx20585-lenovo-thinkpad-t410-ccert-201103-7376
 create mode 100644 codecs/canonical/cx20585-lenovo-thinkpad-t510-ccert-201101-7181
 create mode 100644 codecs/canonical/cx20585-lenovo-thinkpad-w510-ccert-201101-6974
 create mode 100644 codecs/canonical/cx20585-lenovo-x201-ccert-201102-7305
 create mode 100644 codecs/canonical/cx20590-dell-inspiron-5420-ccert-201202-10511
 create mode 100644 codecs/canonical/cx20590-dell-inspiron-5520-ccert-201201-10377
 create mode 100644 codecs/canonical/cx20590-dell-inspiron-7520-ccert-201203-10678
 create mode 100644 codecs/canonical/cx20590-dell-inspiron-n411z-inspiron-14z-ccert-201106-8252
 create mode 100644 codecs/canonical/cx20590-dell-vostro-3460-ccert-201202-10527
 create mode 100644 codecs/canonical/cx20590-dell-vostro-v131-ccert-201105-8048
 create mode 100644 codecs/canonical/cx20590-dell-vostro-v131-ccert-201105-8049
 create mode 100644 codecs/canonical/cx20590-lenovo-thinkpad-edge-e320-ccert-201106-8229
 create mode 100644 codecs/canonical/cx20590-lenovo-thinkpad-edge-e420s-ccert-201103-7425
 create mode 100644 codecs/canonical/cx20590-lenovo-thinkpad-edge-e525-ccert-201107-8258
 create mode 100644 codecs/canonical/cx20590-lenovo-thinkpad-t420-ccert-201102-7230
 create mode 100644 codecs/canonical/cx20590-lenovo-thinkpad-t520-ccert-201102-7229
 create mode 100644 codecs/canonical/cx20590-lenovo-x1-ccert-201104-7945
 create mode 100644 codecs/canonical/cx20590-lenovo-x121e-ccert-201106-8092
 create mode 100644 codecs/canonical/cx20641-dell-inspiron-620-ccert-201103-7434
 create mode 100644 codecs/canonical/cx20641-dell-inspiron-620-ccert-201103-7435
 create mode 100644 codecs/canonical/cx20641-dell-optiplex-390-ccert-201101-7165
 create mode 100644 codecs/canonical/cx20641-dell-optiplex-390-ccert-201101-7166
 create mode 100644 codecs/canonical/cx20641-dell-optiplex-390-ccert-201101-7167
 create mode 100644 codecs/canonical/id-2c06-dell-inspiron-1525-ccert-200804-253
 create mode 100644 codecs/canonical/stac9200-dell-inspiron-6400-ccert-200705-83
 create mode 100644 codecs/canonical/stac9200-dell-inspiron-6400-ccert-200712-207
 create mode 100644 codecs/canonical/stac9228-dell-inspiron-1420-ccert-200708-95
