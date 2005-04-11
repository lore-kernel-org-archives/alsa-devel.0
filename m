From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: [PATCH] ld10k1: init_live update
Date: Mon, 11 Apr 2005 09:31:11 +0200
Message-ID: <20050411073111.GA10929@skinner.hem.za.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

init_live update:

* Added IEC958 Optical Raw Playback
* Changed to mono switches saving GPRs
* Renamed controls to match the Audigy driver closer.
* switch_2x2.asm: Switch 2 x 2 channels
* mono_switch_2.asm: Mono Switch 2 channels
* mono_switch_2x2.asm: Mono Switch 2 x 2 channels
* prologic.asm: LFE output added

diffstat output:
 ld10k1/setup/effects/Makefile.am  |    6
 setup/effects/mono_switch_2.asm   |   14 +
 setup/effects/mono_switch_2x2.asm |   33 ++
 setup/effects/prologic.asm        |    4
 setup/effects/switch_2x2.asm      |   34 ++
 setup/init_live.in                |  467 +++++++++++++++++++++++++-----------
 6 files changed, 404 insertions(+), 154 deletions(-)

Signed-off-by: Mikael Magnusson <mikma@users.sourceforge.net>


--OgqxwSJOaUobr8KG
Content-Type: text/x-patch; charset=us-ascii;
	name="ld10k1-init_live_0.1.8-2.patch"
Content-Disposition: inline; filename="ld10k1-init_live_0.1.8-2.patch"

diff -u ld10k1/setup/effects/Makefile.am ld10k1/setup/effects/Makefile.am
--- ld10k1/setup/effects/Makefile.am	2005-04-10 12:05:19.069307463 +0200
+++ ld10k1/setup/effects/Makefile.am	2005-04-10 18:22:12.526730485 +0200
@@ -2,13 +2,15 @@
 	simple.asm vol_master.asm tone.asm \
 	vol_2.asm output.asm switch_2.asm \
 	sto51.asm switch_6.asm copy_2.asm \
-	prologic.asm fxbus.asm
+	prologic.asm fxbus.asm switch_2x2.asm \
+	mono_switch_2.asm mono_switch_2x2.asm
 
 
 dist_effects_DATA = simple.emu10k1 vol_master.emu10k1 tone.emu10k1 \
 	vol_2.emu10k1 output.emu10k1 switch_2.emu10k1 \
 	sto51.emu10k1 switch_6.emu10k1 copy_2.emu10k1 \
-	prologic.emu10k1 fxbus.emu10k1
+	prologic.emu10k1 fxbus.emu10k1 switch_2x2.emu10k1 \
+	mono_switch_2.emu10k1 mono_switch_2x2.emu10k1
 
 MAINTAINERCLEANFILES = $(dist_effects_DATA)
 
only in patch2:
unchanged:
--- ld10k1.cvs/setup/effects/mono_switch_2.asm	1970-01-01 01:00:00.000000000 +0100
+++ ld10k1/setup/effects/mono_switch_2.asm	2005-04-10 18:21:35.160461953 +0200
@@ -0,0 +1,14 @@
+;PZU
+;;; Mikael Magnusson
+
+    name "Mono Switch 2 channels"
+    include "emu_constants.asm"
+    
+Left	IO
+Right	IO
+
+switch control 0,0,1
+
+    macints Left, C_0, Left, switch
+    macints Right, C_0, Right, switch
+    end
only in patch2:
unchanged:
--- ld10k1.cvs/setup/effects/mono_switch_2x2.asm	1970-01-01 01:00:00.000000000 +0100
+++ ld10k1/setup/effects/mono_switch_2x2.asm	2005-04-10 18:21:35.161461720 +0200
@@ -0,0 +1,33 @@
+; Mikael Magnusson
+    name "Mono Switch 2 x 2 channels"
+    include "emu_constants.asm"
+    
+Left0	IO
+Right0	IO
+Left1	IO
+Right1	IO
+
+tmp0	dyn 1
+tmp1	dyn 1
+
+switch control 0,0,1
+
+switch1	macro	dst, src, sw
+	macints	dst, C_0, src, sw
+	endm
+
+switch_neg macro dst, src
+	andxor	dst, src, C_1, C_1
+	endm
+
+switch2 macro dst, src0, src1, sw
+	switch1 tmp0, src1, sw
+	switch_neg tmp1, sw
+	switch1 tmp1, src0, tmp1
+	acc3 dst, tmp0, tmp1, C_0	
+	endm
+
+	switch2 Left0, Left0, Left1, switch
+	switch2 Right0, Right0, Right1, switch
+
+	end
only in patch2:
unchanged:
--- ld10k1.cvs/setup/effects/prologic.asm	2005-04-10 11:57:55.000000000 +0200
+++ ld10k1/setup/effects/prologic.asm	2005-04-10 18:21:35.162461486 +0200
@@ -38,6 +38,7 @@
 Ls		io
 Rs		io
 C		io			; Center
+LFE		io			; LFE
 
 ;----------------------------------------
 tmp		dyn
@@ -111,5 +112,8 @@
 	sub	R, Rt, read		; R = R - rear
 	sub	L, Lt, read  		; L = L - rear
 
+	add	LFE, Lt, Rt		; tmp = Lt + Rt
+	lpf	LFE, mhp, tmp		; LFE = LowPass((n)Hz, tmp)
+
 	end
 ;========================================
only in patch2:
unchanged:
--- ld10k1.cvs/setup/effects/switch_2x2.asm	1970-01-01 01:00:00.000000000 +0100
+++ ld10k1/setup/effects/switch_2x2.asm	2005-04-10 18:21:35.162461486 +0200
@@ -0,0 +1,34 @@
+; Mikael Magnusson
+    name "Switch 2 - 2 channels"
+    include "emu_constants.asm"
+    
+Left0	IO
+Right0	IO
+Left1	IO
+Right1	IO
+
+tmp0	dyn 1
+tmp1	dyn 1
+
+switchL control 0,0,1
+switchR control 0,0,1
+
+switch	macro	dst, src, sw
+	macints	dst, C_0, src, sw
+	endm
+
+switch_neg macro dst, src
+	andxor	dst, src, C_1, C_1
+	endm
+
+switch2 macro dst, src0, src1, sw
+	switch tmp0, src1, sw
+	switch_neg tmp1, sw
+	switch tmp1, src0, tmp1
+	acc3 dst, tmp0, tmp1, C_0	
+	endm
+
+	switch2 Left0, Left0, Left1, switchL
+	switch2 Right0, Right0, Right1, switchR
+
+	end
only in patch2:
unchanged:
--- ld10k1.cvs/setup/init_live.in	2005-04-10 11:57:55.000000000 +0200
+++ ld10k1/setup/init_live.in	2005-04-10 18:21:26.074585073 +0200
@@ -1,39 +1,93 @@
 #!/bin/sh
 #
-# Copyright (c) 2004 Mikael Magnusson <mikma@users.sourceforge.net>
+# Copyright (c) 2004-2005 Mikael Magnusson <mikma@users.sourceforge.net>
 #
 
-LO10K1=@bindir@/lo10k1
+bindir=@bindir@
+LO10K1=${bindir}/lo10k1
+
+## Default configuration
+#
+DECODER=SIMPLE51
+#DECODER=PROLOGIC
+#DECODER=BOTH
+
+# Inputs
+FXIN_PCM_89=1
+EXTIN_AC97=1
+EXTIN_SPDIF_CD=1
+#EXTIN_ZOOM=1
+#EXTIN_TOSLINK=1
+#EXTIN_LINE1=1
+#EXTIN_COAX_SPDIF=1
+#EXTIN_LINE2=1
+
+# Outputs
+EXTOUT_ANALOG_FRONT=1
+EXTOUT_ANALOG_REAR=1
+EXTOUT_ANALOG_CENTER=1
+EXTOUT_ANALOG_LFE=1
+#EXTOUT_IEC958=1
+#EXTOUT_REAR=1
+#EXTOUT_CENTER=1
+#EXTOUT_LFE=1
+EXTOUT_HEADPHONE=1
+
+if [ -r /etc/default/ld10k1 ]; then
+    . /etc/default/ld10k1
+fi
 
 #LO10K1="valgrind --num-callers=6 ../lo10k1"
 
 DEBUG=0
 
-function runlo10k1
+std_playback=playback
+#std_playback=playback_noswitch
+std_capture=capture
+#std_capture=capture_noswitch
+
+function log
 {
-    if test $DEBUG -gt 2 ; then
-	echo $LO10K1 "$@"
+    local level=$1
+
+    shift
+
+    if [ $DEBUG -gt $level ]; then
+	echo "$@"
     fi
+}
+
+function runlo10k1
+{
+    log 2 $LO10K1 "$@"
 
     $LO10K1 "$@"
 
     res=$?
-    
 
-    if test $res -ne 0 ; then
+    if [ $res -ne 0 ]; then
 	echo Failed $LO10K1 "$@"
+	exit 1
     fi
 }
 
+function rename
+{
+    port=$1
+    name=$2
+
+    log 1 "rename  $port = $name"
+
+    runlo10k1 --renam "$port=$name"
+}
+
 function connect
 {
     from=$1
     op=$2
     to=$3
 
-    if test $DEBUG -gt 1 ; then
-	echo "connect  $from $op $to"
-    fi
+    log 1 "connect  $from $op $to"
 
     runlo10k1 --conadd "$from$op$to"
 }
@@ -43,9 +97,7 @@
     local name=$1
     local port=$2
 
-    if test $DEBUG -gt 0 ; then
-	echo "copy              \"$name\" $port"
-    fi
+    log 0 "copy              \"$name\" $port"
 
     # Copy
     runlo10k1 -n --patch_name "$name Copy" -a copy_2.emu10k1
@@ -58,13 +110,12 @@
     local name=$1
     local port=$2
     local default=$3
+    local index=${4:-0}
 
-    if test $DEBUG -gt 1 ; then
-	echo "volume            \"$name\" $port default=$default"
-    fi
+    log 1 "volume            \"$name\" $port default=$default"
 
     # Volume
-    runlo10k1 -n --ctrl "c-Left,Right:$name Volume,t-$name Volume:1,s-$name Volume:$default" --patch_name "$name Volume" -a vol_2.emu10k1
+    runlo10k1 -n --ctrl "c-Left,Right:$name Volume,t-$name Volume:1,s-$name Volume:$default,i-$name Volume:${index}" --patch_name "$name Volume" -a vol_2.emu10k1
     # Input
     connect "PIN($name Volume)" '=' "$port"
 }
@@ -74,13 +125,12 @@
     local name=$1
     local port=$2
     local default=$3
+    local index=$4
 
-    if test $DEBUG -gt 1 ; then
-	echo "master volume \"$name\" $port default=$default"
-    fi
+    log 1 "master volume \"$name\" $port default=$default"
 
     # Master
-    runlo10k1 -n --ctrl "c-VolM:$name Volume,t-$name Volume:1,s-$name Volume:$default" --patch_name "$name Volume" -a vol_master.emu10k1
+    runlo10k1 -n --ctrl "c-VolM:$name Volume,t-$name Volume:1,s-$name Volume:$default,i-$name Volume:$index" --patch_name "$name Volume" -a vol_master.emu10k1
     # Input
     connect "$port" '=' "PIN($name Volume)"
 }
@@ -91,28 +141,58 @@
     local port=$2
     local default=$3
 
-    if test $DEBUG -gt 1 ; then
-	echo "switch            \"$name\" $port default=$default"
-    fi
+    log 1 "switch            \"$name\" $port default=$default"
 
     # Switch
-    runlo10k1 -n --ctrl "c-switchL,switchR:$name Switch,t-$name Switch:4,s-$name Switch:$default" --patch_name "$name Switch" -a switch_2.emu10k1
+    #runlo10k1 -n --ctrl "c-switchL,switchR:$name Switch,t-$name Switch:4,s-$name Switch:$default" --patch_name "$name Switch" -a switch_2.emu10k1
+    runlo10k1 -n --ctrl "c-switch:$name Switch,t-$name Switch:4,s-$name Switch:$default" --patch_name "$name Switch" -a mono_switch_2.emu10k1
     # Input
     connect "PIN($name Switch)" '>' "$port"
 }
 
+function switch_2x2
+{
+    local name=$1
+    local port1=$2
+    local port2=$3
+    local default=$4
+
+    log 1 "switch 2x2        \"$name\" $port1 $port2 default=$default"
+
+    # Switch
+    runlo10k1 -n --ctrl "c-switchL,switchR:$name Switch,t-$name Switch:4,s-$name Switch:$default" --patch_name "$name Switch" -a switch_2x2.emu10k1
+    # Input
+    connect "PIN($name Switch,0,1)" '>' "$port1"
+    connect "PIN($name Switch,2,3)" '>' "$port2"
+}
+
+function switch_5x2
+{
+    local name=$1
+    local port1=$2
+    local port2=$3
+    local default=$4
+
+    log 1 "switch 5x2        \"$name\" $port1 $port2 default=$default"
+
+    # Switch
+    runlo10k1 -n --ctrl "c-switch:$name Switch,t-$name Switch:4,s-$name Switch:$default" --patch_name "$name Switch" -a switch_5x2.emu10k1
+    # Input
+    connect "PIN($name Switch,0,1,2,3,4)" '>' "$port1"
+    connect "PIN($name Switch,5,6,7,8,9)" '>' "$port2"
+}
+
 function master_switch
 {
     local name=$1
     local port=$2
     local default=$3
+    local index=$4
 
-    if test $DEBUG -gt 1 ; then
-	echo "master_switch \"$name\" $port default=$default"
-    fi
+    log 1 "master_switch \"$name\" $port default=$default"
 
     # Master switch
-    runlo10k1 -n --ctrl "c-switch:$name Switch,t-$name Switch:4,s-$name Switch:$default" --patch_name "$name Switch" -a switch_6.emu10k1
+    runlo10k1 -n --ctrl "c-switch:$name Switch,t-$name Switch:4,s-$name Switch:$default,i-$name Switch:$index" --patch_name "$name Switch" -a switch_6.emu10k1
     # Input
     connect "PIN($name Switch)" '=' "$port"
 }
@@ -122,15 +202,13 @@
     name=$1
     port=$2
 
-    if test $DEBUG -gt 0 ; then
-	echo "playback          \"$name\" $port"
-    fi
+    log 0 "playback          \"$name\" $port"
 
     # Switch
     switch "$name Playback" "$port" "1#1"
     volume "$name Playback" "POUT($name Playback Switch)" "0#0"
     # Output
-    connect "POUT($name Playback Volume)" '>' "PIN(Wave Stereo To 51,0,1)"
+    add_output "POUT($name Playback Volume)"
 }
 
 function playback_noswitch
@@ -138,14 +216,12 @@
     name=$1
     port=$2
 
-    if test $DEBUG -gt 0 ; then
-	echo "playback_noswitch \"$name\" $port"
-    fi
+    log 0 "playback_noswitch \"$name\" $port"
 
     # Switch
     volume "$name Playback" "$port" "0#0"
     # Output
-    connect "POUT($name Playback Volume)" '>' "PIN(Wave Stereo To 51,0,1)"
+    add_output "POUT($name Playback Volume)"
 }
 
 function capture
@@ -153,9 +229,7 @@
     name=$1
     port=$2
 
-    if test $DEBUG -gt 0 ; then
-	echo "capture           \"$name\" $port"
-    fi
+    log 0 "capture           \"$name\" $port"
 
     # Capture switch
     switch "$name Capture" "$port" "0#0"
@@ -169,9 +243,7 @@
     name=$1
     port=$2
 
-    if test $DEBUG -gt 0 ; then
-	echo "capture_noswitch  \"$name\" $port"
-    fi
+    log 0 "capture_noswitch  \"$name\" $port"
 
     # Capture switch
     volume "$name Capture" "$port" "100#100"
@@ -183,14 +255,13 @@
 {
     local name=$1
     local port=$2
+    local index=$3
 
-    if test $DEBUG -gt 0 ; then
-	echo "master \"$name\" $port"
-    fi
+    log 0 "master            \"$name\" $port"
 
     # Switch
-    master_volume "$name Playback" "$port" "100"
-    master_switch "$name Playback" "POUT($name Playback Volume)" "1"
+    master_volume "$name Playback" "$port" 100 $index
+    master_switch "$name Playback" "POUT($name Playback Volume)" 1 $index
 }
 
 function dump_patches
@@ -206,60 +277,78 @@
     exit
 }
 
-
-function simple_stereo_to_51
+function add_output
 {
-    local name=$1
-    local port=$2
+    local port=$1
 
-    if test $DEBUG -gt 1 ; then
-	echo "simple_stereo_to_51 \"$name\" $port"
-    fi
+    $add_output_func "$port"
+}
 
-# Stereo to 5.1
-    runlo10k1 -n --ctrl "c-Left,Right:$name Playback Volume,t-$name Playback Volume:1,s-$name Playback Volume:100#100,c-LeftSurr,RightSurr:$name Surround Playback Volume,t-$name Surround Playback Volume:1,c-Center:$name Center Playback Volume,t-$name Center Playback Volume:1,c-LFE:$name LFE Playback Volume,t-$name LFE Playback Volume:1" --patch_name "$name Stereo To 51" -a sto51.emu10k1
-# Input
-    connect "$port" '>' "PIN($name Stereo To 51,0,1)"
+function add_output_tone_2
+{
+    local port=$1
 
-# Output
-    connect "POUT($name Stereo To 51,0,1,2,3,4)" '>' "PIN(Tone Control,0,1,2,3,4)"
+    connect "$port" '>' "PIN(Tone Control,0,1)"
 }
 
-function prologic
+function add_output_simple_2
 {
-    local name=$1
-    local port=$2
+    local port=$1
 
-    if test $DEBUG -gt 1 ; then
-	echo "prologic \"$name\" $port"
-    fi
+    connect "$port" '>' "PIN(Wave Simple Stereo To 51,0,1)"
+}
 
-# Stereo to 5.1
-    runlo10k1 -n --ctrl "" --patch_name "$name Stereo To 51" -a prologic.emu10k1
-# Input
-    connect "PIN($name Stereo To 51,0,1)" '>' "$port"
+function add_output_prologic_2
+{
+    local port=$1
 
-# PCM Multi
-    runlo10k1 -n --ctrl "c-Left,Right:$name Playback Volume,t-$name Playback Volume:1,c-LeftSurr,RightSurr:$name Surround Playback Volume,t-$name Surround Playback Volume:1,c-Center:$name Center Playback Volume,t-$name Center Playback Volume:1,c-LFE:$name LFE Playback Volume,t-LFE Playback Volume:1" --patch_name "$name Multi Volume" -a simple.emu10k1
-# Input
-    connect "POUT($name Stereo To 51)" '=' "PIN($name Multi Volume,0,1,2,3,4)"
+    connect "$port" '>' "PIN(Wave Prologic,0,1)"
+}
 
-# Output
-    connect "POUT($name Multi Volume,0,1,2,3,4)" '>' "PIN(Tone Control,0,1,2,3,4)"
+function add_output_switched_2
+{
+    local port=$1
+
+    add_output_simple_2 "$port"
+    add_output_prologic_2 "$port"
 }
 
-function stereo_to_51
+
+function simple_stereo_to_51
 {
     local name=$1
-    local port=$2
+    local control=$2
+    local port=$3
+
+    log 0 "simple_stereo_to_51 \"$name\" $port"
 
-    if test $DEBUG -gt 0 ; then
-	echo "stereo_to_51 \"$name\" $port"
+# Simple Stereo to 5.1
+    runlo10k1 -n --ctrl "c-Left,Right:${control}Front Playback Volume,t-${control}Front Playback Volume:1,s-${control}Front Playback Volume:100#100,c-LeftSurr,RightSurr:${control}Surround Playback Volume,t-${control}Surround Playback Volume:1,c-Center:${control}Center Playback Volume,t-${control}Center Playback Volume:1,c-LFE:${control}LFE Playback Volume,t-${control}LFE Playback Volume:1" --patch_name "$name Simple Stereo To 51" -a sto51.emu10k1
+# Input
+    if [ "$port" != "" ]; then
+	connect "$port" '>' "PIN($name Simple Stereo To 51,0,1)"
     fi
+}
 
-#    simple_stereo_to_51 "$name" "$port"
-    prologic "$name" "$port"
+function prologic
+{
+    local name=$1
+    local control=$2
+    local port=$3
 
+    log 0 "prologic          \"$name\" $port"
+
+# Stereo to 5.1
+    runlo10k1 -n --ctrl "" --patch_name "$name Prologic" -a prologic.emu10k1
+# Input
+    if [ "$port" != "" ]; then
+	connect "PIN($name Prologic,0,1)" '>' "$port"
+    fi
+
+# PCM Multi
+    runlo10k1 -n --ctrl "c-Left,Right:${control}Front Playback Volume,t-${control}Front Playback Volume:1,c-LeftSurr,RightSurr:${control}Surround Playback Volume,t-${control}Surround Playback Volume:1,c-Center:${control}Center Playback Volume,t-${control}Center Playback Volume:1,c-LFE:${control}LFE Playback Volume,t-${control}LFE Playback Volume:1" --patch_name "$name Multi Volume" -a simple.emu10k1
+# Input
+    connect "POUT($name Prologic)" '=' "PIN($name Multi Volume,0,1,2,3,4,5)"
 }
 
 function tone
@@ -267,9 +356,7 @@
     local name=$1
     local port=$2
 
-    if test $DEBUG -gt 0 ; then
-	echo "tone \"$name\" $port"
-    fi
+    log 0 "tone              \"$name\" $port"
 
 #
 # Tone
@@ -282,12 +369,14 @@
     local name=$1
     local port=$2
 
-    if test $DEBUG -gt 0 ; then
-	echo "multi_playback \"$name\" $port"
+    if [ "$name" != "" ]; then
+	name="$name "
     fi
 
+    log 0 "multi_playback    \"$name\" $port"
+
 # PCM Multi
-    runlo10k1 -n --ctrl "c-Left,Right:PCM Front Playback Volume,t-PCM Front Playback Volume:1,c-LeftSurr,RightSurr:Surround Playback Volume,t-Surround Playback Volume:1,c-Center:Center Playback Volume,t-Center Playback Volume:1,c-LFE:LFE Playback Volume,t-LFE Playback Volume:1" --patch_name "$name Multi Volume" -a simple.emu10k1
+    runlo10k1 -n --ctrl "c-Left,Right:${name}Front Playback Volume,t-${name}Front Playback Volume:1,c-LeftSurr,RightSurr:${name}Surround Playback Volume,t-${name}Surround Playback Volume:1,c-Center:${name}Center Playback Volume,t-${name}Center Playback Volume:1,c-LFE:${name}LFE Playback Volume,t-${name}LFE Playback Volume:1" --patch_name "$name Multi Volume" -a simple.emu10k1
 # Input
     connect "PIN($name Multi Volume)" '>' "$port"
 # Output
@@ -296,95 +385,169 @@
 
 function fxbus
 {
-    runlo10k1 --patch_name "FX Bus" -a fxbus.emu10k1
-    connect "PIN(FX Bus)" '=' "FX(FX_PCM_Left,FX_PCM_Right,FX_PCM_Surr_Left,FX_PCM_Surr_Right,FX_MIDI_Left,FX_MIDI_Right,FX_Center,FX_LFE,8,9)"
+    local name=$1
+    local enable_pcm_fx89=$2
+
+    log 0 "fxbus             \"$name\"" $enable_pcm_fx89
+
+    runlo10k1 --patch_name "$name" -a fxbus.emu10k1
+    connect "PIN($name)" '=' "FX(FX_PCM_Left,FX_PCM_Right,FX_PCM_Surr_Left,FX_PCM_Surr_Right,FX_MIDI_Left,FX_MIDI_Right,FX_Center,FX_LFE,8,9)"
+
 
-    fx_multi="POUT(FX Bus,0,1,2,3,6,7)"
-    fx_front="POUT(FX Bus,0,1)"
-    fx_rear="POUT(FX Bus,2,3)"
-    fx_midi="POUT(FX Bus,4,5)"
-    fx_pcm="POUT(FX Bus,8,9)"
+    if [ $enable_pcm_fx89 ]; then
+	local front="8,9"
+    else
+	local front="0,1"
+    fi
+
+    fx_pcm="POUT($name,0,1)"
+    fx_front="POUT($name,$front)"
+    fx_rear="POUT($name,2,3)"
+    fx_midi="POUT($name,4,5)"
+    fx_multi="POUT($name,$front,2,3,6,7)"
 }
 
 #dump_patches 16
 
+# Clear
 runlo10k1 -s 
 
+rename "FX(8)" "FX_PCM_Front_Left"
+rename "FX(9)" "FX_PCM_Front_Right"
+
 tone "Tone Control"
 
-fxbus
+fxbus "FX Bus" $FXIN_PCM_89
 
-#copy "FX89" "FX(8,9)"
-stereo_to_51 "Wave" "$fx_pcm"
+if [ "$DECODER" = "PROLOGIC" ]; then
+    prologic "Wave"
+    connect "POUT(Wave Multi Volume,0,1,2,3,4,5)" '>' "PIN(Tone Control,0,1,2,3,4,5)"
+    add_output_func=add_output_prologic_2
+elif [ "$DECODER" = "BOTH" ]; then
+    prologic "Wave"
+    simple_stereo_to_51 "Wave"
+    switch_5x2 "Wave Prologic" "POUT(Wave Prologic,0,1,2,3,4)" "POUT(Wave Simple Stereo To 51,0,1,2,3,4)" 0
+    add_output_func=add_output_switched_2
+else
+    simple_stereo_to_51 "Wave"
+#"$fx_pcm"
+    connect "POUT(Wave Simple Stereo To 51,0,1,2,3,4,5)" '>' "PIN(Tone Control,0,1,2,3,4,5)"
+    add_output_func=add_output_simple_2
+fi
 
 #
 # FXBUS
 #
-multi_playback "PCM" "$fx_multi"
 
-capture "PCM Front" "$fx_front"
-capture "Wave" "$fx_pcm"
-capture "Surround" "$fx_rear"
+$std_playback "Wave" "$fx_pcm"
+$std_capture "Wave" "$fx_pcm"
+
+multi_playback "PCM" "$fx_multi"
+$std_capture "PCM Front" "$fx_front"
+$std_capture "PCM Surround" "$fx_rear"
 
-playback "Music" "$fx_midi"
-capture "Music" "$fx_midi"
+$std_playback "Music" "$fx_midi"
+$std_capture "Music" "$fx_midi"
 
 
 #
 # INPUTS
 #
-playback "AC97" "IN(IN_AC97_Left,IN_AC97_Right)"
-capture_noswitch "AC97" "IN(IN_AC97_Left,IN_AC97_Right)"
 
-# playback "IEC958 TTL" "IN(IN_TTL_IEC958_Left,IN_TTL_IEC958_Right)"
-# capture "IEC958 TTL" "IN(IN_TTL_IEC958_Left,IN_TTL_IEC958_Right)"
+if [ "$EXTIN_AC97" = "1" ]; then
+    $std_playback "AC97" "IN(IN_AC97_Left,IN_AC97_Right)"
+    capture_noswitch "AC97" "IN(IN_AC97_Left,IN_AC97_Right)"
+fi
+
+if [ "$EXTIN_SPDIF_CD" = "1" ]; then
+    $std_playback "IEC958 TTL" "IN(IN_TTL_IEC958_Left,IN_TTL_IEC958_Right)"
+    $std_capture "IEC958 TTL" "IN(IN_TTL_IEC958_Left,IN_TTL_IEC958_Right)"
+fi
+
+if [ "$EXTIN_ZOOM" = "1" ]; then
+    $std_playback "Zoom Video" "IN(IN_Zoom_Video_Left,IN_Zoom_Video_Right)"
+    $std_capture "Zoom Video" "IN(IN_Zoom_Video_Left,IN_Zoom_Video_Right)"
+fi
+
+if [ "$EXTIN_TOSLINK" = "1" ]; then
+    $std_playback "IEC958 LiveDrive" "IN(IN_Optical_IEC958_Left,IN_Optical_IEC958_Right)"
+    $std_capture "IEC958 LiveDrive" "IN(IN_Optical_IEC958_Left,IN_Optical_IEC958_Right)"
+fi
+
+if [ "$EXTIN_LINE1" = "1" ]; then
+    $std_playback "Line LiveDrive" "IN(IN_Line_Mic_1_Left,IN_Line_Mic_1_Right)"
+    $std_capture "Line LiveDrive" "IN(IN_Line_Mic_1_Left,IN_Line_Mic_1_Right)"
+fi
+
+if [ "$EXTIN_COAX_SPDIF" = "1" ]; then
+    $std_playback "IEC958 Coaxial" "IN(IN_Coax_IEC958_Left,IN_Coax_IEC958_Right)"
+    $std_capture "IEC958 Coaxial" "IN(IN_Coax_IEC958_Left,IN_Coax_IEC958_Right)"
+fi
+
+if [ "$EXTIN_LINE2" = "1" ]; then
+    $std_playback "Line2 LiveDrive" "IN(IN_Line_Mic_2_Left,IN_Line_Mic_2_Right)"
+    $std_capture "Line2 LiveDrive" "IN(IN_Line_Mic_2_Left,IN_Line_Mic_2_Right)"
+fi
+
+master_name="Master Digital"
+master_volume="$master_name Playback Volume"
+master_switch="$master_name Playback Switch"
+
+master "$master_name" "POUT(Tone Control)" 0
+
+if [ "$EXTOUT_ANALOG_FRONT" = "1" ]; then
+    log 0 "out               Analog Front"
+    connect "POUT($master_switch,0,1)" '>' "OUT(OUT_AC97_Left,OUT_AC97_Right)"
+fi
+
+if [ "$EXTOUT_REAR" = "1" ]; then
+    log 0 "out               SB Live 5.1 (c) 2003 - Rear"
+    connect "POUT($master_switch,2,3)" '>' "OUT(13,14)"
+elif [ "$EXTOUT_ANALOG_REAR" = "1" ]; then
+    log 0 "out               Analog Rear"
+    connect "POUT($master_switch,2,3)" '>' "OUT(OUT_Analog_Surr_Left,OUT_Analog_Surr_Right)"
+fi
+
+if [ "$EXTOUT_CENTER" = "1" ]; then 
+    log 0 "out               Center"
+    connect "POUT($master_switch,4)" '>' "OUT(OUT_Center)"
+elif [ "$EXTOUT_ANALOG_CENTER" = "1" ]; then 
+    log 0 "out               Analog Center"
+    connect "POUT($master_switch,4)" '>' "OUT(OUT_AC97_Center)"
+fi
+
+if [ "$EXTOUT_LFE" = "1" ]; then
+    log 0 "out               LFE"
+    connect "POUT($master_switch,5)" '>' "OUT(OUT_LFE)"
+elif [ "$EXTOUT_ANALOG_LFE" = "1" ]; then
+    log 0 "out               Analog LFE"
+    connect "POUT($master_switch,5)" '>' "OUT(OUT_AC97_LFE)"
+fi
+
+# if [ $EXTOUT_MIC_CAP ]; then
+#     log 0 "out               MIC Capture buffer"
+#     connect "" '>' "OUT(OUT_MIC_Capture)"
+# fi
 
-# playback "Zoom Video" "IN(IN_Zoom_Video_Left,IN_Zoom_Video_Right)"
-# capture "Zoom Video" "IN(IN_Zoom_Video_Left,IN_Zoom_Video_Right)"
-
-# playback "IEC958 LiveDrive" "IN(IN_Optical_IEC958_Left,IN_Optical_IEC958_Right)"
-# capture "IEC958 LiveDrive" "IN(IN_Optical_IEC958_Left,IN_Optical_IEC958_Right)"
-
-# playback "Line LiveDrive" "IN(IN_Line_Mic_1_Left,IN_Line_Mic_1_Right)"
-# capture "Line LiveDrive" "IN(IN_Line_Mic_1_Left,IN_Line_Mic_1_Right)"
-
-# playback "IEC958 Coaxial" "IN(IN_Coax_IEC958_Left,IN_Coax_IEC958_Right)"
-# capture "IEC958 Coaxial" "IN(IN_Coax_IEC958_Left,IN_Coax_IEC958_Right)"
-
-# playback "Line2 LiveDrive" "IN(IN_Line_Mic_2_Left,IN_Line_Mic_2_Right)"
-# capture "Line2 LiveDrive" "IN(IN_Line_Mic_2_Left,IN_Line_Mic_2_Right)"
-
-
-master_volume="Master_2 Playback Volume"
-master_switch="Master_2 Playback Switch"
-
-master "Master_2" "POUT(Tone Control)"
-connect "POUT($master_switch)" '>' "OUT(OUT_AC97_Left,OUT_AC97_Right,OUT_Analog_Surr_Left,OUT_Analog_Surr_Right,OUT_AC97_Center,OUT_AC97_LFE)"
-
-exit
+if [ "$EXTOUT_HEADPHONE" = "1" ]; then
 # Headphone
+    log 0 "out               Headphone"
 
-# Headphone Switch
-runlo10k1 -n --ctrl "c-switchL:Headphone Center Playback Switch,c-switchR:Headphone LFE Playback Switch,t-Headphone Center Playback Switch:4,t-Headphone LFE Playback Switch:4,i-Headphone Center Playback Switch:1,i-Headphone LFE P\
-layback Switch:1" --patch_name "Headphone Center Playback Switch" -a switch_2.emu10k1
+    runlo10k1 -n --ctrl "c-switchL:Headphone Center Playback Switch,c-switchR:Headphone LFE Playback Switch,t-Headphone Center Playback Switch:4,t-Headphone LFE Playback Switch:4,i-Headphone Center Playback Switch:1,i-Headphone LFE Playback Switch:1" --patch_name "Headphone Playback Switch" -a switch_2x2.emu10k1
 #Input
-#connect "POUT(Headphone Playback Volume)" '' "PIN(Headphone Center Playback Switch)"
-#Output
-#connect "POUT(Headphone Center Playback Switch,0,1)" '' "OUT(OUT_Headphone_Left,OUT_Headphone_Right)"
+    connect "PIN(Headphone Playback Switch,0,1)" '>' "POUT(Tone Control,0,1)"
+    connect "PIN(Headphone Playback Switch,2,3)" '>' "POUT(Tone Control,4,5)"
 
-# Headphone Volume
-runlo10k1 -n --ctrl "c-Left,Right:Headphone Playback Volume,t-Headphone Playback Volume#1:1,i-Headphone Playback Volume:1" --patch_name "Headphone Playback Volume" -a vol_2.emu10k1
-#Input
-#runlo10k1 --conadd "PIN(Headphone Playback Volume,0,1)>PIN(Wave Stereo To 51,0,1)"
-#connect "POUT(Headphone Playback Volume,0,1)" '>' "PIN(Wave Stereo To 51,0,1)"
-#connect "POUT(Tone Control,0,1)" '=' "PIN(Headphone Playback Volume,0,1)"
-#connect "POUT(Headphone Playback SwitchTone Control,0,1)" '=' "PIN(Headphone Playback Volume,0,1)"
+    volume "Headphone Playback" "POUT(Headphone Playback Switch,0,1)" 100#100 1
 
 #Output
-runlo10k1 -n --ctrl "c-enableL,enableR:IEC958 Optical Raw Playback Switch,t-IEC958 Optical Raw Playback Switch:4" --patch_name "Output" -a output.emu10k1
-#Inputs
-runlo10k1 --conadd "POUT(Master Switch)=PIN(Output,0,1,2,3,4,5)"
-#runlo10k1 --conadd "PIN(Output,6,7)=FX(20,21)"
-#Output
-runlo10k1 --conadd "POUT(Output,0,1,2,3,4,5)=OUT(0,1,8,9,17,18)"
-runlo10k1 --conadd "POUT(Output,6,7,8,9,10,11)=OUT(0,1,2,3,4,5)"
+    connect "POUT(Headphone Playback Volume)" '>' "OUT(OUT_Headphone_Left,OUT_Headphone_Right)"
+fi
+
+if [ "$EXTOUT_IEC958" = "1" ]; then
+    log 0 "out               IEC958 Optical Raw"
+
+    switch_2x2 "IEC958 Optical Raw Playback" "POUT(Tone Control,0,1)" "POUT(IEC958)"  1#1
+    connect "POUT(IEC958 Optical Raw Playback Switch,0,1)" '>' "OUT(OUT_Opt_IEC958_Left,OUT_Opt_IEC958_Right)"
+#    connect "POUT(IEC958 Optical Raw Playback Switch,0,1)" '>' "OUT(OUT_AC97_Left,OUT_AC97_Right)"
+fi

--OgqxwSJOaUobr8KG--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
