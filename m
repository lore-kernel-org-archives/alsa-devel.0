From: focus.luo@linux.intel.com
Subject: [PATCH v2 1/2] alsabat: automation test scripts
Date: Mon, 15 Aug 2016 13:24:04 +0800
Message-ID: <1471238645-12554-2-git-send-email-focus.luo@linux.intel.com>
References: <1471238645-12554-1-git-send-email-focus.luo@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 288652659A9
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 06:56:29 +0200 (CEST)
In-Reply-To: <1471238645-12554-1-git-send-email-focus.luo@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Focus Luo <focus.luo@linux.intel.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Focus Luo <focus.luo@linux.intel.com>

This patch includes automated test scripts for linux audio driver
based on alsa-lib interface by using alsabat as test tool.
It supports analog and display(HDMI/DP) audio test.
The package needs the alsa-utils, alsa-lib installed environment.

Signed-off-by: Focus Luo <focus.luo@linux.intel.com>
---
 bat/Makefile.am                                |   1 +
 bat/tests/Makefile.am                          |  10 ++
 bat/tests/README                               |  32 +++++
 bat/tests/alsabat_main.sh                      | 178 +++++++++++++++++++++++++
 bat/tests/analog_audio_playback_and_capture.sh |  84 ++++++++++++
 bat/tests/dp_audio_playback.sh                 |  83 ++++++++++++
 bat/tests/dp_audio_subdevice_number.sh         |  68 ++++++++++
 bat/tests/hdmi_audio_playback.sh               |  81 +++++++++++
 bat/tests/hdmi_audio_subdevice_number.sh       |  65 +++++++++
 bat/tests/map_test_case                        |   8 ++
 configure.ac                                   |   3 +-
 11 files changed, 612 insertions(+), 1 deletion(-)
 create mode 100644 bat/tests/Makefile.am
 create mode 100644 bat/tests/README
 create mode 100755 bat/tests/alsabat_main.sh
 create mode 100755 bat/tests/analog_audio_playback_and_capture.sh
 create mode 100755 bat/tests/dp_audio_playback.sh
 create mode 100755 bat/tests/dp_audio_subdevice_number.sh
 create mode 100755 bat/tests/hdmi_audio_playback.sh
 create mode 100755 bat/tests/hdmi_audio_subdevice_number.sh
 create mode 100644 bat/tests/map_test_case

diff --git a/bat/Makefile.am b/bat/Makefile.am
index 6883826..5151f77 100644
--- a/bat/Makefile.am
+++ b/bat/Makefile.am
@@ -1,3 +1,4 @@
+SUBDIRS=tests
 bin_PROGRAMS = alsabat
 man_MANS = alsabat.1
 EXTRA_DIST = alsabat.1 alsabat-test.sh
diff --git a/bat/tests/Makefile.am b/bat/tests/Makefile.am
new file mode 100644
index 0000000..5182976
--- /dev/null
+++ b/bat/tests/Makefile.am
@@ -0,0 +1,10 @@
+alsabat_script_files = analog_audio_playback_and_capture.sh \
+	dp_audio_playback.sh \
+	dp_audio_subdevice_number.sh \
+	hdmi_audio_playback.sh \
+	hdmi_audio_subdevice_number.sh \
+	map_test_case \
+	README
+
+EXTRA_DIST = \
+	$(alsabat_script_files)
diff --git a/bat/tests/README b/bat/tests/README
new file mode 100644
index 0000000..de69686
--- /dev/null
+++ b/bat/tests/README
@@ -0,0 +1,32 @@
+
+	automated test scripts for linux audio driver
+	based on alsa-lib interface by using alsabat
+===============================================================================
+
+This package contains the test scripts for linux audio driver based on
+alsa-lib interface by using alsabat.
+It supports analog and display(HDMI/DP) audio test.
+The package needs  the alsa-utils, alsa-lib installed environment.
+
+alsabat_main.sh
+	- the main entrance test script,
+	it will call the other scripts to run the tests
+	(test result will save in the ./log/ folder)
+analog_audio_playback_and_capture.sh
+	- analog audio test script (please to loopback the
+	analog audio output to analog audio input)
+hdmi_audio_playback.sh
+	- hdmi audio test script (please to loopback the hdmi audio output
+	to analog audio input)
+dp_audio_playback.sh
+	- dp audio test script (please to loopback the dp audio
+	output to analog audio input)
+map_test_case
+	- to map the test suite/cases to a test script
+asound_state/
+	- some asound.state config reference files
+	based on different platforms
+
+				Focus Luo <focus.luo@linux.intel.com>
+				Wang,Jinliang <jinliang.wang@intel.com>
+				Zhang,Keqiao <keqiao.zhang@intel.com>
diff --git a/bat/tests/alsabat_main.sh b/bat/tests/alsabat_main.sh
new file mode 100755
index 0000000..478ac98
--- /dev/null
+++ b/bat/tests/alsabat_main.sh
@@ -0,0 +1,178 @@
+#!/bin/bash
+
+#/*
+# * Copyright (C) 2013-2016 Intel Corporation
+# *
+# * This program is free software; you can redistribute it and/or modify
+# * it under the terms of the GNU General Public License as published by
+# * the Free Software Foundation; either version 2 of the License, or
+# * (at your option) any later version.
+# *
+# * This program is distributed in the hope that it will be useful,
+# * but WITHOUT ANY WARRANTY; without even the implied warranty of
+# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# * GNU General Public License for more details.
+# *
+# */
+#set -x
+
+#alsabat test scripts path
+export ABAT_TEST_PATH=`pwd`
+
+#alsabat test log file, path+filename
+Day=`date +"%Y-%m-%d-%H-%M"`
+Log_FileName="test_result-"${Day}".log"
+export ABAT_TEST_LOG_FILE=${ABAT_TEST_PATH}/log/${Log_FileName}
+
+#terminal display colour setting
+ESC_GREEN="\033[32m"
+ESC_RED="\033[31m"
+ESC_YELLOW="\033[33;1m"
+ESC_OFF="\033[0m"
+
+#total/pass/fail test cases number
+total_case_number=0
+suit_number=1
+pass_number=0
+fail_number=0
+# =========================== Public function  ==========================
+
+function get_platform_info()
+{
+	#to get the audio card number
+	Card_Number=$(aplay -l | grep "HDMI 0" | cut -b 6)
+	cd /proc/asound/card$Card_Number/
+	for file in `ls`
+	do
+		if [[ $file == codec* ]]; then
+			#to get the hardware platform ID, currently Intel skylake,
+			#broadwell and haswell hardware platforms are supported
+			Platform_ID=`cat $file |grep "Codec:" |cut -d " " -f 3`
+			if [ "$Platform_ID" == "Skylake" ] \
+				|| [ "$Platform_ID" == "Broadwell" ] \
+				|| [ "$Platform_ID" == "Haswell" ]; then
+				echo $Platform_ID
+				break
+				exit 0
+			fi
+		else
+			printf '\033[1;31m %-30s %s \033[1;31m%s\n\033[0m' \
+						"Get platform information failed";
+			exit 1
+		fi
+	done
+}
+
+#printf the "pass" info in the file
+show_pass()
+{
+	echo -e "$suit_number - [$1]:test ------- PASS" >> $ABAT_TEST_LOG_FILE
+	printf '\033[1;33m %-30s %s \033[1;32m%s\n\033[0m' \
+"$suit_number -	[$1]" "--------------------------------  " "PASS";
+}
+
+#printf the "fail" info in the file
+show_fail()
+{
+	echo -e "$suit_number - [$1]:test ------- FAIL" >> $ABAT_TEST_LOG_FILE
+	printf '\033[1;33m %-30s %s \033[1;31m%s\n\033[0m' \
+"$suit_number - [$1]" "--------------------------------  " "FAIL";
+}
+
+
+function run_test()
+{
+	for TestItem in $@
+		do
+			Date=`date`
+			Dot="$Dot".
+			echo "Now doing $TestItem test$Dot"
+
+			#map test case to test script
+			eval item='$'$TestItem
+
+			#to check the test script existing
+			if  [ ! -f "$item" ]; then
+				echo -e "\e[31m not found $TestItem script,confirm it firstly"
+				echo -e "\e[0m"
+				exit 1
+			fi
+
+			#to run each test script
+			eval "\$$TestItem"
+			Result=$?
+			#record the test result to the log file
+			if [ $Result -eq 0 ]; then
+				show_pass "$TestItem"
+			else
+				show_fail "$TestItem"
+			fi
+			suit_number=$(($suit_number + 1))
+
+		done
+}
+
+function test_suites ( )
+{
+	#define the test suites/cases need to be run
+	TestProgram="verify_Analog_audio_playback_and_capture \
+				verify_HDMI_audio_playback verify_DP_audio_playback"
+
+	#run each test suites/test cases
+	run_test "$TestProgram"
+
+	# to printf the detailed test results on the screen
+	cat $ABAT_TEST_LOG_FILE |grep FAIL
+	case_number=$(($case_number - 1))
+	total_case_number=`cat $ABAT_TEST_LOG_FILE |grep -c "Test target frequency:"`
+	pass_number=`cat $ABAT_TEST_LOG_FILE |grep -c "Passed"`
+	fail_number=`cat $ABAT_TEST_LOG_FILE |grep -c "Failed"`
+	echo -e "\e[0m"
+	echo -e "\e[1;33m *---------------------------------------------------*\n"
+	echo -e " * "Total" ${total_case_number} "cases", \
+"PASS:" ${pass_number} "cases", "FAIL:" ${fail_number} "cases", \
+"Passrate is:" $((pass_number*100/total_case_number)) "%" *\n"
+	echo -e " *-------------------------------------------------------*\e[0m\n"
+
+	#the the result also will be saved on the log file
+	echo "Total" ${total_case_number} "cases", \
+"PASS:" ${pass_number} "cases", "FAIL:" ${fail_number} "cases",  \
+"Passrate:" $((pass_number*100/total_case_number)) "%" >> ${ABAT_TEST_LOG_FILE}
+
+	#return 0, if the script finishs normally
+	exit 0
+}
+
+function main ( )
+{
+	echo "Test results are as follows:" > ${ABAT_TEST_LOG_FILE}
+	get_platform_info # get hardware platform information
+	cd $ABAT_TEST_PATH
+
+	# make sure the log folder is exist
+	if [ ! -d "$ABAT_TEST_PATH/log/" ]; then
+		mkdir "log"
+	fi
+
+	#map the test cases to test scripts
+	source map_test_case
+
+	#setting the alsa configure environment
+	alsactl restore -f $ABAT_TEST_PATH/asound_state/asound.state.$Platform_ID
+
+	#Printf the user interface info
+	clear
+	echo -e "\e[1;33m"
+	date
+	echo -e "\e[0m"
+	echo -e "\e[1;33m *-------------------------------------------------*\n"
+	echo -e " *--Running the audio automated test on $Platform_ID-------*\n"
+	echo -e " *------------------------------------------------------*\e[0m\n"
+	read -p "Press enter to continue"
+
+	#run the test suites/test cases
+	test_suites
+}
+
+#the main entrance function
+main
diff --git a/bat/tests/analog_audio_playback_and_capture.sh b/bat/tests/analog_audio_playback_and_capture.sh
new file mode 100755
index 0000000..bac491e
--- /dev/null
+++ b/bat/tests/analog_audio_playback_and_capture.sh
@@ -0,0 +1,84 @@
+#!/bin/bash
+
+#/*
+# * Copyright (C) 2013-2016 Intel Corporation
+# *
+# * This program is free software; you can redistribute it and/or modify
+# * it under the terms of the GNU General Public License as published by
+# * the Free Software Foundation; either version 2 of the License, or
+# * (at your option) any later version.
+# *
+# * This program is distributed in the hope that it will be useful,
+# * but WITHOUT ANY WARRANTY; without even the implied warranty of
+# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# * GNU General Public License for more details.
+# *
+# */
+
+#set test freq table (HZ)
+freq_table="10 31 73 155 380 977 1932 4119 8197 16197"
+
+#set test number of channels
+test_channel=2
+
+#get Analog audio card number
+card_number=$(aplay -l | grep "Analog" | cut -b 6)
+if [ "$card_number" = "" ]; then
+        echo "Can not get Analog card number."
+        exit 1
+fi
+
+#get Analog audio device number
+device_number=$(aplay -l | grep "Analog"| cut -d " " -f 8 |cut -b 1)
+if [ "$device_number" = "" ]; then
+        echo "Can not get Analog device number"
+        exit 1
+fi
+
+
+device="hw:$card_number,$device_number"
+echo $device
+
+#get Analog audio record card number
+record_card_number=$(arecord -l | grep "Analog" | cut -b 6)
+if [ "$record_card_number" = "" ]; then
+        echo "Can not get record card number."
+        exit 1
+fi
+
+#get Analog audio record device number
+record_device_number=$(arecord -l | grep "Analog"| cut -d " " -f 8 |cut -b 1)
+echo $record_device_number
+if [ "$record_device_number" = "" ]; then
+        echo "Can not get record device number"
+        exit 1
+fi
+
+#Notice: to loopback the analog audio output to the analog audio input
+record_device="hw:$record_card_number,$record_device_number"
+test_flag=0
+
+echo  -e "\e[31m Notice: to loopback the analog audio output to \
+the analog audio input"
+echo -e "\e[0m"
+read -p "Press enter to continue"
+
+#call alsabat to do the test for each frequency in the freq_table
+for freq in $freq_table
+	do
+	alsabat -P $device -C plug$record_device -c $test_channel -F $freq
+		if [ $? = 0 ]; then
+			echo "Test target frequency:$freq for Analog playback -- Passed \
+" >> $ABAT_TEST_LOG_FILE
+			echo "Test target frequency:$freq for Analog capture -- Passed \
+" >> $ABAT_TEST_LOG_FILE
+		else
+			echo "Test target frequency:$freq for Analog playback -- Failed \
+" >> $ABAT_TEST_LOG_FILE
+			echo "Test target frequency:$freq for Analog capture -- Failed \
+" >> $ABAT_TEST_LOG_FILE
+			test_flag=1
+		fi
+	done
+
+exit $test_flag
diff --git a/bat/tests/dp_audio_playback.sh b/bat/tests/dp_audio_playback.sh
new file mode 100755
index 0000000..9c7ee7e
--- /dev/null
+++ b/bat/tests/dp_audio_playback.sh
@@ -0,0 +1,83 @@
+#!/bin/bash
+
+#/*
+# * Copyright (C) 2013-2016 Intel Corporation
+# *
+# * This program is free software; you can redistribute it and/or modify
+# * it under the terms of the GNU General Public License as published by
+# * the Free Software Foundation; either version 2 of the License, or
+# * (at your option) any later version.
+# *
+# * This program is distributed in the hope that it will be useful,
+# * but WITHOUT ANY WARRANTY; without even the implied warranty of
+# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# * GNU General Public License for more details.
+# *
+# */
+
+#set test freq table (HZ)
+freq_table="10 31 73 155 380 977 1932 4119 8197 16197"
+
+#set test number of channels
+test_channel=2
+
+#get device number for DP
+DP_device_num=0
+$ABAT_TEST_PATH/dp_audio_subdevice_number.sh
+DP_device_num=$?
+if [ $DP_device_num = 77 ]; then
+	echo "Prompt: Can not get device with DP audio or \
+show the wrong connection type as HDMI in ELD info"
+	exit 1
+fi
+
+#To get DP audio device number
+DP_card_number=$(aplay -l | grep "HDMI 0" | cut -b 6)
+if [ "$DP_card_number" = "" ]; then
+	echo "Error: Can not get Display audio card."
+	exit 1
+fi
+
+DP_device="hw:$DP_card_number,$DP_device_num"
+echo $device
+sleep 2
+
+#get Analog audio record card number
+record_card_number=$(arecord -l | grep "Analog" | cut -b 6)
+if [ "$record_card_number" = "" ]; then
+	echo "Can not get record card number."
+	exit 1
+fi
+
+#get Analog audio record device number
+record_device_number=$(arecord -l | grep "Analog"| cut -d " " -f 8 |cut -b 1)
+echo $record_device_number
+if [ "$record_device_number" = "" ]; then
+        echo "Can not get record device number"
+        exit 1
+fi
+
+#Notice: to loopback the DP audio output to the analog audio input
+record_device="hw:$record_card_number,$record_device_number"
+test_flag=0
+
+echo -e "\e[31m Notice: to loopback the DP audio \
+output to the analog audio input"
+echo -e "\e[0m"
+read -p "Press enter to continue"
+
+#call alsabat to do the test for each frequency in the freq_table
+for freq in $freq_table
+	do
+		alsabat -P $DP_device -C plug$record_device -c $test_channel -F $freq
+		if [ $? = 0 ]; then
+			echo "Test target frequency:$freq for DP audio playback--Passed" \
+>> $ABAT_TEST_LOG_FILE
+		else
+			echo "Test target frequency:$freq for DP audio playback--Failed" \
+>> $ABAT_TEST_LOG_FILE
+			test_flag=1
+		fi
+	done
+
+exit $test_flag
diff --git a/bat/tests/dp_audio_subdevice_number.sh b/bat/tests/dp_audio_subdevice_number.sh
new file mode 100755
index 0000000..db2e79e
--- /dev/null
+++ b/bat/tests/dp_audio_subdevice_number.sh
@@ -0,0 +1,68 @@
+#!/bin/bash
+
+#/*
+# * Copyright (C) 2013-2016 Intel Corporation
+# *
+# * This program is free software; you can redistribute it and/or modify
+# * it under the terms of the GNU General Public License as published by
+# * the Free Software Foundation; either version 2 of the License, or
+# * (at your option) any later version.
+# *
+# * This program is distributed in the hope that it will be useful,
+# * but WITHOUT ANY WARRANTY; without even the implied warranty of
+# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# * GNU General Public License for more details.
+# *
+# */
+#set -x
+
+subdevice_number=0
+get_subdevice=0
+
+#make sure the DP monitor is connected and active
+
+# To get DisplayPort audio device number
+card_number=$(aplay -l | grep "HDMI 1" | cut -b 6)
+echo $card_number
+if [ "$card_number" = "" ]; then
+	echo "Can not get Display audio card."
+	exit 254
+fi
+
+audio_card_dir="/proc/asound/card$card_number/"
+
+cd $audio_card_dir
+
+for file in `ls`
+do
+	#To get the ELD info according to the connented monitor with DisplayPort.
+	if [[ $file == eld* ]]; then
+		let subdevice_number+=1
+		cat $file | grep connection_type | grep DisplayPort > /dev/null
+		if [ $? = 0 ]; then
+			echo "Get the ELD information according to the connented \
+monitor with DisplayPort."
+			get_subdevice=1
+			break
+		fi
+	fi
+done
+
+#failed to get the subdevice number of DisplayPort audio
+if [ $get_subdevice == 0 ]; then
+        exit 77
+fi
+
+#the subdevice number of DisplayPort audio is 3
+if [ $subdevice_number == 1 ]; then
+	exit 3
+#the subdevice number of DisplayPort audio is 7.
+elif [ $subdevice_number == 2 ]; then
+	exit 7
+#the subdevice number of DisplayPort audio is 8
+elif [ $subdevice_number == 3 ]; then
+	exit 8
+#default: failed to get the subdevice number of DisplayPort audio
+else
+	exit 77
+fi
diff --git a/bat/tests/hdmi_audio_playback.sh b/bat/tests/hdmi_audio_playback.sh
new file mode 100755
index 0000000..3c45d91
--- /dev/null
+++ b/bat/tests/hdmi_audio_playback.sh
@@ -0,0 +1,81 @@
+#!/bin/bash
+
+#/*
+# * Copyright (C) 2013-2016 Intel Corporation
+# *
+# * This program is free software; you can redistribute it and/or modify
+# * it under the terms of the GNU General Public License as published by
+# * the Free Software Foundation; either version 2 of the License, or
+# * (at your option) any later version.
+# *
+# * This program is distributed in the hope that it will be useful,
+# * but WITHOUT ANY WARRANTY; without even the implied warranty of
+# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# * GNU General Public License for more details.
+# *
+# */
+
+#set test freq table (HZ)
+freq_table="10 31 73 155 380 977 1932 4119 8197 16197"
+
+#set test number of channels
+test_channel=2
+
+#get device number for HDMI
+HDMI_device_num=0
+$ABAT_TEST_PATH/hdmi_audio_subdevice_number.sh
+HDMI_device_num=$?
+if [ $HDMI_device_num = 77 ]; then
+	echo "Prompt: Can not get device with HDMI audio or \
+show the wrong connection type as DP in ELD info"
+	exit 1
+fi
+
+#To get HDMI audio device number
+HDMI_card_number=$(aplay -l | grep "HDMI 0" | cut -b 6)
+if [ "$HDMI_card_number" = "" ]; then
+        echo "Error: Can not get Display audio card."
+        exit 1
+fi
+
+HDMI_device="hw:$HDMI_card_number,$HDMI_device_num"
+echo $device
+sleep 2
+
+#get Analog audio record card number
+record_card_number=$(arecord -l | grep "Analog" | cut -b 6)
+if [ "$record_card_number" = "" ]; then
+        echo "Can not get record card number."
+        exit 1
+fi
+
+#get Analog audio record device number
+record_device_number=$(arecord -l | grep "Analog"| cut -d " " -f 8 |cut -b 1)
+if [ "$record_device_number" = "" ]; then
+        echo "Can not get record device number"
+        exit 1
+fi
+
+#Notice: to loopback the HDMI audio output to the analog audio input
+record_device="hw:$record_card_number,$record_device_number"
+test_flag=0
+
+echo -e "\e[31m Notice: to loopback the HDMI audio output \
+to the analog audio input"
+echo -e "\e[0m"
+read -p "Press enter to continue"
+#call alsabat to do the test for each frequency in the freq_table
+for freq in $freq_table
+	do
+		alsabat -P $HDMI_device -C plug$record_device -c $test_channel -F $freq
+		if [ $? = 0 ]; then
+			echo "Test target frequency:$freq for HDMI audio playback \
+-- Passed    " >> $ABAT_TEST_LOG_FILE
+		else
+			echo "Test target frequency:$freq for HDMI audio playback \
+-- Failed    " >> $ABAT_TEST_LOG_FILE
+			test_flag=1
+		fi
+	done
+
+exit $test_flag
diff --git a/bat/tests/hdmi_audio_subdevice_number.sh b/bat/tests/hdmi_audio_subdevice_number.sh
new file mode 100755
index 0000000..7811577
--- /dev/null
+++ b/bat/tests/hdmi_audio_subdevice_number.sh
@@ -0,0 +1,65 @@
+#!/bin/bash
+
+#/*
+# * Copyright (C) 2013-2016 Intel Corporation
+# *
+# * This program is free software; you can redistribute it and/or modify
+# * it under the terms of the GNU General Public License as published by
+# * the Free Software Foundation; either version 2 of the License, or
+# * (at your option) any later version.
+# *
+# * This program is distributed in the hope that it will be useful,
+# * but WITHOUT ANY WARRANTY; without even the implied warranty of
+# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# * GNU General Public License for more details.
+# *
+# */
+#set -x
+
+subdevice_number=0
+get_subdevice=0
+
+#make sure the HDMI monitor is connected and active ########
+
+# To get HDMI audio device number
+card_number=$(aplay -l | grep "HDMI 0" | cut -b 6)
+if [ "$card_number" = "" ]; then
+	echo "Can not get Display audio card."
+	#failed to get Display audio card.
+	exit 1
+fi
+
+audio_card_dir="/proc/asound/card$card_number/"
+
+cd $audio_card_dir
+for file in `ls`
+	do
+		#To get the ELD information according to the connented monitor with HDMI
+		if [[ $file == eld* ]]; then
+			let subdevice_number+=1
+			cat $file | grep connection_type | grep HDMI > /dev/null
+			if [ $? = 0 ]; then
+				get_subdevice=1
+				break
+			fi
+		fi
+	done
+
+#failed to get the subdevice number of HDMI audio.
+if [ $get_subdevice == 0 ]; then
+	exit 77
+fi
+
+#the subdevice number of HDMI audio is 3.
+if [ $subdevice_number == 1 ]; then
+	exit 3
+#the subdevice number of HDMI audio is 7.
+elif [ $subdevice_number == 2 ]; then
+	exit 7
+#the subdevice number of HDMI audio is 8.
+elif [ $subdevice_number == 3 ]; then
+	exit 8
+#default: failed to get the subdevice number of HDMI audio.
+else
+	exit 77
+fi
diff --git a/bat/tests/map_test_case b/bat/tests/map_test_case
new file mode 100644
index 0000000..20eb223
--- /dev/null
+++ b/bat/tests/map_test_case
@@ -0,0 +1,8 @@
+# Analog audio basic test
+verify_Analog_audio_playback_and_capture="$ABAT_TEST_PATH/analog_audio_playback_and_capture.sh"
+
+# Display audio basic test cases - for HDMI
+verify_HDMI_audio_playback="$ABAT_TEST_PATH/hdmi_audio_playback.sh"
+
+# Display audio basic test cases - for DP
+verify_DP_audio_playback="$ABAT_TEST_PATH/dp_audio_playback.sh"
diff --git a/configure.ac b/configure.ac
index 750911a..0520515 100644
--- a/configure.ac
+++ b/configure.ac
@@ -411,7 +411,8 @@ AC_OUTPUT(Makefile alsactl/Makefile alsactl/init/Makefile \
 	  m4/Makefile po/Makefile.in \
 	  alsaconf/alsaconf alsaconf/Makefile \
 	  alsaconf/po/Makefile \
-	  alsaucm/Makefile topology/Makefile bat/Makefile \
+	  alsaucm/Makefile topology/Makefile \
+	  bat/Makefile bat/tests/Makefile \
 	  aplay/Makefile include/Makefile iecset/Makefile utils/Makefile \
 	  utils/alsa-utils.spec seq/Makefile seq/aconnect/Makefile \
 	  seq/aplaymidi/Makefile seq/aseqdump/Makefile seq/aseqnet/Makefile \
-- 
1.9.1
