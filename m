From: Jordi Mallach <jordi@debian.org>
Subject: alsa-utils patches
Date: Mon, 24 Feb 2003 14:38:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030224133802.GA3299@nubol.int.oskuro.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: debian-alsa@lists.wedontsleep.org
List-Id: alsa-devel@alsa-project.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Here's a new batch of Debian patches, all from David B. Harris.

- add a "Press Escape to quit" string to alsamixer's title, some uses
  couldn't figure out how to exit the program (Debian Bug#178393).
- hide the cursor, which was missplaced and wasn't goodlooking anyway
  (Debian Bug#81169).
- remove trailing spaces from amixer's output (Debian Bug#177518).
- don't ignore second -l/-L flags in aplay (Debian Bug#177521).

As always, details for each bug is in http://bugs.debian.org/xxxxxx,
where xxxxxx is the bug number.

--- alsa-utils-0.9.0rc7.orig/alsamixer/alsamixer.c
+++ alsa-utils-0.9.0rc7/alsamixer/alsamixer.c
@@ -1029,7 +1029,7 @@
=20
   /* program title
    */
-  sprintf (string, "%s %s", PRGNAME_UPPER, VERSION);
+  sprintf (string, "%s %s (Press Escape to quit)", PRGNAME_UPPER, VERSION);
   max_len =3D strlen (string);
   if (mixer_max_x >=3D max_len + 4)
     {
@@ -1566,6 +1566,7 @@
   /* initialize ncurses
    */
   mixer_window =3D initscr ();
+  curs_set (0); /* hide the cursor */
=20
   mixer_no_lrcorner =3D tigetflag ("xenl") !=3D 1 && tigetflag ("am") !=3D=
 1;
=20
--- alsa-utils-0.9.0rc7.orig/amixer/amixer.c
+++ alsa-utils-0.9.0rc7/amixer/amixer.c
@@ -561,17 +561,17 @@
 			       snd_mixer_selem_get_capture_group(elem));
 		if (snd_mixer_selem_has_playback_volume(elem) ||
 		    snd_mixer_selem_has_playback_switch(elem)) {
-			printf("%sPlayback channels: ", space);
+			printf("%sPlayback channels:", space);
 			if (snd_mixer_selem_is_playback_mono(elem)) {
-				printf("Mono");
+				printf(" Mono");
 			} else {
 				int first =3D 1;
 				for (chn =3D 0; chn <=3D SND_MIXER_SCHN_LAST; chn++){
 					if (!snd_mixer_selem_has_playback_channel(elem, chn))
 						continue;
 					if (!first)
-						printf("- ");
-					printf("%s ", snd_mixer_selem_channel_name(chn));
+						printf(" -");
+					printf(" %s", snd_mixer_selem_channel_name(chn));
 					first =3D 0;
 				}
 			}
@@ -579,17 +579,17 @@
 		}
 		if (snd_mixer_selem_has_capture_volume(elem) ||
 		    snd_mixer_selem_has_capture_switch(elem)) {
-			printf("%sCapture channels: ", space);
+			printf("%sCapture channels:", space);
 			if (snd_mixer_selem_is_capture_mono(elem)) {
-				printf("Mono");
+				printf(" Mono");
 			} else {
 				int first =3D 1;
 				for (chn =3D 0; chn <=3D SND_MIXER_SCHN_LAST; chn++){
 					if (!snd_mixer_selem_has_capture_channel(elem, chn))
 						continue;
 					if (!first)
-						printf("- ");
-					printf("%s ", snd_mixer_selem_channel_name(chn));
+						printf(" -");
+					printf(" %s", snd_mixer_selem_channel_name(chn));
 					first =3D 0;
 				}
 			}
@@ -597,19 +597,19 @@
 		}
 		if (snd_mixer_selem_has_playback_volume(elem) ||
 		    snd_mixer_selem_has_capture_volume(elem)) {
-			printf("%sLimits: ", space);
+			printf("%sLimits:", space);
 			if (snd_mixer_selem_has_common_volume(elem)) {
 				snd_mixer_selem_get_playback_volume_range(elem, &pmin, &pmax);
 				snd_mixer_selem_get_capture_volume_range(elem, &cmin, &cmax);
-				printf("%li - %li", pmin, pmax);
+				printf(" %li - %li", pmin, pmax);
 			} else {
 				if (snd_mixer_selem_has_playback_volume(elem)) {
 					snd_mixer_selem_get_playback_volume_range(elem, &pmin, &pmax);
-					printf("Playback %li - %li ", pmin, pmax);
+					printf(" Playback %li - %li", pmin, pmax);
 				}
 				if (snd_mixer_selem_has_capture_volume(elem)) {
 					snd_mixer_selem_get_capture_volume_range(elem, &cmin, &cmax);
-					printf("Capture %li - %li", cmin, cmax);
+					printf(" Capture %li - %li", cmin, cmax);
 				}
 			}
 			printf("\n");
@@ -631,61 +631,61 @@
 #endif
 		if (pmono || cmono) {
 			if (!mono_ok) {
-				printf("%s%s: ", space, "Mono");
+				printf("%s%s:", space, "Mono");
 				mono_ok =3D 1;
 			}
 			if (snd_mixer_selem_has_common_volume(elem)) {
 				snd_mixer_selem_get_playback_volume(elem, SND_MIXER_SCHN_MONO, &pvol);
-				printf("%s ", get_percent(pvol, pmin, pmax));
+				printf(" %s", get_percent(pvol, pmin, pmax));
 			}
 			if (snd_mixer_selem_has_common_switch(elem)) {
 				snd_mixer_selem_get_playback_switch(elem, SND_MIXER_SCHN_MONO, &psw);
-				printf("[%s] ", psw ? "on" : "off");
+				printf(" [%s]", psw ? "on" : "off");
 			}
 		}
 		if (pmono && snd_mixer_selem_has_playback_channel(elem, SND_MIXER_SCHN_M=
ONO)) {
 			int title =3D 0;
 			if (!mono_ok) {
-				printf("%s%s: ", space, "Mono");
+				printf("%s%s:", space, "Mono");
 				mono_ok =3D 1;
 			}
 			if (!snd_mixer_selem_has_common_volume(elem)) {
 				if (snd_mixer_selem_has_playback_volume(elem)) {
-					printf("Playback ");
+					printf(" Playback");
 					title =3D 1;
 					snd_mixer_selem_get_playback_volume(elem, SND_MIXER_SCHN_MONO, &pvol);
-					printf("%s ", get_percent(pvol, pmin, pmax));
+					printf(" %s", get_percent(pvol, pmin, pmax));
 				}
 			}
 			if (!snd_mixer_selem_has_common_switch(elem)) {
 				if (snd_mixer_selem_has_playback_switch(elem)) {
 					if (!title)
-						printf("Playback ");
+						printf(" Playback");
 					snd_mixer_selem_get_playback_switch(elem, SND_MIXER_SCHN_MONO, &psw);
-					printf("[%s] ", psw ? "on" : "off");
+					printf(" [%s]", psw ? "on" : "off");
 				}
 			}
 		}
 		if (cmono && snd_mixer_selem_has_capture_channel(elem, SND_MIXER_SCHN_MO=
NO)) {
 			int title =3D 0;
 			if (!mono_ok) {
-				printf("%s%s: ", space, "Mono");
+				printf("%s%s:", space, "Mono");
 				mono_ok =3D 1;
 			}
 			if (!snd_mixer_selem_has_common_volume(elem)) {
 				if (snd_mixer_selem_has_capture_volume(elem)) {
-					printf("Capture ");
+					printf(" Capture");
 					title =3D 1;
 					snd_mixer_selem_get_capture_volume(elem, SND_MIXER_SCHN_MONO, &cvol);
-					printf("%s ", get_percent(cvol, cmin, cmax));
+					printf(" %s", get_percent(cvol, cmin, cmax));
 				}
 			}
 			if (!snd_mixer_selem_has_common_switch(elem)) {
 				if (snd_mixer_selem_has_capture_switch(elem)) {
 					if (!title)
-						printf("Capture ");
+						printf(" Capture");
 					snd_mixer_selem_get_capture_switch(elem, SND_MIXER_SCHN_MONO, &csw);
-					printf("[%s] ", csw ? "on" : "off");
+					printf(" [%s]", csw ? "on" : "off");
 				}
 			}
 		}
@@ -696,31 +696,31 @@
 				if ((pmono || !snd_mixer_selem_has_playback_channel(elem, chn)) &&
 				    (cmono || !snd_mixer_selem_has_capture_channel(elem, chn)))
 					continue;
-				printf("%s%s: ", space, snd_mixer_selem_channel_name(chn));
+				printf("%s%s:", space, snd_mixer_selem_channel_name(chn));
 				if (!pmono && !cmono && snd_mixer_selem_has_common_volume(elem)) {
 					snd_mixer_selem_get_playback_volume(elem, chn, &pvol);
-					printf("%s ", get_percent(pvol, pmin, pmax));
+					printf(" %s", get_percent(pvol, pmin, pmax));
 				}
 				if (!pmono && !cmono && snd_mixer_selem_has_common_switch(elem)) {
 					snd_mixer_selem_get_playback_switch(elem, chn, &psw);
-					printf("[%s] ", psw ? "on" : "off");
+					printf(" [%s]", psw ? "on" : "off");
 				}
 				if (!pmono && snd_mixer_selem_has_playback_channel(elem, chn)) {
 					int title =3D 0;
 					if (!snd_mixer_selem_has_common_volume(elem)) {
 						if (snd_mixer_selem_has_playback_volume(elem)) {
-							printf("Playback ");
+							printf(" Playback");
 							title =3D 1;
 							snd_mixer_selem_get_playback_volume(elem, chn, &pvol);
-							printf("%s ", get_percent(pvol, pmin, pmax));
+							printf(" %s", get_percent(pvol, pmin, pmax));
 						}
 					}
 					if (!snd_mixer_selem_has_common_switch(elem)) {
 						if (snd_mixer_selem_has_playback_switch(elem)) {
 							if (!title)
-								printf("Playback ");
+								printf(" Playback");
 							snd_mixer_selem_get_playback_switch(elem, chn, &psw);
-							printf("[%s] ", psw ? "on" : "off");
+							printf(" [%s]", psw ? "on" : "off");
 						}
 					}
 				}
@@ -728,18 +728,18 @@
 					int title =3D 0;
 					if (!snd_mixer_selem_has_common_volume(elem)) {
 						if (snd_mixer_selem_has_capture_volume(elem)) {
-							printf("Capture ");
+							printf(" Capture");
 							title =3D 1;
 							snd_mixer_selem_get_capture_volume(elem, chn, &cvol);
-							printf("%s ", get_percent(cvol, cmin, cmax));
+							printf(" %s", get_percent(cvol, cmin, cmax));
 						}
 					}
 					if (!snd_mixer_selem_has_common_switch(elem)) {
 						if (snd_mixer_selem_has_capture_switch(elem)) {
 							if (!title)
-								printf("Capture ");
+								printf(" Capture");
 							snd_mixer_selem_get_capture_switch(elem, chn, &csw);
-							printf("[%s] ", csw ? "on" : "off");
+							printf(" [%s]", csw ? "on" : "off");
 						}
 					}
 				}
--- alsa-utils-0.9.0rc7.orig/aplay/aplay.c
+++ alsa-utils-0.9.0rc7/aplay/aplay.c
@@ -313,6 +313,7 @@
 	};
 	char *pcm_name =3D "default";
 	int tmp, err, c;
+	int do_device_list =3D 0, do_pcm_list =3D 0;
 	snd_pcm_info_t *info;
=20
 	err =3D snd_output_stdio_attach(&log, stderr, 0);
@@ -347,11 +348,11 @@
 			version();
 			return 0;
 		case 'l':
-			device_list();
-			return 0;
+			do_device_list =3D 1;
+			break;
 		case 'L':
-			pcm_list();
-			return 0;
+			do_pcm_list =3D 1;
+			break;
 		case 'D':
 			pcm_name =3D optarg;
 			break;
@@ -457,6 +458,15 @@
 		}
 	}
=20
+	if (do_device_list) {
+		if (do_pcm_list) pcm_list();
+		device_list();
+		return 0;
+	} else if (do_pcm_list) {
+		pcm_list();
+		return 0;
+	}
+
 	err =3D snd_pcm_open(&handle, pcm_name, stream, open_mode);
 	if (err < 0) {
 		error("audio open error: %s", snd_strerror(err));

--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+WiA6JYSUupF6Il4RAsILAJ9lYP7iWiw+MorBcIcHnt1jlTKfrACfWa9D
2NsR41EPtTIQVJXUqvSreJs=
=tabB
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
