From: Mike Frysinger <vapier@gentoo.org>
Subject: [patch] add support for symbol prefixes in shared
	libraries
Date: Fri, 12 Jan 2007 14:05:33 -0500
Message-ID: <200701121405.38926.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Cw9pFExyUI0ud/7"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_Cw9pFExyUI0ud/7
Content-Type: multipart/signed; boundary="nextPart1275144.scXQbk1cun";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1275144.scXQbk1cun
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

attached patch updates the Version script so that it supports SYMBOL_PREFIX
-mike

--nextPart1275144.scXQbk1cun
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iQIVAwUARafcAkFjO5/oN/WBAQJxwhAArDIOdwm7aL+VsiG1RhnbJQ26yKlRXhL+
rJZBaCrF1VQ2EfPu6z9s0G1Jsne+6p58BVDEvdCW62kCoMCp98VDJKkB04/xfeKG
7jHHIqWdzDoa3K11veOfC8RN1YzNptV07CUSWIrthz6LLFKyjKuiifKpcu9xDO83
wZyawRSZW0EU+qWSJTTPLYCLEARs0pRnnoFaRX3PIjeIuIeAub9PnUhn9l5TSoJ9
7B5J5t1KFQqpK0fP76tUOTB0OjxcYF9NzzGbeTZRyDf51lOJiHb983hlDNh8pSTG
gdHK114iSYAdksi7trc4nUuHAW7xEL16WsMfxyXnMV1KyL4BM8r4d6qzQUcbMZ6E
1sL5C1kbNy0Hv/2kiXRXuwQTrh/eIKZjy3c3bkKbICTo18/UfQ2ict+aX6G+GJuP
TBQBa58RZA1H+Lim7lqOFV+g9WQZsUpzxXL3pVII3UjQJD3wNT5DihdHb0gKYSAN
DH9jpJKnfhKWwb0o2wN2xYaAMWOjlUxWyKbD8UiUmRZY6C/yb0CCm6vQAkLpLtgj
k62XT6LhffQDhgaTcj1rWYyub6SDW2KbYAS1bbwpkSnyreoe/RTnAFF4v6STnyv4
SlpgaBqsuzmJq+u3ZirJLGfInWQK6aT1QxE9oQO8jhLXliyrigKXg54ieSMPX3qj
KpGXTJ2Sfi8=
=p+qf
-----END PGP SIGNATURE-----

--nextPart1275144.scXQbk1cun--

--Boundary-00=_Cw9pFExyUI0ud/7
Content-Type: text/x-diff; charset="us-ascii";
	name="alsa-lib-symbol-prefix-version-script.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="alsa-lib-symbol-prefix-version-script.patch"

diff -r 4b305d56a1f0 configure.in
--- a/configure.in	Mon Jan 08 16:39:26 2007 +0100
+++ b/configure.in	Fri Jan 12 13:27:35 2007 -0500
@@ -114,6 +114,7 @@ SYMBOL_PREFIX=` \
 		| ${EGREP-grep} "^PREFIX=" \
 		| ${SED-sed} "s:^PREFIX=::"`
 AC_DEFINE_UNQUOTED([__SYMBOL_PREFIX], "$SYMBOL_PREFIX", [Toolchain Symbol Prefix])
+AC_SUBST(SYMBOL_PREFIX)
 AC_MSG_RESULT($SYMBOL_PREFIX)
 
 dnl Check for debug...
@@ -384,7 +385,7 @@ fi
 fi
 
 AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile include/Makefile
-	  include/sound/Makefile src/Makefile \
+	  include/sound/Makefile src/Versions src/Makefile \
           src/control/Makefile src/mixer/Makefile \
 	  src/pcm/Makefile src/pcm/scopes/Makefile \
 	  src/rawmidi/Makefile src/timer/Makefile \
diff -r 4b305d56a1f0 src/Makefile.am
--- a/src/Makefile.am	Mon Jan 08 16:39:26 2007 +0100
+++ b/src/Makefile.am	Fri Jan 12 13:32:11 2007 -0500
@@ -2,7 +2,7 @@ COMPATNUM=@LIBTOOL_VERSION_INFO@
 COMPATNUM=@LIBTOOL_VERSION_INFO@
 
 if VERSIONED_SYMBOLS
-VSYMS = -Wl,--version-script=$(srcdir)/Versions
+VSYMS = -Wl,--version-script=Versions
 else
 VSYMS =
 endif
diff -r 4b305d56a1f0 src/Versions
--- a/src/Versions	Mon Jan 08 16:39:26 2007 +0100
+++ /dev/null	Thu Jan 01 00:00:00 1970 +0000
@@ -1,298 +0,0 @@
-ALSA_0.9 {
-  global:
-    __snd_*;
-    _snd_*;
-    snd_*;
-  local:
-    *;
-};
-
-ALSA_0.9.0rc4 {
-  global:
-
-    snd_pcm_hw_params_get_access;
-    snd_pcm_hw_params_set_access_first;
-    snd_pcm_hw_params_set_access_last;
-
-    snd_pcm_hw_params_get_format;
-    snd_pcm_hw_params_set_format_first;
-    snd_pcm_hw_params_set_format_last;
-
-    snd_pcm_hw_params_get_subformat;
-    snd_pcm_hw_params_set_subformat_first;
-    snd_pcm_hw_params_set_subformat_last;
-
-    snd_pcm_hw_params_get_channels;
-    snd_pcm_hw_params_get_channels_min;
-    snd_pcm_hw_params_get_channels_max;
-    snd_pcm_hw_params_set_channels_near;
-    snd_pcm_hw_params_set_channels_first;
-    snd_pcm_hw_params_set_channels_last;
-
-    snd_pcm_hw_params_get_rate;
-    snd_pcm_hw_params_get_rate_min;
-    snd_pcm_hw_params_get_rate_max;
-    snd_pcm_hw_params_set_rate_near;
-    snd_pcm_hw_params_set_rate_first;
-    snd_pcm_hw_params_set_rate_last;
-
-    snd_pcm_hw_params_get_period_time;
-    snd_pcm_hw_params_get_period_time_min;
-    snd_pcm_hw_params_get_period_time_max;
-    snd_pcm_hw_params_set_period_time_near;
-    snd_pcm_hw_params_set_period_time_first;
-    snd_pcm_hw_params_set_period_time_last;
-
-    snd_pcm_hw_params_get_period_size;
-    snd_pcm_hw_params_get_period_size_min;
-    snd_pcm_hw_params_get_period_size_max;
-    snd_pcm_hw_params_set_period_size_near;
-    snd_pcm_hw_params_set_period_size_first;
-    snd_pcm_hw_params_set_period_size_last;
-
-    snd_pcm_hw_params_get_periods;
-    snd_pcm_hw_params_get_periods_min;
-    snd_pcm_hw_params_get_periods_max;
-    snd_pcm_hw_params_set_periods_near;
-    snd_pcm_hw_params_set_periods_first;
-    snd_pcm_hw_params_set_periods_last;
-
-    snd_pcm_hw_params_get_buffer_time;
-    snd_pcm_hw_params_get_buffer_time_min;
-    snd_pcm_hw_params_get_buffer_time_max;
-    snd_pcm_hw_params_set_buffer_time_near;
-    snd_pcm_hw_params_set_buffer_time_first;
-    snd_pcm_hw_params_set_buffer_time_last;
-
-    snd_pcm_hw_params_get_buffer_size;
-    snd_pcm_hw_params_get_buffer_size_min;
-    snd_pcm_hw_params_get_buffer_size_max;
-    snd_pcm_hw_params_set_buffer_size_near;
-    snd_pcm_hw_params_set_buffer_size_first;
-    snd_pcm_hw_params_set_buffer_size_last;
-
-    snd_pcm_hw_params_get_tick_time;
-    snd_pcm_hw_params_get_tick_time_min;
-    snd_pcm_hw_params_get_tick_time_max;
-    snd_pcm_hw_params_set_tick_time_near;
-    snd_pcm_hw_params_set_tick_time_first;
-    snd_pcm_hw_params_set_tick_time_last;
-
-} ALSA_0.9;
-
-ALSA_0.9.0rc8 {
-  global:
-
-    snd_pcm_forward;
-    snd_pcm_status_get_trigger_htstamp;
-    snd_pcm_status_get_htstamp;
-
-} ALSA_0.9.0rc4;
-
-ALSA_0.9.0 {
-  global:
-
-    snd_pcm_type_name;
-    snd_timer_query_info;
-    snd_timer_query_params;
-    snd_timer_query_status;
-    snd_timer_params_set_exclusive;
-    snd_timer_params_get_exclusive;
-    snd_timer_params_set_filter;
-    snd_timer_params_get_filter;
-} ALSA_0.9.0rc8;
-
-ALSA_0.9.3 {
-  global:
-
-    snd_ctl_elem_info_get_dimensions;
-    snd_ctl_elem_info_get_dimension;
-} ALSA_0.9.0;
-
-ALSA_0.9.5 {
-  global:
-
-    alsa_lisp;
-} ALSA_0.9.3;
-
-ALSA_0.9.6 {
-  global:
-
-    snd_hctl_open_ctl;
-    snd_seq_port_info_get_timestamping;
-    snd_seq_port_info_get_timestamp_real;
-    snd_seq_port_info_get_timestamp_queue;
-    snd_seq_port_info_set_timestamping;
-    snd_seq_port_info_set_timestamp_real;
-    snd_seq_port_info_set_timestamp_queue;
-} ALSA_0.9.5;
-
-ALSA_0.9.7 {
-  global:
-
-    snd_user_file;
-    snd_hctl_ctl;
-    sndo_*;
-    alsa_lisp_*;
-} ALSA_0.9.6;
-
-ALSA_0.9.8 {
-  global:
-
-    snd_ctl_elem_add;
-    snd_ctl_elem_replace;
-    snd_ctl_elem_remove;
-    snd_hctl_poll_descriptors_revents;
-} ALSA_0.9.7;
-
-ALSA_1.0.4 {
-  global:
-
-    snd_spcm_init;
-    snd_spcm_init_duplex;
-    snd_spcm_init_get_params;
-} ALSA_0.9.8;
-
-ALSA_1.0.5 {
-  global:
-
-    snd_asoundlib_version;
-    snd_timer_params_set_early_event;
-    snd_timer_params_get_early_event;
-} ALSA_1.0.4;
-
-ALSA_1.0.8 {
-  global:
-
-    snd_ctl_elem_add_integer;
-    snd_ctl_elem_add_integer64;
-    snd_ctl_elem_add_boolean;
-    snd_ctl_elem_add_iec958;
-    snd_ctl_elem_remove;
-} ALSA_1.0.5;
-
-ALSA_1.0.9 {
-  global:
-
-    snd_names_list;
-    snd_names_list_free;
-
-    snd_pcm_hw_params_set_rate_resample;
-    snd_pcm_hw_params_get_rate_resample;
-    snd_pcm_hw_params_set_export_buffer;
-    snd_pcm_hw_params_get_export_buffer;
-
-    snd_pcm_ioplug_create;
-    snd_pcm_ioplug_delete;
-    snd_pcm_ioplug_reinit_status;
-    snd_pcm_ioplug_params_reset;
-    snd_pcm_ioplug_set_param_minmax;
-    snd_pcm_ioplug_set_param_list;
-
-    snd_pcm_extplug_create;
-    snd_pcm_extplug_delete;
-    snd_pcm_extplug_params_reset;
-    snd_pcm_extplug_set_param_list;
-    snd_pcm_extplug_set_param_minmax;
-    snd_pcm_extplug_set_slave_param_list;
-    snd_pcm_extplug_set_slave_param_minmax;
-
-    snd_pcm_parse_control_id;
-
-    snd_async_add_timer_handler;
-    snd_async_handler_get_timer;
-
-    snd_timer_ginfo_sizeof;
-    snd_timer_ginfo_malloc;
-    snd_timer_ginfo_free;
-    snd_timer_ginfo_copy;
-    snd_timer_ginfo_set_tid;
-    snd_timer_ginfo_get_tid;
-    snd_timer_ginfo_get_flags;
-    snd_timer_ginfo_get_card;
-    snd_timer_ginfo_get_id;
-    snd_timer_ginfo_get_name;
-    snd_timer_ginfo_get_resolution;
-    snd_timer_ginfo_get_resolution_min;
-    snd_timer_ginfo_get_resolution_max;
-    snd_timer_ginfo_get_clients;
-
-} ALSA_1.0.8;
-
-ALSA_1.0.10 {
-  global:
-
-    snd_mixer_get_hctl;
-    snd_mixer_elem_get_private;
-    snd_mixer_attach_hctl;
-    snd_mixer_detach_hctl;
-
-    snd_mixer_class_register;
-    snd_mixer_add_elem;
-    snd_mixer_remove_elem;
-    snd_mixer_elem_new;
-    snd_mixer_elem_add;
-    snd_mixer_elem_remove;
-    snd_mixer_elem_free;
-    snd_mixer_elem_info;
-    snd_mixer_elem_value;
-    snd_mixer_elem_attach;
-    snd_mixer_elem_detach;
-    snd_mixer_elem_empty;
-
-    snd_mixer_class_malloc;
-    snd_mixer_class_free;
-    snd_mixer_class_copy;
-    snd_mixer_class_get_mixer;
-    snd_mixer_class_get_event;
-    snd_mixer_class_get_private;
-    snd_mixer_class_get_compare;
-    snd_mixer_class_set_event;
-    snd_mixer_class_set_private;
-    snd_mixer_class_set_private_free;
-    snd_mixer_class_set_compare;
-
-    snd_mixer_selem_set_playback_dB_all;
-    snd_mixer_selem_set_capture_dB_all;
-    snd_mixer_selem_is_enum_playback;
-    snd_mixer_selem_is_enum_capture;
-    snd_mixer_selem_compare;
-    snd_mixer_sbasic_info;
-    snd_mixer_sbasic_get_private;
-    snd_mixer_sbasic_set_private;
-    snd_mixer_sbasic_set_private_free;
-
-    snd_ctl_ext_create;
-    snd_ctl_ext_delete;
-
-} ALSA_1.0.9;
-
-ALSA_1.0.11 {
-  global:
-
-    snd_pcm_recover;
-    snd_pcm_set_params;
-    snd_pcm_get_params;
-} ALSA_1.0.10;
-
-ALSA_1.0.12 {
-  global:
-
-    snd_ctl_elem_tlv_read;
-    snd_ctl_elem_tlv_write;
-    snd_ctl_elem_tlv_command;
-    snd_ctl_elem_info_is_tlv_readable;
-    snd_ctl_elem_info_is_tlv_writable;
-    snd_ctl_elem_info_is_tlv_commandable;
-    snd_hctl_elem_tlv_read;
-    snd_hctl_elem_tlv_write;
-    snd_hctl_elem_tlv_command;
-} ALSA_1.0.11;
-
-ALSA_1.0.14 {
-  global:
-
-    snd_device_name_hint;
-    snd_device_name_free_hint;
-    snd_device_name_get_hint;
-} ALSA_1.0.12;
diff -r 4b305d56a1f0 src/Versions.in
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/src/Versions.in	Fri Jan 12 13:27:35 2007 -0500
@@ -0,0 +1,298 @@
+ALSA_0.9 {
+  global:
+    @SYMBOL_PREFIX@__snd_*;
+    @SYMBOL_PREFIX@_snd_*;
+    @SYMBOL_PREFIX@snd_*;
+  local:
+    *;
+};
+
+ALSA_0.9.0rc4 {
+  global:
+
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_access;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_access_first;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_access_last;
+
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_format;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_format_first;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_format_last;
+
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_subformat;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_subformat_first;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_subformat_last;
+
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_channels;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_channels_min;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_channels_max;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_channels_near;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_channels_first;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_channels_last;
+
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_rate;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_rate_min;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_rate_max;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_rate_near;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_rate_first;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_rate_last;
+
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_period_time;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_period_time_min;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_period_time_max;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_period_time_near;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_period_time_first;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_period_time_last;
+
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_period_size;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_period_size_min;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_period_size_max;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_period_size_near;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_period_size_first;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_period_size_last;
+
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_periods;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_periods_min;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_periods_max;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_periods_near;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_periods_first;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_periods_last;
+
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_buffer_time;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_buffer_time_min;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_buffer_time_max;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_buffer_time_near;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_buffer_time_first;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_buffer_time_last;
+
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_buffer_size;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_buffer_size_min;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_buffer_size_max;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_buffer_size_near;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_buffer_size_first;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_buffer_size_last;
+
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_tick_time;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_tick_time_min;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_tick_time_max;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_tick_time_near;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_tick_time_first;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_tick_time_last;
+
+} ALSA_0.9;
+
+ALSA_0.9.0rc8 {
+  global:
+
+    @SYMBOL_PREFIX@snd_pcm_forward;
+    @SYMBOL_PREFIX@snd_pcm_status_get_trigger_htstamp;
+    @SYMBOL_PREFIX@snd_pcm_status_get_htstamp;
+
+} ALSA_0.9.0rc4;
+
+ALSA_0.9.0 {
+  global:
+
+    @SYMBOL_PREFIX@snd_pcm_type_name;
+    @SYMBOL_PREFIX@snd_timer_query_info;
+    @SYMBOL_PREFIX@snd_timer_query_params;
+    @SYMBOL_PREFIX@snd_timer_query_status;
+    @SYMBOL_PREFIX@snd_timer_params_set_exclusive;
+    @SYMBOL_PREFIX@snd_timer_params_get_exclusive;
+    @SYMBOL_PREFIX@snd_timer_params_set_filter;
+    @SYMBOL_PREFIX@snd_timer_params_get_filter;
+} ALSA_0.9.0rc8;
+
+ALSA_0.9.3 {
+  global:
+
+    @SYMBOL_PREFIX@snd_ctl_elem_info_get_dimensions;
+    @SYMBOL_PREFIX@snd_ctl_elem_info_get_dimension;
+} ALSA_0.9.0;
+
+ALSA_0.9.5 {
+  global:
+
+    @SYMBOL_PREFIX@alsa_lisp;
+} ALSA_0.9.3;
+
+ALSA_0.9.6 {
+  global:
+
+    @SYMBOL_PREFIX@snd_hctl_open_ctl;
+    @SYMBOL_PREFIX@snd_seq_port_info_get_timestamping;
+    @SYMBOL_PREFIX@snd_seq_port_info_get_timestamp_real;
+    @SYMBOL_PREFIX@snd_seq_port_info_get_timestamp_queue;
+    @SYMBOL_PREFIX@snd_seq_port_info_set_timestamping;
+    @SYMBOL_PREFIX@snd_seq_port_info_set_timestamp_real;
+    @SYMBOL_PREFIX@snd_seq_port_info_set_timestamp_queue;
+} ALSA_0.9.5;
+
+ALSA_0.9.7 {
+  global:
+
+    @SYMBOL_PREFIX@snd_user_file;
+    @SYMBOL_PREFIX@snd_hctl_ctl;
+    @SYMBOL_PREFIX@sndo_*;
+    @SYMBOL_PREFIX@alsa_lisp_*;
+} ALSA_0.9.6;
+
+ALSA_0.9.8 {
+  global:
+
+    @SYMBOL_PREFIX@snd_ctl_elem_add;
+    @SYMBOL_PREFIX@snd_ctl_elem_replace;
+    @SYMBOL_PREFIX@snd_ctl_elem_remove;
+    @SYMBOL_PREFIX@snd_hctl_poll_descriptors_revents;
+} ALSA_0.9.7;
+
+ALSA_1.0.4 {
+  global:
+
+    @SYMBOL_PREFIX@snd_spcm_init;
+    @SYMBOL_PREFIX@snd_spcm_init_duplex;
+    @SYMBOL_PREFIX@snd_spcm_init_get_params;
+} ALSA_0.9.8;
+
+ALSA_1.0.5 {
+  global:
+
+    @SYMBOL_PREFIX@snd_asoundlib_version;
+    @SYMBOL_PREFIX@snd_timer_params_set_early_event;
+    @SYMBOL_PREFIX@snd_timer_params_get_early_event;
+} ALSA_1.0.4;
+
+ALSA_1.0.8 {
+  global:
+
+    @SYMBOL_PREFIX@snd_ctl_elem_add_integer;
+    @SYMBOL_PREFIX@snd_ctl_elem_add_integer64;
+    @SYMBOL_PREFIX@snd_ctl_elem_add_boolean;
+    @SYMBOL_PREFIX@snd_ctl_elem_add_iec958;
+    @SYMBOL_PREFIX@snd_ctl_elem_remove;
+} ALSA_1.0.5;
+
+ALSA_1.0.9 {
+  global:
+
+    @SYMBOL_PREFIX@snd_names_list;
+    @SYMBOL_PREFIX@snd_names_list_free;
+
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_rate_resample;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_rate_resample;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_export_buffer;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_export_buffer;
+
+    @SYMBOL_PREFIX@snd_pcm_ioplug_create;
+    @SYMBOL_PREFIX@snd_pcm_ioplug_delete;
+    @SYMBOL_PREFIX@snd_pcm_ioplug_reinit_status;
+    @SYMBOL_PREFIX@snd_pcm_ioplug_params_reset;
+    @SYMBOL_PREFIX@snd_pcm_ioplug_set_param_minmax;
+    @SYMBOL_PREFIX@snd_pcm_ioplug_set_param_list;
+
+    @SYMBOL_PREFIX@snd_pcm_extplug_create;
+    @SYMBOL_PREFIX@snd_pcm_extplug_delete;
+    @SYMBOL_PREFIX@snd_pcm_extplug_params_reset;
+    @SYMBOL_PREFIX@snd_pcm_extplug_set_param_list;
+    @SYMBOL_PREFIX@snd_pcm_extplug_set_param_minmax;
+    @SYMBOL_PREFIX@snd_pcm_extplug_set_slave_param_list;
+    @SYMBOL_PREFIX@snd_pcm_extplug_set_slave_param_minmax;
+
+    @SYMBOL_PREFIX@snd_pcm_parse_control_id;
+
+    @SYMBOL_PREFIX@snd_async_add_timer_handler;
+    @SYMBOL_PREFIX@snd_async_handler_get_timer;
+
+    @SYMBOL_PREFIX@snd_timer_ginfo_sizeof;
+    @SYMBOL_PREFIX@snd_timer_ginfo_malloc;
+    @SYMBOL_PREFIX@snd_timer_ginfo_free;
+    @SYMBOL_PREFIX@snd_timer_ginfo_copy;
+    @SYMBOL_PREFIX@snd_timer_ginfo_set_tid;
+    @SYMBOL_PREFIX@snd_timer_ginfo_get_tid;
+    @SYMBOL_PREFIX@snd_timer_ginfo_get_flags;
+    @SYMBOL_PREFIX@snd_timer_ginfo_get_card;
+    @SYMBOL_PREFIX@snd_timer_ginfo_get_id;
+    @SYMBOL_PREFIX@snd_timer_ginfo_get_name;
+    @SYMBOL_PREFIX@snd_timer_ginfo_get_resolution;
+    @SYMBOL_PREFIX@snd_timer_ginfo_get_resolution_min;
+    @SYMBOL_PREFIX@snd_timer_ginfo_get_resolution_max;
+    @SYMBOL_PREFIX@snd_timer_ginfo_get_clients;
+
+} ALSA_1.0.8;
+
+ALSA_1.0.10 {
+  global:
+
+    @SYMBOL_PREFIX@snd_mixer_get_hctl;
+    @SYMBOL_PREFIX@snd_mixer_elem_get_private;
+    @SYMBOL_PREFIX@snd_mixer_attach_hctl;
+    @SYMBOL_PREFIX@snd_mixer_detach_hctl;
+
+    @SYMBOL_PREFIX@snd_mixer_class_register;
+    @SYMBOL_PREFIX@snd_mixer_add_elem;
+    @SYMBOL_PREFIX@snd_mixer_remove_elem;
+    @SYMBOL_PREFIX@snd_mixer_elem_new;
+    @SYMBOL_PREFIX@snd_mixer_elem_add;
+    @SYMBOL_PREFIX@snd_mixer_elem_remove;
+    @SYMBOL_PREFIX@snd_mixer_elem_free;
+    @SYMBOL_PREFIX@snd_mixer_elem_info;
+    @SYMBOL_PREFIX@snd_mixer_elem_value;
+    @SYMBOL_PREFIX@snd_mixer_elem_attach;
+    @SYMBOL_PREFIX@snd_mixer_elem_detach;
+    @SYMBOL_PREFIX@snd_mixer_elem_empty;
+
+    @SYMBOL_PREFIX@snd_mixer_class_malloc;
+    @SYMBOL_PREFIX@snd_mixer_class_free;
+    @SYMBOL_PREFIX@snd_mixer_class_copy;
+    @SYMBOL_PREFIX@snd_mixer_class_get_mixer;
+    @SYMBOL_PREFIX@snd_mixer_class_get_event;
+    @SYMBOL_PREFIX@snd_mixer_class_get_private;
+    @SYMBOL_PREFIX@snd_mixer_class_get_compare;
+    @SYMBOL_PREFIX@snd_mixer_class_set_event;
+    @SYMBOL_PREFIX@snd_mixer_class_set_private;
+    @SYMBOL_PREFIX@snd_mixer_class_set_private_free;
+    @SYMBOL_PREFIX@snd_mixer_class_set_compare;
+
+    @SYMBOL_PREFIX@snd_mixer_selem_set_playback_dB_all;
+    @SYMBOL_PREFIX@snd_mixer_selem_set_capture_dB_all;
+    @SYMBOL_PREFIX@snd_mixer_selem_is_enum_playback;
+    @SYMBOL_PREFIX@snd_mixer_selem_is_enum_capture;
+    @SYMBOL_PREFIX@snd_mixer_selem_compare;
+    @SYMBOL_PREFIX@snd_mixer_sbasic_info;
+    @SYMBOL_PREFIX@snd_mixer_sbasic_get_private;
+    @SYMBOL_PREFIX@snd_mixer_sbasic_set_private;
+    @SYMBOL_PREFIX@snd_mixer_sbasic_set_private_free;
+
+    @SYMBOL_PREFIX@snd_ctl_ext_create;
+    @SYMBOL_PREFIX@snd_ctl_ext_delete;
+
+} ALSA_1.0.9;
+
+ALSA_1.0.11 {
+  global:
+
+    @SYMBOL_PREFIX@snd_pcm_recover;
+    @SYMBOL_PREFIX@snd_pcm_set_params;
+    @SYMBOL_PREFIX@snd_pcm_get_params;
+} ALSA_1.0.10;
+
+ALSA_1.0.12 {
+  global:
+
+    @SYMBOL_PREFIX@snd_ctl_elem_tlv_read;
+    @SYMBOL_PREFIX@snd_ctl_elem_tlv_write;
+    @SYMBOL_PREFIX@snd_ctl_elem_tlv_command;
+    @SYMBOL_PREFIX@snd_ctl_elem_info_is_tlv_readable;
+    @SYMBOL_PREFIX@snd_ctl_elem_info_is_tlv_writable;
+    @SYMBOL_PREFIX@snd_ctl_elem_info_is_tlv_commandable;
+    @SYMBOL_PREFIX@snd_hctl_elem_tlv_read;
+    @SYMBOL_PREFIX@snd_hctl_elem_tlv_write;
+    @SYMBOL_PREFIX@snd_hctl_elem_tlv_command;
+} ALSA_1.0.11;
+
+ALSA_1.0.14 {
+  global:
+
+    @SYMBOL_PREFIX@snd_device_name_hint;
+    @SYMBOL_PREFIX@snd_device_name_free_hint;
+    @SYMBOL_PREFIX@snd_device_name_get_hint;
+} ALSA_1.0.12;

--Boundary-00=_Cw9pFExyUI0ud/7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_Cw9pFExyUI0ud/7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_Cw9pFExyUI0ud/7--
