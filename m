From: Thomas Charbonnel <thomas@undata.org>
Subject: [PATCH] amixer : allowing cget with parameters
Date: 08 Mar 2003 12:44:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1047123893.2287.21.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-qvHLZahdPpIvyZDmxqk9"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-qvHLZahdPpIvyZDmxqk9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

The attached patch allows retrieval of parameter dependent values with
cget.

Thomas.



--=-qvHLZahdPpIvyZDmxqk9
Content-Disposition: attachment; filename=amixer_cget_with_parameters.patch
Content-Type: text/plain; name=amixer_cget_with_parameters.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- amixer.c.orig	2003-02-24 14:51:16.000000000 +0100
+++ amixer.c	2003-03-08 12:40:53.000000000 +0100
@@ -378,7 +378,7 @@
 }
 
 static int show_control(const char *space, snd_hctl_elem_t *elem,
-			int level)
+			int level, snd_ctl_elem_value_t *ctrl)
 {
 	int err;
 	unsigned int item, idx;
@@ -389,7 +389,10 @@
 	snd_ctl_elem_value_t *control;
 	snd_ctl_elem_id_alloca(&id);
 	snd_ctl_elem_info_alloca(&info);
-	snd_ctl_elem_value_alloca(&control);
+	if (ctrl == NULL)
+		snd_ctl_elem_value_alloca(&control);
+	else
+		control = ctrl;
 	if ((err = snd_hctl_elem_info(elem, info)) < 0) {
 		error("Control %s snd_hctl_elem_info error: %s\n", card, snd_strerror(err));
 		return err;
@@ -497,7 +500,7 @@
 		show_control_id(id);
 		printf("\n");
 		if (level & LEVEL_BASIC)
-			show_control("  ", elem, 1);
+			show_control("  ", elem, 1, NULL);
 	}
 	snd_hctl_close(handle);
 	return 0;
@@ -971,60 +974,60 @@
 	count = snd_ctl_elem_info_get_count(info);
 	snd_ctl_elem_value_set_id(control, id);
 	
-	if (!roflag) {
-		ptr = argv[1];
-		for (idx = 0; idx < count && idx < 128 && ptr && *ptr; idx++) {
-			switch (type) {
-			case SND_CTL_ELEM_TYPE_BOOLEAN:
-				tmp = 0;
-				if (!strncasecmp(ptr, "on", 2) || !strncasecmp(ptr, "up", 2)) {
-					tmp = 1;
-					ptr += 2;
-				} else if (!strncasecmp(ptr, "yes", 3)) {
-					tmp = 1;
-					ptr += 3;
-				} else if (!strncasecmp(ptr, "toggle", 6)) {
-					tmp = snd_ctl_elem_value_get_boolean(control, idx);
-					tmp = tmp > 0 ? 0 : 1;
-					ptr += 6;
-				} else if (isdigit(*ptr)) {
-					tmp = atoi(ptr) > 0 ? 1 : 0;
-					while (isdigit(*ptr))
-						ptr++;
-				} else {
-					while (*ptr && *ptr != ',')
-						ptr++;
-				}
-				snd_ctl_elem_value_set_boolean(control, idx, tmp);
-				break;
-			case SND_CTL_ELEM_TYPE_INTEGER:
-				tmp = get_integer(&ptr,
-						  snd_ctl_elem_info_get_min(info),
-						  snd_ctl_elem_info_get_max(info));
-				snd_ctl_elem_value_set_integer(control, idx, tmp);
-				break;
-			case SND_CTL_ELEM_TYPE_INTEGER64:
-				tmp = get_integer64(&ptr,
-						  snd_ctl_elem_info_get_min64(info),
-						  snd_ctl_elem_info_get_max64(info));
-				snd_ctl_elem_value_set_integer64(control, idx, tmp);
-				break;
-			case SND_CTL_ELEM_TYPE_ENUMERATED:
-				tmp = get_integer(&ptr, 0, snd_ctl_elem_info_get_items(info) - 1);
-				snd_ctl_elem_value_set_enumerated(control, idx, tmp);
-				break;
-			case SND_CTL_ELEM_TYPE_BYTES:
-				tmp = get_integer(&ptr, 0, 255);
-				snd_ctl_elem_value_set_byte(control, idx, tmp);
-				break;
-			default:
-				break;
+	ptr = argv[1];
+	for (idx = 0; idx < count && idx < 128 && ptr && *ptr; idx++) {
+		switch (type) {
+		case SND_CTL_ELEM_TYPE_BOOLEAN:
+			tmp = 0;
+			if (!strncasecmp(ptr, "on", 2) || !strncasecmp(ptr, "up", 2)) {
+				tmp = 1;
+				ptr += 2;
+			} else if (!strncasecmp(ptr, "yes", 3)) {
+				tmp = 1;
+				ptr += 3;
+			} else if (!strncasecmp(ptr, "toggle", 6)) {
+				tmp = snd_ctl_elem_value_get_boolean(control, idx);
+				tmp = tmp > 0 ? 0 : 1;
+				ptr += 6;
+			} else if (isdigit(*ptr)) {
+				tmp = atoi(ptr) > 0 ? 1 : 0;
+				while (isdigit(*ptr))
+					ptr++;
+			} else {
+				while (*ptr && *ptr != ',')
+					ptr++;
 			}
-			if (!strchr(argv[1], ','))
-				ptr = argv[1];
-			else if (*ptr == ',')
-				ptr++;
+			snd_ctl_elem_value_set_boolean(control, idx, tmp);
+			break;
+		case SND_CTL_ELEM_TYPE_INTEGER:
+			tmp = get_integer(&ptr,
+					  snd_ctl_elem_info_get_min(info),
+					  snd_ctl_elem_info_get_max(info));
+			snd_ctl_elem_value_set_integer(control, idx, tmp);
+			break;
+		case SND_CTL_ELEM_TYPE_INTEGER64:
+			tmp = get_integer64(&ptr,
+					  snd_ctl_elem_info_get_min64(info),
+					  snd_ctl_elem_info_get_max64(info));
+			snd_ctl_elem_value_set_integer64(control, idx, tmp);
+			break;
+		case SND_CTL_ELEM_TYPE_ENUMERATED:
+			tmp = get_integer(&ptr, 0, snd_ctl_elem_info_get_items(info) - 1);
+			snd_ctl_elem_value_set_enumerated(control, idx, tmp);
+			break;
+		case SND_CTL_ELEM_TYPE_BYTES:
+			tmp = get_integer(&ptr, 0, 255);
+			snd_ctl_elem_value_set_byte(control, idx, tmp);
+			break;
+		default:
+			break;
 		}
+		if (!strchr(argv[1], ','))
+			ptr = argv[1];
+		else if (*ptr == ',')
+			ptr++;
+	}
+	if (!roflag) {
 		if ((err = snd_ctl_elem_write(handle, control)) < 0) {
 			error("Control %s element write error: %s\n", card, snd_strerror(err));
 			return err;
@@ -1044,7 +1047,7 @@
 		}
 		elem = snd_hctl_find_elem(hctl, id);
 		if (elem)
-			show_control("  ", elem, LEVEL_BASIC | LEVEL_ID);
+			show_control("  ", elem, LEVEL_BASIC | LEVEL_ID, control);
 		else
 			printf("Could not find the specified element\n");
 		snd_hctl_close(hctl);

--=-qvHLZahdPpIvyZDmxqk9--



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
