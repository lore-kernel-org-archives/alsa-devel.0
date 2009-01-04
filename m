From: Peter Stokes <linux@dadeos.co.uk>
Subject: Re: [PATCH 1/2] New Control Plugin - arcam-av
Date: Sun, 4 Jan 2009 21:13:26 +0000
Message-ID: <18D01D59-8B64-458C-B0A6-D2CE356DAA22@dadeos.co.uk>
References: <200901032056.35982.linux@dadeos.co.uk>
	<20090103233558.GR32364@curie-int.orbis-terrarum.net>
	<200901041237.11381.linux@dadeos.co.uk>
	<s5hwsdbjgw2.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/mixed; boundary=Apple-Mail-60--606663862
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.freeserve.com (smtp3.wanadoo.co.uk [193.252.22.156])
	by alsa0.perex.cz (Postfix) with ESMTP id C6D321037F1
	for <alsa-devel@alsa-project.org>; Sun,  4 Jan 2009 22:13:30 +0100 (CET)
In-Reply-To: <s5hwsdbjgw2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--Apple-Mail-60--606663862
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit


Thank you for taking the time to review my code.

On 4 Jan 2009, at 14:16, Takashi Iwai wrote:

> At Sun, 4 Jan 2009 12:37:11 +0000,
> Peter Stokes wrote:
>>
>> --- alsa-plugins-1.0.18-orig/arcam-av/arcam_av.c	1970-01-01  
>> 01:00:00.000000000
>> +0100
>> +++ alsa-plugins-1.0.18/arcam-av/arcam_av.c	2009-01-02  
>> 22:30:55.000000000
>> +0000
>
> Looks like your embedded patches are broken due to line-breaks by MUA.
> Please fix it, or use attachments if it's difficult.
>

I'll try attaching it. Please find attached an updated patch.

--Apple-Mail-60--606663862
Content-Disposition: attachment;
	filename=arcam-av.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="arcam-av.patch"
Content-Transfer-Encoding: 7bit

diff -Nrup alsa-plugins-1.0.18-orig/Makefile.am alsa-plugins-1.0.18/Makefile.am
--- alsa-plugins-1.0.18-orig/Makefile.am	2008-10-29 12:42:13.000000000 +0000
+++ alsa-plugins-1.0.18/Makefile.am	2009-01-04 18:03:29.000000000 +0000
@@ -18,7 +18,7 @@ if HAVE_PPH
 PPHDIR = pph
 endif
 
-SUBDIRS = oss mix $(PPHDIR) $(JACKDIR) $(PULSEDIR) $(SAMPLERATEDIR) $(A52DIR) $(LAVCRATEDIR) $(MAEMODIR) usb_stream doc
+SUBDIRS = oss mix $(PPHDIR) $(JACKDIR) $(PULSEDIR) $(SAMPLERATEDIR) $(A52DIR) $(LAVCRATEDIR) $(MAEMODIR) usb_stream arcam-av doc
 EXTRA_DIST = gitcompile version COPYING.GPL
 AUTOMAKE_OPTIONS = foreign
 
diff -Nrup alsa-plugins-1.0.18-orig/arcam-av/Makefile.am alsa-plugins-1.0.18/arcam-av/Makefile.am
--- alsa-plugins-1.0.18-orig/arcam-av/Makefile.am	1970-01-01 01:00:00.000000000 +0100
+++ alsa-plugins-1.0.18/arcam-av/Makefile.am	2009-01-04 18:03:29.000000000 +0000
@@ -0,0 +1,9 @@
+asound_module_ctl_arcam_av_LTLIBRARIES = libasound_module_ctl_arcam_av.la
+
+asound_module_ctl_arcam_avdir = @ALSA_PLUGIN_DIR@
+
+AM_CFLAGS = -Wall -g @ALSA_CFLAGS@
+AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined
+
+libasound_module_ctl_arcam_av_la_SOURCES = ctl_arcam_av.c arcam_av.c arcam_av.h
+libasound_module_ctl_arcam_av_la_LIBADD = @ALSA_LIBS@
diff -Nrup alsa-plugins-1.0.18-orig/arcam-av/arcam_av.c alsa-plugins-1.0.18/arcam-av/arcam_av.c
--- alsa-plugins-1.0.18-orig/arcam-av/arcam_av.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-plugins-1.0.18/arcam-av/arcam_av.c	2009-01-04 20:09:06.000000000 +0000
@@ -0,0 +1,658 @@
+/*
+ * ALSA -> Arcam AV control plugin
+ *
+ * Copyright (c) 2009 by Peter Stokes <linux@dadeos.co.uk>
+ *
+ * This library is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU Lesser General Public License as
+ * published by the Free Software Foundation; either version 2.1 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+
+#include "arcam_av.h"
+
+#include <errno.h>
+#include <fcntl.h>
+#include <semaphore.h>
+#include <signal.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <termios.h>
+#include <unistd.h>
+
+#include <sys/ipc.h>
+#include <sys/shm.h>
+#include <sys/stat.h>
+#include <sys/stat.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#define MIN(a, b)     ((a) < (b) ? (a) : (b))
+#define MAX(a, b)     ((a) > (b) ? (a) : (b))
+
+
+int arcam_av_connect(const char* port)
+{
+	struct termios portsettings;
+
+	int fd = open(port, O_RDWR | O_NOCTTY);
+	if (fd < 0)
+		return -errno;
+
+	bzero(&portsettings, sizeof(portsettings));
+	portsettings.c_cflag = B38400 | CS8 | CLOCAL | CREAD;
+	portsettings.c_iflag = IGNPAR;
+	portsettings.c_oflag = 0;
+	portsettings.c_lflag = 0;
+	portsettings.c_cc[VTIME] = 0;
+	portsettings.c_cc[VMIN] = 5;
+	tcflush(fd, TCIFLUSH);
+	tcsetattr(fd, TCSANOW, &portsettings);
+
+	return fd;
+}
+
+
+int arcam_av_send(int fd, arcam_av_cc_t command, unsigned char param1, unsigned char param2)
+{
+	const char buffer[7] = {'P', 'C', '_', command, param1, param2, 0x0D};
+	const char* cursor = buffer;
+
+	tcdrain(fd);
+
+	do {
+		ssize_t bytes = write(fd, cursor, sizeof buffer - (cursor - buffer));
+
+		if (bytes <= 0)
+			return -errno;
+		
+		cursor += bytes;
+
+	} while (cursor < buffer + sizeof buffer);
+
+	return 0;
+}
+
+
+static int arcam_av_receive(int fd, arcam_av_cc_t* command, unsigned char* param1, unsigned char* param2)
+{
+	static int index = 0;
+	static arcam_av_cc_t received_command;
+	static unsigned char received_param1;
+	static unsigned char received_param2;
+
+	do {
+		static char buffer[8];
+		char* cursor = buffer;
+
+		ssize_t bytes = read(fd, buffer, sizeof buffer - index);
+
+		if (bytes <= 0)
+			return -errno;
+
+		while(bytes > 0) {
+			switch(index++) {
+			case 0:
+				if (*cursor != 'A')
+					index = 0;
+				break;
+
+			case 1:
+				if (*cursor != 'V') {
+					index = 0;
+					continue;
+				}
+				break;
+
+			case 2:
+				if (*cursor != '_') {
+					index = 0;
+					continue;
+				}
+				break;
+
+			case 3:
+				received_command = *cursor;
+				break;
+
+			case 4:
+				if (*cursor != ARCAM_AV_OK) {
+					index = 0;
+					continue;
+				}
+				break;
+
+			case 5:
+				received_param1 = *cursor;
+				break;
+
+			case 6:
+				received_param2 = *cursor;
+				break;
+
+			case 7:
+				if (*cursor != 0x0D) {
+					index = 0;
+					continue;
+				}
+				break;
+			}
+
+			++cursor;
+			--bytes;
+		}
+	} while (index < 8);
+
+	index = 0;
+	*command = received_command;
+	*param1 = received_param1;
+	*param2 = received_param2;
+
+	return 0;
+}
+
+
+static int arcam_av_update(arcam_av_state_t* state, int fd)
+{
+	int result = -1;
+
+	arcam_av_cc_t command = 0;
+	unsigned char param1 = 0;
+	unsigned char param2 = 0;
+
+	while (!arcam_av_receive(fd, &command, &param1, &param2)) {
+		switch(command) {
+		case ARCAM_AV_POWER:
+			switch(param1) {
+			case ARCAM_AV_ZONE1:
+				state->zone1.power = param2;
+				result = 0;
+				break;
+
+			case ARCAM_AV_ZONE2:
+				state->zone2.power = param2;
+				result = 0;
+				break;
+
+			default:
+				break;
+			}
+			break;
+
+		case ARCAM_AV_VOLUME_CHANGE:
+		case ARCAM_AV_VOLUME_SET:
+			switch(param1) {
+			case ARCAM_AV_ZONE1:
+				state->zone1.volume = param2;
+				result = 0;
+				break;
+
+			case ARCAM_AV_ZONE2:
+				state->zone2.volume = param2;
+				result = 0;
+				break;
+
+			default:
+				break;
+			}
+			break;
+
+		case ARCAM_AV_MUTE:
+			switch(param1) {
+			case ARCAM_AV_ZONE1:
+				state->zone1.mute = param2;
+				result = 0;
+				break;
+
+			case ARCAM_AV_ZONE2:
+				state->zone2.mute = param2;
+				result = 0;
+				break;
+
+			default:
+				break;
+			}
+			break;
+
+		case ARCAM_AV_DIRECT:
+			switch(param1) {
+			case ARCAM_AV_ZONE1:
+				state->zone1.direct = param2;
+				result = 0;
+				break;
+
+			default:
+				break;
+			}
+			break;
+
+		case ARCAM_AV_SOURCE:
+			switch(param1) {
+			case ARCAM_AV_ZONE1:
+				state->zone1.source = param2;
+				result = 0;
+				break;
+
+			case ARCAM_AV_ZONE2:
+				state->zone2.source = param2;
+				result = 0;
+				break;
+
+			default:
+				break;
+			}
+			break;
+
+		case ARCAM_AV_SOURCE_TYPE:
+			switch(param1) {
+			case ARCAM_AV_ZONE1:
+				state->zone1.source_type = param2;
+				result = 0;
+				break;
+
+			default:
+				break;
+			}
+			break;
+
+		case ARCAM_AV_STEREO_DECODE:
+			switch(param1) {
+			case ARCAM_AV_ZONE1:
+				state->zone1.stereo_decode = param2;
+				result = 0;
+				break;
+
+			default:
+				break;
+			}
+			break;
+
+		case ARCAM_AV_STEREO_EFFECT:
+			switch(param1) {
+			case ARCAM_AV_ZONE1:
+				state->zone1.stereo_effect = param2;
+				result = 0;
+				break;
+
+			default:
+				break;
+			}
+			break;
+
+		case ARCAM_AV_MULTI_DECODE:
+			switch(param1) {
+			case ARCAM_AV_ZONE1:
+				state->zone1.multi_decode = param2;
+				result = 0;
+				break;
+
+			default:
+				break;
+			}
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	return result;
+}
+
+
+static void arcam_av_state_query(int fd)
+{
+	arcam_av_send(fd, ARCAM_AV_POWER, ARCAM_AV_ZONE1, ARCAM_AV_POWER_REQUEST);
+	arcam_av_send(fd, ARCAM_AV_VOLUME_CHANGE, ARCAM_AV_ZONE1, ARCAM_AV_VOLUME_REQUEST);
+	arcam_av_send(fd, ARCAM_AV_MUTE, ARCAM_AV_ZONE1, ARCAM_AV_MUTE_REQUEST);
+	arcam_av_send(fd, ARCAM_AV_DIRECT, ARCAM_AV_ZONE1, ARCAM_AV_DIRECT_REQUEST);
+	arcam_av_send(fd, ARCAM_AV_SOURCE, ARCAM_AV_ZONE1, ARCAM_AV_SOURCE_REQUEST);
+	arcam_av_send(fd, ARCAM_AV_SOURCE_TYPE, ARCAM_AV_ZONE1, ARCAM_AV_SOURCE_TYPE_REQUEST);
+	arcam_av_send(fd, ARCAM_AV_STEREO_DECODE, ARCAM_AV_ZONE1, ARCAM_AV_STEREO_DECODE_REQUEST);
+	arcam_av_send(fd, ARCAM_AV_MULTI_DECODE, ARCAM_AV_ZONE1, ARCAM_AV_MULTI_DECODE_REQUEST);
+	arcam_av_send(fd, ARCAM_AV_STEREO_EFFECT, ARCAM_AV_ZONE1, ARCAM_AV_STEREO_EFFECT_REQUEST);
+
+	arcam_av_send(fd, ARCAM_AV_POWER, ARCAM_AV_ZONE2, ARCAM_AV_POWER_REQUEST);
+	arcam_av_send(fd, ARCAM_AV_VOLUME_CHANGE, ARCAM_AV_ZONE2, ARCAM_AV_VOLUME_REQUEST);
+	arcam_av_send(fd, ARCAM_AV_MUTE, ARCAM_AV_ZONE2, ARCAM_AV_MUTE_REQUEST);
+	arcam_av_send(fd, ARCAM_AV_SOURCE, ARCAM_AV_ZONE2, ARCAM_AV_SOURCE_REQUEST);
+}
+
+
+static int arcam_av_state_shm_id = -1;
+
+arcam_av_state_t* arcam_av_state_attach(const char* port)
+{
+	arcam_av_state_t* state;
+
+	if (arcam_av_state_shm_id < 0) {
+		struct stat port_stat;
+		key_t ipc_key;
+		int shmflg;
+		struct shmid_ds shm_stat;
+
+		if (stat(port, &port_stat))
+			return NULL;
+
+		ipc_key = ftok(port, 'A');
+		if (ipc_key < 0)
+			return NULL;
+
+		shmflg = IPC_CREAT | (port_stat.st_mode & (S_IRWXU | S_IRWXG | S_IRWXO));
+		arcam_av_state_shm_id = shmget(ipc_key, sizeof(arcam_av_state_t), shmflg);
+		if (arcam_av_state_shm_id < 0)
+			return NULL;
+
+		if (shmctl(arcam_av_state_shm_id, IPC_STAT, &shm_stat))
+			return NULL;
+
+		shm_stat.shm_perm.uid = port_stat.st_uid;
+		shm_stat.shm_perm.gid = port_stat.st_gid;
+		shmctl(arcam_av_state_shm_id, IPC_SET, &shm_stat);
+	}
+
+	state = shmat(arcam_av_state_shm_id, NULL, 0);
+
+	return (state == (void*)-1) ? NULL : state;
+}
+
+
+int arcam_av_state_detach(arcam_av_state_t* state)
+{
+	struct shmid_ds shm_stat;
+
+	if (shmdt(state))
+		return -1;
+
+	if (shmctl(arcam_av_state_shm_id, IPC_STAT, &shm_stat))
+		return -1;
+
+	if (!shm_stat.shm_nattch) {
+		shmctl(arcam_av_state_shm_id, IPC_RMID, NULL);
+		arcam_av_state_shm_id = -1;
+	}
+
+	return 0;
+}
+
+
+static void arcam_av_server_broadcast(fd_set* fds, int fd_max, void* buffer, int bytes)
+{
+	int fd;
+	for (fd = 0; fd <= fd_max; ++fd) {
+		if (FD_ISSET(fd, fds)) {
+			send(fd, buffer, bytes, 0);
+		}
+	}
+}
+
+
+static int arcam_av_server_master(int server_fd)
+{
+	struct sockaddr_un server_address;
+	socklen_t server_address_length;
+	const char* port;
+	int arcam_fd;
+	arcam_av_state_t* state;
+	fd_set all_fds, client_fds, read_fds;
+	int fd, fd_max;
+
+	int result = 0;
+
+	server_address_length = sizeof(server_address) - 1;
+	if (getsockname(server_fd, (struct sockaddr*) &server_address, &server_address_length))
+		return -errno;
+
+	server_address.sun_path[server_address_length - offsetof(struct sockaddr_un, sun_path)] = '\0';
+
+	port = server_address.sun_path + 1;
+
+	arcam_fd = arcam_av_connect(port);
+
+	state = arcam_av_state_attach(port);
+	if (!state) {
+		close(arcam_fd);
+		return -errno;
+	}
+
+	arcam_av_state_query(arcam_fd);
+
+	fcntl(arcam_fd, F_SETFL, O_NONBLOCK);
+
+	FD_ZERO(&all_fds);
+	FD_ZERO(&client_fds);
+	FD_SET(arcam_fd, &all_fds);
+	FD_SET(server_fd, &all_fds);
+	fd_max = MAX(arcam_fd, server_fd);
+
+	for(;;) {
+		read_fds = all_fds;
+
+		if (select(fd_max + 1, &read_fds, NULL, NULL, NULL) < 0) {
+			perror("arcam_av_server_master(): select");
+			result = -errno;
+			break;
+		}
+
+		for(fd = fd_max; fd; --fd) {
+			if (FD_ISSET(fd, &read_fds)) {
+				if (fd == arcam_fd) {
+					if (arcam_av_update(state, arcam_fd))
+						continue;
+
+					arcam_av_server_broadcast(&client_fds, fd_max, "", 1);
+				} else if (fd == server_fd) {
+					struct sockaddr_un client_address;
+					socklen_t client_address_length = sizeof(client_address);
+					int client_fd = accept(server_fd, (struct sockaddr*) &client_address, &client_address_length);
+
+					if (client_fd >= 0) {
+						FD_SET(client_fd, &all_fds);
+						FD_SET(client_fd, &client_fds);
+						fd_max = MAX(fd_max, client_fd);
+					} else {
+						perror("arcam_av_server_master(): accept");
+						result = -errno;
+						goto exit;
+					}
+				} else {
+					pthread_t thread;
+					int bytes = recv(fd, &thread, sizeof(pthread_t), 0);
+
+					if (bytes > 0) {
+						if (bytes == sizeof(pthread_t)) {
+							if (thread == pthread_self())
+								goto exit;
+
+							arcam_av_server_broadcast(&client_fds, fd_max, &thread, sizeof(pthread_t));
+						}
+					} else {
+						close(fd);
+						FD_CLR(fd, &all_fds);
+						FD_CLR(fd, &client_fds);
+						fd_max -= (fd_max == fd);
+					}
+				}
+			}
+		}
+	}
+
+exit:
+
+	for (fd = 0; fd <= fd_max; ++fd) {
+		if (fd != server_fd && FD_ISSET(fd, &all_fds)) {
+			close(fd);
+		}
+	}
+
+	if (state)
+		arcam_av_state_detach(state);
+
+	return result;
+}
+
+
+static int arcam_av_server_slave(int server_fd)
+{
+	for (;;) {
+		pthread_t thread;
+		int bytes = recv(server_fd, &thread, sizeof(pthread_t), 0);
+
+		if (bytes > 0) {
+			if (bytes == sizeof(pthread_t))
+				if (thread == pthread_self())
+					return 0;
+		} else {
+			break;
+		}
+	}
+
+	return -1;
+}
+
+
+static void* arcam_av_server_thread(void* context)
+{
+	struct sockaddr_un address;
+	int size;
+	int quit = 0;
+
+	sem_t* semaphore = context;
+	const char* port = *(const char**)(semaphore + 1);
+
+	address.sun_family = AF_FILE;
+	address.sun_path[0] = '\0';
+	strncpy(&address.sun_path[1], port, sizeof(address.sun_path) - 1);
+	size = offsetof(struct sockaddr_un, sun_path) +
+	       MIN(strlen(port) + 1, sizeof(address.sun_path));
+
+	signal(SIGPIPE, SIG_IGN);
+
+	while (!quit) {
+		int server_fd = socket(PF_UNIX, SOCK_STREAM, 0);
+		if (server_fd < 0) {
+			perror("arcam_av_server_thread(): socket");
+			break;
+		}
+
+		if (!bind(server_fd, (struct sockaddr*) &address, size)) {
+			if (!listen(server_fd, 10)) {
+				if (semaphore) {
+					sem_post(semaphore);
+					semaphore = NULL;
+				}
+				arcam_av_server_master(server_fd);
+			} else {
+				perror("arcam_av_server_master(): listen");
+			}
+			quit = 1;
+		} else if (errno != EADDRINUSE) {
+			perror("arcam_av_server_thread(): bind");
+			quit = 1;
+		} else if (!connect(server_fd, (struct sockaddr*) &address, size)) {
+			if (semaphore) {
+				sem_post(semaphore);
+				semaphore = NULL;
+			}
+			quit = !arcam_av_server_slave(server_fd);
+		} else {
+			perror("arcam_av_server_thread(): connect");
+			quit = 1;
+		}
+
+		close(server_fd);
+	}
+
+	if (semaphore)
+		sem_post(semaphore);
+
+	return NULL;
+}
+
+
+int arcam_av_server_start(pthread_t* thread, const char* port)
+{
+	struct {
+		sem_t		semaphore;
+		const char*	port;
+	} context;
+
+	int result = 0;
+
+	if (sem_init(&context.semaphore, 0, 0))
+		return -1;
+
+	context.port = port;
+
+	if (pthread_create(thread, NULL, arcam_av_server_thread, &context))
+		result = -1;
+	else
+		sem_wait(&context.semaphore);
+
+	sem_destroy(&context.semaphore);
+
+	return result;
+}
+
+
+int arcam_av_server_stop(pthread_t thread, const char* port)
+{
+	int client_fd = arcam_av_client(port);
+	if (client_fd < 0)
+		return -1;
+
+	if (send(client_fd, &thread, sizeof(pthread_t), 0) > 0)
+		pthread_join(thread, NULL);
+
+	close(client_fd);
+	return 0;
+}
+
+
+int arcam_av_client(const char* port)
+{
+	struct sockaddr_un address;
+	int size;
+
+	const int max_retries = 5;
+	int retries = max_retries;
+
+	int client_fd = socket(PF_UNIX, SOCK_STREAM, 0);
+	if (client_fd < 0)
+		return -1;
+
+	address.sun_family = AF_FILE;
+	address.sun_path[0] = '\0';
+	strncpy(&address.sun_path[1], port, sizeof(address.sun_path) - 1);
+	size = offsetof(struct sockaddr_un, sun_path) +
+	       MIN(strlen(port) + 1, sizeof(address.sun_path));
+
+	do {
+		if (!connect(client_fd, (struct sockaddr*) &address, size))
+			return client_fd;
+
+		if (!retries--)
+			break;
+
+		struct timeval sleep = {0, 10 * (max_retries - retries)};
+		
+		select(0, NULL, NULL, NULL, &sleep);
+
+	} while (errno == ECONNREFUSED);
+
+	perror("arcam_av_client(): connect");
+
+	close(client_fd);
+	return -1;
+}
+
diff -Nrup alsa-plugins-1.0.18-orig/arcam-av/arcam_av.h alsa-plugins-1.0.18/arcam-av/arcam_av.h
--- alsa-plugins-1.0.18-orig/arcam-av/arcam_av.h	1970-01-01 01:00:00.000000000 +0100
+++ alsa-plugins-1.0.18/arcam-av/arcam_av.h	2009-01-04 20:09:08.000000000 +0000
@@ -0,0 +1,161 @@
+/*
+ * ALSA -> Arcam AV control plugin
+ *
+ * Copyright (c) 2009 by Peter Stokes <linux@dadeos.co.uk>
+ *
+ * This library is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU Lesser General Public License as
+ * published by the Free Software Foundation; either version 2.1 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <pthread.h>
+
+typedef enum {
+	ARCAM_AV_ZONE1				= '1',
+	ARCAM_AV_ZONE2				= '2'
+} arcam_av_zone_t;
+
+
+typedef enum {
+	ARCAM_AV_POWER				= '*',
+	ARCAM_AV_VOLUME_CHANGE			= '/',
+	ARCAM_AV_VOLUME_SET			= '0',
+	ARCAM_AV_MUTE				= '.',
+	ARCAM_AV_SOURCE				= '1',
+	ARCAM_AV_SOURCE_TYPE			= '7',
+	ARCAM_AV_DIRECT				= '3',
+	ARCAM_AV_STEREO_DECODE			= '4',
+	ARCAM_AV_MULTI_DECODE			= '5',
+	ARCAM_AV_STEREO_EFFECT			= '6'
+} arcam_av_cc_t;
+
+
+typedef enum {
+	ARCAM_AV_OK				= 'P',
+	ARCAM_AV_ERROR				= 'R'
+} arcam_av_rc_t;
+
+
+typedef enum {
+	ARCAM_AV_POWER_STAND_BY			= '0',
+	ARCAM_AV_POWER_ON			= '1',
+	ARCAM_AV_POWER_REQUEST			= '9'
+} arcam_av_power_t;
+
+
+typedef enum {
+	ARCAM_AV_VOLUME_MIN			= '0',
+	ARCAM_AV_VOLUME_REQUEST			= '9'
+} arcam_av_volume_t;
+
+
+typedef enum {
+	ARCAM_AV_MUTE_ON			= '0',
+	ARCAM_AV_MUTE_OFF			= '1',
+	ARCAM_AV_MUTE_REQUEST			= '9'
+} arcam_av_mute_t;
+
+
+typedef enum {
+	ARCAM_AV_DIRECT_DISABLE			= '0',
+	ARCAM_AV_DIRECT_ENABLE			= '1',
+	ARCAM_AV_DIRECT_REQUEST			= '9'
+} arcam_av_direct_t;
+
+
+typedef enum {
+	ARCAM_AV_SOURCE_DVD 			= '0',
+	ARCAM_AV_SOURCE_SAT			= '1',
+	ARCAM_AV_SOURCE_AV			= '2',
+	ARCAM_AV_SOURCE_PVR			= '3',
+	ARCAM_AV_SOURCE_VCR			= '4',
+	ARCAM_AV_SOURCE_CD			= '5',
+	ARCAM_AV_SOURCE_FM			= '6',
+	ARCAM_AV_SOURCE_AM			= '7',
+	ARCAM_AV_SOURCE_DVDA			= '8',
+	ARCAM_AV_SOURCE_REQUEST			= '9'
+} arcam_av_source_t;
+
+
+typedef enum {
+	ARCAM_AV_SOURCE_TYPE_ANALOGUE 		= '0',
+	ARCAM_AV_SOURCE_TYPE_DIGITAL		= '1',
+	ARCAM_AV_SOURCE_TYPE_REQUEST		= '9'
+} arcam_av_source_type_t;
+
+
+typedef enum {
+	ARCAM_AV_STEREO_DECODE_MONO		= '.',
+	ARCAM_AV_STEREO_DECODE_STEREO		= '/',
+	ARCAM_AV_STEREO_DECODE_PLII_MOVIE	= '0',
+	ARCAM_AV_STEREO_DECODE_PLII_MUSIC	= '1',
+	ARCAM_AV_STEREO_DECODE_PLIIx_MOVIE	= '3',
+	ARCAM_AV_STEREO_DECODE_PLIIx_MUSIC	= '4',
+	ARCAM_AV_STEREO_DECODE_DOLBY_PL		= '6',
+	ARCAM_AV_STEREO_DECODE_NEO6_CINEMA	= '7',
+	ARCAM_AV_STEREO_DECODE_NEO6_MUSIC	= '8',
+	ARCAM_AV_STEREO_DECODE_REQUEST		= '9'
+} arcam_av_stereo_decode_t;
+
+
+typedef enum {
+	ARCAM_AV_MULTI_DECODE_MONO		= '.',
+	ARCAM_AV_MULTI_DECODE_STEREO		= '/',
+	ARCAM_AV_MULTI_DECODE_MULTI_CHANNEL	= '0',
+	ARCAM_AV_MULTI_DECODE_PLIIx		= '2',
+	ARCAM_AV_MULTI_DECODE_REQUEST		= '9'
+} arcam_av_multi_decode_t;
+
+
+typedef enum {
+	ARCAM_AV_STEREO_EFFECT_NONE		= '0',
+	ARCAM_AV_STEREO_EFFECT_MUSIC		= '1',
+	ARCAM_AV_STEREO_EFFECT_PARTY		= '2',
+	ARCAM_AV_STEREO_EFFECT_CLUB		= '3',
+	ARCAM_AV_STEREO_EFFECT_HALL		= '4',
+	ARCAM_AV_STEREO_EFFECT_SPORTS		= '5',
+	ARCAM_AV_STEREO_EFFECT_CHURCH		= '6',
+	ARCAM_AV_STEREO_EFFECT_REQUEST		= '9'
+} arcam_av_stereo_effect_t;
+
+int arcam_av_connect(const char* port);
+int arcam_av_send(int fd, arcam_av_cc_t command, unsigned char param1, unsigned char param2);
+
+
+typedef struct arcam_av_state {
+	struct {
+		arcam_av_power_t		power;
+		unsigned char			volume;
+		arcam_av_mute_t			mute;
+		arcam_av_direct_t		direct;
+		arcam_av_source_t		source;
+		arcam_av_source_type_t		source_type;
+		arcam_av_stereo_decode_t	stereo_decode;
+		arcam_av_stereo_effect_t	stereo_effect;
+		arcam_av_multi_decode_t		multi_decode;
+	} zone1;
+	struct {
+		arcam_av_power_t		power;
+		unsigned char			volume;
+		arcam_av_mute_t			mute;
+		arcam_av_source_t		source;
+	} zone2;
+} arcam_av_state_t;
+
+arcam_av_state_t* arcam_av_state_attach(const char* port);
+int arcam_av_state_detach(arcam_av_state_t* state);
+
+int arcam_av_server_start(pthread_t* thread, const char* port);
+int arcam_av_server_stop(pthread_t thread, const char* port);
+
+int arcam_av_client(const char* port);
diff -Nrup alsa-plugins-1.0.18-orig/arcam-av/ctl_arcam_av.c alsa-plugins-1.0.18/arcam-av/ctl_arcam_av.c
--- alsa-plugins-1.0.18-orig/arcam-av/ctl_arcam_av.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-plugins-1.0.18/arcam-av/ctl_arcam_av.c	2009-01-04 20:09:06.000000000 +0000
@@ -0,0 +1,1024 @@
+/*
+ * ALSA -> Arcam AV control plugin
+ *
+ * Copyright (c) 2009 by Peter Stokes <linux@dadeos.co.uk>
+ *
+ * This library is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU Lesser General Public License as
+ * published by the Free Software Foundation; either version 2.1 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <sys/socket.h>
+#include <alsa/asoundlib.h>
+#include <alsa/control_external.h>
+
+#include "arcam_av.h"
+
+
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
+#define MIN(a, b)     ((a) < (b) ? (a) : (b))
+#define MID(a, b, c)  ((a) < (b) ? ((b) < (c) ? (b) : ((a) < (c) ? (c) : (a))) \
+                                 : ((b) > (c) ? (b) : ((a) > (c) ? (c) : (a))))
+
+
+static const char* arcam_av_name		= "Arcam AV";
+static const char* arcam_av_power_name		= "Power Switch";
+static const char* arcam_av_volume_name		= "Master Playback Volume";
+static const char* arcam_av_mute_name		= "Master Playback Switch";
+static const char* arcam_av_direct_name		= "Direct Playback Switch";
+static const char* arcam_av_source_name		= "Source Playback Route";
+static const char* arcam_av_source_type_name	= "Source Type Playback Route";
+static const char* arcam_av_stereo_decode_name	= "Stereo Decode Playback Route";
+static const char* arcam_av_multi_decode_name	= "Multi-Channel Decode Playback Route";
+static const char* arcam_av_stereo_effect_name	= "Stereo Effect Playback Route";
+
+static const struct {
+	arcam_av_source_t		code;
+	const char*			name;
+} arcam_av_sources[] = {
+	{ARCAM_AV_SOURCE_DVD,			"DVD"			},
+	{ARCAM_AV_SOURCE_SAT,			"SAT"			},
+	{ARCAM_AV_SOURCE_AV,			"AV"			},
+	{ARCAM_AV_SOURCE_PVR,			"PVR"			},
+	{ARCAM_AV_SOURCE_VCR,			"VCR"			},
+	{ARCAM_AV_SOURCE_CD,			"CD"			},
+	{ARCAM_AV_SOURCE_FM,			"FM"			},
+	{ARCAM_AV_SOURCE_AM,			"AM"			},
+	{ARCAM_AV_SOURCE_DVDA,			"DVDA"			}
+};
+
+static const struct {
+	arcam_av_source_type_t		code;
+	const char*			name;
+} arcam_av_source_types[] = {
+	{ARCAM_AV_SOURCE_TYPE_ANALOGUE,		"Analogue"		},
+	{ARCAM_AV_SOURCE_TYPE_DIGITAL,		"Digital"		}
+};
+
+static const struct {
+	arcam_av_direct_t		code;
+	const char*			name;
+} arcam_av_direct[] = {
+	{ARCAM_AV_DIRECT_DISABLE,		"Disable"		},
+	{ARCAM_AV_DIRECT_ENABLE,		"Enable"		}
+};
+
+static const struct {
+	arcam_av_stereo_decode_t	code;
+	const char*			name;
+} arcam_av_stereo_decode_modes[] = {
+	{ARCAM_AV_STEREO_DECODE_MONO,		"Mono"			},
+	{ARCAM_AV_STEREO_DECODE_STEREO,		"Stereo"		},
+	{ARCAM_AV_STEREO_DECODE_PLII_MOVIE,	"Pro Logic II Movie"	},
+	{ARCAM_AV_STEREO_DECODE_PLII_MUSIC,	"Pro Logic II Music"	},
+	{ARCAM_AV_STEREO_DECODE_PLIIx_MOVIE,	"Pro Logic IIx Movie"	},
+	{ARCAM_AV_STEREO_DECODE_PLIIx_MUSIC,	"Pro Logic IIx Music"	},
+	{ARCAM_AV_STEREO_DECODE_DOLBY_PL,	"Dolby Pro Logic"	},
+	{ARCAM_AV_STEREO_DECODE_NEO6_CINEMA,	"Neo:6 Cinema"		},
+	{ARCAM_AV_STEREO_DECODE_NEO6_MUSIC,	"Neo:6 Music"		}
+};
+
+static const struct {
+	arcam_av_multi_decode_t		code;
+	const char*			name;
+} arcam_av_multi_decode_modes[] = {
+	{ARCAM_AV_MULTI_DECODE_MONO,		"Mono down-mix"		},
+	{ARCAM_AV_MULTI_DECODE_STEREO,		"Stereo down-mix"	},
+	{ARCAM_AV_MULTI_DECODE_MULTI_CHANNEL,	"Multi-channel"		},
+	{ARCAM_AV_MULTI_DECODE_PLIIx,		"Pro Logic IIx"		}
+};
+
+static const struct {
+	arcam_av_stereo_effect_t	code;
+	const char*			name;
+} arcam_av_stereo_effects[] = {
+	{ARCAM_AV_STEREO_EFFECT_NONE,		"None"			},
+	{ARCAM_AV_STEREO_EFFECT_MUSIC,		"Music"			},
+	{ARCAM_AV_STEREO_EFFECT_PARTY,		"Party"			},
+	{ARCAM_AV_STEREO_EFFECT_CLUB,		"Club"			},
+	{ARCAM_AV_STEREO_EFFECT_HALL,		"Hall"			},
+	{ARCAM_AV_STEREO_EFFECT_SPORTS,		"Sports"		},
+	{ARCAM_AV_STEREO_EFFECT_CHURCH,		"Church"		}
+};
+
+
+typedef struct snd_ctl_arcam_av {
+	snd_ctl_ext_t		ext;
+	int			port_fd;
+	int			shm_id;
+	const char*		port;
+	arcam_av_zone_t		zone;
+	arcam_av_state_t	local;
+	arcam_av_state_t*	global;
+	pthread_t		server;
+} snd_ctl_arcam_av_t;
+
+static void arcam_av_close(snd_ctl_ext_t *ext)
+{
+	snd_ctl_arcam_av_t *arcam_av = ext->private_data;
+
+	if (arcam_av->port_fd >= 0)
+		close(arcam_av->port_fd);
+
+	if (arcam_av->global)
+		arcam_av_state_detach(arcam_av->global);
+
+	if (arcam_av->ext.poll_fd >= 0) {
+		close(arcam_av->ext.poll_fd);
+		arcam_av_server_stop(arcam_av->server, arcam_av->port);
+	}
+
+	free(arcam_av);
+}
+
+static int arcam_av_elem_count(snd_ctl_ext_t *ext)
+{
+	snd_ctl_arcam_av_t *arcam_av = ext->private_data;
+
+	return arcam_av->zone == ARCAM_AV_ZONE1 ? 9 : 4;
+}
+
+static int arcam_av_elem_list(snd_ctl_ext_t *ext, unsigned int offset, snd_ctl_elem_id_t *id)
+{
+	snd_ctl_arcam_av_t *arcam_av = ext->private_data;
+
+	snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
+	
+	if (arcam_av->zone == ARCAM_AV_ZONE1) {
+		switch(offset) {
+		case 0:
+			snd_ctl_elem_id_set_name(id, arcam_av_power_name);
+			break;
+
+		case 1:
+			snd_ctl_elem_id_set_name(id, arcam_av_volume_name);
+			break;
+
+		case 2:
+			snd_ctl_elem_id_set_name(id, arcam_av_mute_name);
+			break;
+
+		case 3:
+			snd_ctl_elem_id_set_name(id, arcam_av_direct_name);
+			break;
+
+		case 4:
+			snd_ctl_elem_id_set_name(id, arcam_av_source_name);
+			break;
+
+		case 5:
+			snd_ctl_elem_id_set_name(id, arcam_av_source_type_name);
+			break;
+
+		case 6:
+			snd_ctl_elem_id_set_name(id, arcam_av_stereo_decode_name);
+			break;
+
+		case 7:
+			snd_ctl_elem_id_set_name(id, arcam_av_multi_decode_name);
+			break;
+
+		case 8:
+			snd_ctl_elem_id_set_name(id, arcam_av_stereo_effect_name);
+			break;
+		}
+	} else {
+		switch(offset) {
+		case 0:
+			snd_ctl_elem_id_set_name(id, arcam_av_power_name);
+			break;
+
+		case 1:
+			snd_ctl_elem_id_set_name(id, arcam_av_volume_name);
+			break;
+
+		case 2:
+			snd_ctl_elem_id_set_name(id, arcam_av_mute_name);
+			break;
+
+		case 3:
+			snd_ctl_elem_id_set_name(id, arcam_av_source_name);
+			break;
+		}	
+	}
+
+	return 0;
+}
+
+static snd_ctl_ext_key_t arcam_av_find_elem(snd_ctl_ext_t *ext ATTRIBUTE_UNUSED,
+					    const snd_ctl_elem_id_t *id)
+{
+	const char *name;
+
+	name = snd_ctl_elem_id_get_name(id);
+	if (!strcmp(name, arcam_av_power_name)) {
+		return ARCAM_AV_POWER;
+	} else if (!strcmp(name, arcam_av_volume_name)) {
+		return ARCAM_AV_VOLUME_SET;
+	} else if (!strcmp(name, arcam_av_mute_name)) {
+		return ARCAM_AV_MUTE;
+	} else if (!strcmp(name, arcam_av_direct_name)) {
+		return ARCAM_AV_DIRECT;
+	} else if (!strcmp(name, arcam_av_source_name)) {
+		return ARCAM_AV_SOURCE;
+	} else if (!strcmp(name, arcam_av_source_type_name)) {
+		return ARCAM_AV_SOURCE_TYPE;
+	} else if (!strcmp(name, arcam_av_stereo_decode_name)) {
+		return ARCAM_AV_STEREO_DECODE;
+	} else if (!strcmp(name, arcam_av_multi_decode_name)) {
+		return ARCAM_AV_MULTI_DECODE;
+	} else if (!strcmp(name, arcam_av_stereo_effect_name)) {
+		return ARCAM_AV_STEREO_EFFECT;
+	}
+
+	return SND_CTL_EXT_KEY_NOT_FOUND;
+}
+
+static int arcam_av_get_attribute(snd_ctl_ext_t *ext ATTRIBUTE_UNUSED,
+				  snd_ctl_ext_key_t key, int *type,
+				  unsigned int *acc, unsigned int *count)
+{
+	switch(key) {
+	case ARCAM_AV_POWER:
+		*type = SND_CTL_ELEM_TYPE_BOOLEAN;
+		*acc = SND_CTL_EXT_ACCESS_READWRITE;
+		*count = 1;
+		break;
+
+	case ARCAM_AV_VOLUME_SET:
+		*type = SND_CTL_ELEM_TYPE_INTEGER;
+		*acc = SND_CTL_EXT_ACCESS_READWRITE;
+		*count = 1;
+		break;
+
+	case ARCAM_AV_MUTE:
+		*type = SND_CTL_ELEM_TYPE_BOOLEAN;
+		*acc = SND_CTL_EXT_ACCESS_READWRITE;
+		*count = 1;
+		break;
+
+	case ARCAM_AV_DIRECT:
+		*type = SND_CTL_ELEM_TYPE_ENUMERATED;
+		*acc = SND_CTL_EXT_ACCESS_READWRITE;
+		*count = 1;
+		break;
+
+	case ARCAM_AV_SOURCE:
+		*type = SND_CTL_ELEM_TYPE_ENUMERATED;
+		*acc = SND_CTL_EXT_ACCESS_READWRITE;
+		*count = 1;
+		break;
+
+	case ARCAM_AV_SOURCE_TYPE:
+		*type = SND_CTL_ELEM_TYPE_ENUMERATED;
+		*acc = SND_CTL_EXT_ACCESS_READWRITE;
+		*count = 1;
+		break;
+
+	case ARCAM_AV_STEREO_DECODE:
+		*type = SND_CTL_ELEM_TYPE_ENUMERATED;
+		*acc = SND_CTL_EXT_ACCESS_READWRITE;
+		*count = 1;
+		break;
+
+	case ARCAM_AV_MULTI_DECODE:
+		*type = SND_CTL_ELEM_TYPE_ENUMERATED;
+		*acc = SND_CTL_EXT_ACCESS_READWRITE;
+		*count = 1;
+		break;
+
+	case ARCAM_AV_STEREO_EFFECT:
+		*type = SND_CTL_ELEM_TYPE_ENUMERATED;
+		*acc = SND_CTL_EXT_ACCESS_READWRITE;
+		*count = 1;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int arcam_av_get_integer_info(snd_ctl_ext_t *ext,
+				     snd_ctl_ext_key_t key,
+				     long *imin, long *imax, long *istep)
+{
+	snd_ctl_arcam_av_t *arcam_av = ext->private_data;
+
+	switch(key) {
+	case ARCAM_AV_VOLUME_SET:
+		*istep = 1;
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			*imin = 0;
+			*imax = 100;
+			break;
+
+		case ARCAM_AV_ZONE2:
+			*imin = 20;
+			*imax = 83;
+			break;
+		}
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int arcam_av_get_enumerated_info(snd_ctl_ext_t *ext ATTRIBUTE_UNUSED,
+					snd_ctl_ext_key_t key,
+					unsigned int *items)
+{
+	switch(key) {
+	case ARCAM_AV_SOURCE:
+		*items = ARRAY_SIZE(arcam_av_sources);
+		break;
+
+	case ARCAM_AV_SOURCE_TYPE:
+		*items = ARRAY_SIZE(arcam_av_source_types);
+		break;
+
+	case ARCAM_AV_DIRECT:
+		*items = ARRAY_SIZE(arcam_av_direct);
+		break;
+
+	case ARCAM_AV_STEREO_DECODE:
+		*items = ARRAY_SIZE(arcam_av_stereo_decode_modes);
+		break;
+
+	case ARCAM_AV_MULTI_DECODE:
+		*items = ARRAY_SIZE(arcam_av_multi_decode_modes);
+		break;
+
+	case ARCAM_AV_STEREO_EFFECT:
+		*items = ARRAY_SIZE(arcam_av_stereo_effects);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int arcam_av_get_enumerated_name(snd_ctl_ext_t *ext ATTRIBUTE_UNUSED,
+					snd_ctl_ext_key_t key,
+					unsigned int item, char *name,
+					size_t name_max_len)
+{
+	const char* label;
+
+	switch(key) {
+	case ARCAM_AV_SOURCE:
+		if (item >= ARRAY_SIZE(arcam_av_sources))
+			return -EINVAL;
+
+		label = arcam_av_sources[item].name;
+		break;
+
+	case ARCAM_AV_SOURCE_TYPE:
+		if (item >= ARRAY_SIZE(arcam_av_source_types))
+			return -EINVAL;
+
+		label = arcam_av_source_types[item].name;
+		break;
+
+	case ARCAM_AV_DIRECT:
+		if (item >= ARRAY_SIZE(arcam_av_direct))
+			return -EINVAL;
+
+		label = arcam_av_direct[item].name;
+		break;
+
+	case ARCAM_AV_STEREO_DECODE:
+		if (item >= ARRAY_SIZE(arcam_av_stereo_decode_modes))
+			return -EINVAL;
+
+		label = arcam_av_stereo_decode_modes[item].name;
+		break;
+
+	case ARCAM_AV_MULTI_DECODE:
+		if (item >= ARRAY_SIZE(arcam_av_multi_decode_modes))
+			return -EINVAL;
+
+		label = arcam_av_multi_decode_modes[item].name;
+		break;
+
+	case ARCAM_AV_STEREO_EFFECT:
+		if (item >= ARRAY_SIZE(arcam_av_stereo_effects))
+			return -EINVAL;
+
+		label = arcam_av_stereo_effects[item].name;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	strncpy(name, label, name_max_len - 1);
+	name[name_max_len - 1] = '\0';
+
+	return 0;
+}
+
+static int arcam_av_read_integer(snd_ctl_ext_t *ext, snd_ctl_ext_key_t key, long *value)
+{
+	snd_ctl_arcam_av_t *arcam_av = ext->private_data;
+
+	switch(key) {
+	case ARCAM_AV_POWER:
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.power = arcam_av->global->zone1.power;
+			*value = !(arcam_av->local.zone1.power == ARCAM_AV_POWER_STAND_BY);
+			break;
+
+		case ARCAM_AV_ZONE2:
+			arcam_av->local.zone2.power = arcam_av->global->zone2.power;
+			*value = !(arcam_av->local.zone2.power == ARCAM_AV_POWER_STAND_BY);
+			break;
+		}
+		break;
+
+	case ARCAM_AV_VOLUME_SET:
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.volume = arcam_av->global->zone1.volume;
+			*value = MID(0, arcam_av->local.zone1.volume - ARCAM_AV_VOLUME_MIN, 100);
+			break;
+
+		case ARCAM_AV_ZONE2:
+			arcam_av->local.zone2.volume = arcam_av->global->zone2.volume;
+			*value = MID(20, arcam_av->local.zone2.volume - ARCAM_AV_VOLUME_MIN, 83);
+			break;
+		}
+		break;
+
+	case ARCAM_AV_MUTE:
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.mute = arcam_av->global->zone1.mute;
+			*value = !(arcam_av->local.zone1.mute == ARCAM_AV_MUTE_ON);
+			break;
+
+		case ARCAM_AV_ZONE2:
+			arcam_av->local.zone2.mute = arcam_av->global->zone2.mute;
+			*value = !(arcam_av->local.zone2.mute == ARCAM_AV_MUTE_ON);
+			break;
+		}
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int arcam_av_read_enumerated(snd_ctl_ext_t *ext,
+				    snd_ctl_ext_key_t key,
+				    unsigned int *item)
+{
+	snd_ctl_arcam_av_t *arcam_av = ext->private_data;
+	unsigned int i;
+
+	switch(key) {
+	case ARCAM_AV_SOURCE:
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.source = arcam_av->global->zone1.source;
+			for (i = 0; i < ARRAY_SIZE(arcam_av_sources); ++i) {
+				if (arcam_av_sources[i].code == arcam_av->local.zone1.source) {
+					*item = i;
+					break;
+				}
+			}
+			break;
+
+		case ARCAM_AV_ZONE2:
+			arcam_av->local.zone2.source = arcam_av->global->zone2.source;
+			for (i = 0; i < ARRAY_SIZE(arcam_av_sources); ++i) {
+				if (arcam_av_sources[i].code == arcam_av->local.zone2.source) {
+					*item = i;
+					break;
+				}
+			}
+			break;
+		}
+		break;
+
+	case ARCAM_AV_SOURCE_TYPE:
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.source_type = arcam_av->global->zone1.source_type;
+			for (i = 0; i < ARRAY_SIZE(arcam_av_source_types); ++i) {
+				if (arcam_av_source_types[i].code == arcam_av->local.zone1.source_type) {
+					*item = i;
+					break;
+				}
+			}
+			break;
+
+		case ARCAM_AV_ZONE2:
+			return -EINVAL;
+		}
+		break;
+
+	case ARCAM_AV_DIRECT:
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.direct = arcam_av->global->zone1.direct;
+			for (i = 0; i < ARRAY_SIZE(arcam_av_direct); ++i) {
+				if (arcam_av_direct[i].code == arcam_av->local.zone1.direct) {
+					*item = i;
+					break;
+				}
+			}
+			break;
+
+		case ARCAM_AV_ZONE2:
+			return -EINVAL;
+		}
+		break;
+
+	case ARCAM_AV_STEREO_DECODE:
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.stereo_decode = arcam_av->global->zone1.stereo_decode;
+			for (i = 0; i < ARRAY_SIZE(arcam_av_stereo_decode_modes); ++i) {
+				if (arcam_av_stereo_decode_modes[i].code == arcam_av->local.zone1.stereo_decode) {
+					*item = i;
+					break;
+				}
+			}
+			break;
+
+		case ARCAM_AV_ZONE2:
+			return -EINVAL;
+		}
+		break;
+
+	case ARCAM_AV_STEREO_EFFECT:
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.stereo_effect = arcam_av->global->zone1.stereo_effect;
+			for (i = 0; i < ARRAY_SIZE(arcam_av_stereo_effects); ++i) {
+				if (arcam_av_stereo_effects[i].code == arcam_av->local.zone1.stereo_effect) {
+					*item = i;
+					break;
+				}
+			}
+			break;
+
+		case ARCAM_AV_ZONE2:
+			return -EINVAL;
+		}
+		break;
+
+	case ARCAM_AV_MULTI_DECODE:
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.multi_decode = arcam_av->global->zone1.multi_decode;
+			for (i = 0; i < ARRAY_SIZE(arcam_av_multi_decode_modes); ++i) {
+				if (arcam_av_multi_decode_modes[i].code == arcam_av->local.zone1.multi_decode) {
+					*item = i;
+					break;
+				}
+			}
+			break;
+
+		case ARCAM_AV_ZONE2:
+			return -EINVAL;
+		}
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int arcam_av_write_integer(snd_ctl_ext_t *ext, snd_ctl_ext_key_t key, long *value)
+{
+	snd_ctl_arcam_av_t *arcam_av = ext->private_data;
+	unsigned char volume = ARCAM_AV_VOLUME_MIN;
+
+	switch(key) {
+	case ARCAM_AV_POWER:
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.power = ARCAM_AV_POWER_STAND_BY + *value;
+			if (arcam_av->global->zone1.power == arcam_av->local.zone1.power)
+				return 0;
+			break;
+
+		case ARCAM_AV_ZONE2:
+			arcam_av->local.zone2.power = ARCAM_AV_POWER_STAND_BY + *value;
+			if (arcam_av->global->zone2.power == arcam_av->local.zone2.power)
+				return 0;
+			break;
+		}
+		break;
+
+	case ARCAM_AV_VOLUME_SET:
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.volume = ARCAM_AV_VOLUME_MIN + *value;
+			if (arcam_av->global->zone1.volume == arcam_av->local.zone1.volume)
+				return 0;
+
+			if (arcam_av->global->zone1.mute == ARCAM_AV_MUTE_ON) {
+				arcam_av->global->zone1.volume = arcam_av->local.zone1.volume;
+				return 1;
+			}
+			break;
+
+		case ARCAM_AV_ZONE2:
+			arcam_av->local.zone2.volume = ARCAM_AV_VOLUME_MIN + *value;
+			if (arcam_av->global->zone2.volume == arcam_av->local.zone2.volume)
+				return 0;
+
+			if (arcam_av->global->zone2.mute == ARCAM_AV_MUTE_ON) {
+				arcam_av->global->zone2.volume = arcam_av->local.zone2.volume;
+				return 1;
+			}
+			break;
+		}
+		break;
+
+	case ARCAM_AV_MUTE:
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.mute = ARCAM_AV_MUTE_ON + *value;
+			if (arcam_av->global->zone1.mute == arcam_av->local.zone1.mute)
+				return 0;
+
+			volume = arcam_av->global->zone1.volume;
+			break;
+
+		case ARCAM_AV_ZONE2:
+			arcam_av->local.zone2.mute = ARCAM_AV_MUTE_ON + *value;
+			if (arcam_av->global->zone2.mute == arcam_av->local.zone2.mute)
+				return 0;
+
+			volume = arcam_av->global->zone2.volume;
+			break;
+		}
+
+		if (*value)
+			arcam_av_send(arcam_av->port_fd, ARCAM_AV_VOLUME_SET, arcam_av->zone, volume);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (!arcam_av_send(arcam_av->port_fd, key, arcam_av->zone, '0' + *value))
+		return 1;
+	else
+		return -1;
+}
+
+static int arcam_av_write_enumerated(snd_ctl_ext_t *ext, snd_ctl_ext_key_t key, unsigned int *item)
+{
+	snd_ctl_arcam_av_t *arcam_av = ext->private_data;
+
+	char code;
+
+	switch(key) {
+	case ARCAM_AV_SOURCE:
+		if (*item >= ARRAY_SIZE(arcam_av_sources))
+			return -EINVAL;
+
+		code = arcam_av_sources[*item].code;
+
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.source = code;
+			if (arcam_av->global->zone1.source == code)
+				return 0;
+			break;
+
+		case ARCAM_AV_ZONE2:
+			arcam_av->local.zone2.source = code;
+			if (arcam_av->global->zone2.source == code)
+				return 0;
+			break;
+		}
+		break;
+
+	case ARCAM_AV_SOURCE_TYPE:
+		if (*item >= ARRAY_SIZE(arcam_av_source_types))
+			return -EINVAL;
+
+		code = arcam_av_source_types[*item].code;
+
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.source_type = code;
+			if (arcam_av->global->zone1.source_type == code)
+				return 0;
+			break;
+
+		case ARCAM_AV_ZONE2:
+			return -EINVAL;
+		}
+		break;
+
+	case ARCAM_AV_DIRECT:
+		if (*item >= ARRAY_SIZE(arcam_av_direct))
+			return -EINVAL;
+
+		code = arcam_av_direct[*item].code;
+
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.direct = code;
+			if (arcam_av->global->zone1.direct == code)
+				return 0;
+			break;
+
+		case ARCAM_AV_ZONE2:
+			return -EINVAL;
+		}
+		break;
+
+	case ARCAM_AV_STEREO_DECODE:
+		if (*item >= ARRAY_SIZE(arcam_av_stereo_decode_modes))
+			return -EINVAL;
+
+		code = arcam_av_stereo_decode_modes[*item].code;
+
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.stereo_decode = code;
+			if (arcam_av->global->zone1.stereo_decode == code)
+				return 0;
+			break;
+
+		case ARCAM_AV_ZONE2:
+			return -EINVAL;
+		}
+		break;
+
+	case ARCAM_AV_STEREO_EFFECT:
+		if (*item >= ARRAY_SIZE(arcam_av_stereo_effects))
+			return -EINVAL;
+
+		code = arcam_av_stereo_effects[*item].code;
+
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.stereo_effect = code;
+			if (arcam_av->global->zone1.stereo_effect == code)
+				return 0;
+			break;
+
+		case ARCAM_AV_ZONE2:
+			return -EINVAL;
+		}
+		break;
+
+	case ARCAM_AV_MULTI_DECODE:
+		if (*item >= ARRAY_SIZE(arcam_av_multi_decode_modes))
+			return -EINVAL;
+
+		code = arcam_av_multi_decode_modes[*item].code;
+
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			arcam_av->local.zone1.multi_decode = code;
+			if (arcam_av->global->zone1.multi_decode == code)
+				return 0;
+			break;
+
+		case ARCAM_AV_ZONE2:
+			return -EINVAL;
+		}
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (!arcam_av_send(arcam_av->port_fd, key, arcam_av->zone, code))
+		return 1;
+	else
+		return -1;
+}
+
+
+static int arcam_av_read_event(snd_ctl_ext_t *ext, snd_ctl_elem_id_t *id, unsigned int *event_mask)
+{
+	snd_ctl_arcam_av_t *arcam_av = ext->private_data;
+
+	switch(arcam_av->zone) {
+	case ARCAM_AV_ZONE1:
+		if (arcam_av->local.zone1.power != arcam_av->global->zone1.power) {
+			snd_ctl_elem_id_set_name(id, arcam_av_power_name);
+			arcam_av->local.zone1.power = arcam_av->global->zone1.power;
+		} else if (arcam_av->local.zone1.volume != arcam_av->global->zone1.volume) {
+			snd_ctl_elem_id_set_name(id, arcam_av_volume_name);
+			arcam_av->local.zone1.volume = arcam_av->global->zone1.volume;
+		} else if (arcam_av->local.zone1.mute != arcam_av->global->zone1.mute) {
+			snd_ctl_elem_id_set_name(id, arcam_av_mute_name);
+			arcam_av->local.zone1.mute = arcam_av->global->zone1.mute;
+		} else if (arcam_av->local.zone1.direct != arcam_av->global->zone1.direct) {
+			snd_ctl_elem_id_set_name(id, arcam_av_direct_name);
+			arcam_av->local.zone1.direct = arcam_av->global->zone1.direct;
+		} else if (arcam_av->local.zone1.source != arcam_av->global->zone1.source) {
+			snd_ctl_elem_id_set_name(id, arcam_av_source_name);
+			arcam_av->local.zone1.source = arcam_av->global->zone1.source;
+		} else if (arcam_av->local.zone1.source_type != arcam_av->global->zone1.source_type) {
+			snd_ctl_elem_id_set_name(id, arcam_av_source_type_name);
+			arcam_av->local.zone1.source_type = arcam_av->global->zone1.source_type;
+		} else if (arcam_av->local.zone1.stereo_decode != arcam_av->global->zone1.stereo_decode) {
+			snd_ctl_elem_id_set_name(id, arcam_av_stereo_decode_name);
+			arcam_av->local.zone1.stereo_decode = arcam_av->global->zone1.stereo_decode;
+		} else if (arcam_av->local.zone1.stereo_effect != arcam_av->global->zone1.stereo_effect) {
+			snd_ctl_elem_id_set_name(id, arcam_av_stereo_effect_name);
+			arcam_av->local.zone1.stereo_effect = arcam_av->global->zone1.stereo_effect;
+		} else if (arcam_av->local.zone1.multi_decode != arcam_av->global->zone1.multi_decode) {
+			snd_ctl_elem_id_set_name(id, arcam_av_multi_decode_name);
+			arcam_av->local.zone1.multi_decode = arcam_av->global->zone1.multi_decode;
+		} else {
+			char buf[10];
+			if (recv(arcam_av->ext.poll_fd, buf, sizeof(buf), 0) <= 0) {
+				close(arcam_av->ext.poll_fd);
+				arcam_av->ext.poll_fd = arcam_av_client(arcam_av->port);
+				if (arcam_av->ext.poll_fd > 0)
+					fcntl(arcam_av->ext.poll_fd, F_SETFL, O_NONBLOCK);
+			}
+
+			return -EAGAIN;
+		}
+		break;
+
+	case ARCAM_AV_ZONE2:
+		if (arcam_av->local.zone2.power != arcam_av->global->zone2.power) {
+			snd_ctl_elem_id_set_name(id, arcam_av_power_name);
+			arcam_av->local.zone2.power = arcam_av->global->zone2.power;
+		} else if (arcam_av->local.zone2.volume != arcam_av->global->zone2.volume) {
+			snd_ctl_elem_id_set_name(id, arcam_av_volume_name);
+			arcam_av->local.zone2.volume = arcam_av->global->zone2.volume;
+		} else if (arcam_av->local.zone2.mute != arcam_av->global->zone2.mute) {
+			snd_ctl_elem_id_set_name(id, arcam_av_mute_name);
+			arcam_av->local.zone2.mute = arcam_av->global->zone2.mute;
+		} else if (arcam_av->local.zone2.source != arcam_av->global->zone2.source) {
+			snd_ctl_elem_id_set_name(id, arcam_av_source_name);
+			arcam_av->local.zone2.source = arcam_av->global->zone2.source;
+		} else {
+			char buf[10];
+			if (recv(arcam_av->ext.poll_fd, buf, sizeof(buf), 0) <= 0) {
+				close(arcam_av->ext.poll_fd);
+				arcam_av->ext.poll_fd = arcam_av_client(arcam_av->port);
+				if (arcam_av->ext.poll_fd > 0)
+					fcntl(arcam_av->ext.poll_fd, F_SETFL, O_NONBLOCK);
+			}
+
+			return -EAGAIN;
+		}
+		break;
+	}
+
+	snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
+
+	*event_mask = SND_CTL_EVENT_MASK_VALUE;
+
+	return 1;
+}
+
+
+static snd_ctl_ext_callback_t arcam_av_ext_callback = {
+	.close = arcam_av_close,
+	.elem_count = arcam_av_elem_count,
+	.elem_list = arcam_av_elem_list,
+	.find_elem = arcam_av_find_elem,
+	.get_attribute = arcam_av_get_attribute,
+	.get_integer_info = arcam_av_get_integer_info,
+	.get_enumerated_info = arcam_av_get_enumerated_info,
+	.get_enumerated_name = arcam_av_get_enumerated_name,
+	.read_integer = arcam_av_read_integer,
+	.read_enumerated = arcam_av_read_enumerated,
+	.write_integer = arcam_av_write_integer,
+	.write_enumerated = arcam_av_write_enumerated,
+	.read_event = arcam_av_read_event,
+};
+
+
+SND_CTL_PLUGIN_DEFINE_FUNC(arcam_av)
+{
+	snd_config_iterator_t it, next;
+	const char *port = "/dev/ttyS0";
+	long zone = 1;
+	int err;
+	snd_ctl_arcam_av_t *arcam_av = NULL;
+
+	snd_config_for_each(it, next, conf) {
+		snd_config_t *n = snd_config_iterator_entry(it);
+		const char *id;
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+		if (strcmp(id, "comment") == 0 || strcmp(id, "type") == 0)
+			continue;
+		if (strcmp(id, "port") == 0) {
+			if (snd_config_get_string(n, &port) < 0) {
+				SNDERR("Invalid type for %s", id);
+				return -EINVAL;
+			}
+			continue;
+		}
+		if (strcmp(id, "zone") == 0) {
+			if (snd_config_get_integer(n, &zone) < 0) {
+				SNDERR("Invalid type for %s", id);
+				return -EINVAL;
+			}
+			if (zone < 1 || zone > 2) {
+				SNDERR("Invalid value for %s", id);
+				return -EINVAL;
+			}
+			continue;
+		}
+		SNDERR("Unknown field %s", id);
+		return -EINVAL;
+	}
+
+	if (access(port, R_OK | W_OK) < 0) {
+		err = -errno;
+		goto error;
+	}
+
+	arcam_av = calloc(1, sizeof(*arcam_av) + strlen(port) + 1);
+	
+	if (!arcam_av)
+		return -ENOMEM;
+
+	arcam_av->ext.version = SND_CTL_EXT_VERSION;
+	arcam_av->ext.card_idx = 0;
+	strncpy(arcam_av->ext.id, arcam_av_name, sizeof(arcam_av->ext.id) - 1);
+	strncpy(arcam_av->ext.name, arcam_av_name, sizeof(arcam_av->ext.name) - 1);
+	strncpy(arcam_av->ext.longname, arcam_av_name, sizeof(arcam_av->ext.longname) - 1);
+	strncpy(arcam_av->ext.mixername, arcam_av_name, sizeof(arcam_av->ext.mixername) - 1);
+	arcam_av->ext.poll_fd = -1;
+	arcam_av->ext.callback = &arcam_av_ext_callback;
+	arcam_av->ext.private_data = arcam_av;
+
+	arcam_av->shm_id= -1;
+	arcam_av->port_fd = -1;
+	arcam_av->port = strcpy((char*)(arcam_av + 1), port);
+	arcam_av->zone = zone != 2 ? ARCAM_AV_ZONE1 : ARCAM_AV_ZONE2;
+
+	arcam_av->port_fd = arcam_av_connect(arcam_av->port);
+	if (arcam_av->port_fd < 0) {
+		err = -errno;
+		goto error;
+	}
+
+	if (arcam_av_server_start(&arcam_av->server, arcam_av->port)) {
+		err = -errno;
+		goto error;
+	}
+
+	arcam_av->ext.poll_fd = arcam_av_client(arcam_av->port);
+	if (arcam_av->ext.poll_fd < 0) {
+		err = -errno;
+		goto error;
+	}
+
+	fcntl(arcam_av->ext.poll_fd, F_SETFL, O_NONBLOCK);
+
+	arcam_av->global = arcam_av_state_attach(arcam_av->port);
+	if (!arcam_av->global) {
+		err = -errno;
+		goto error;
+	}
+
+	err = snd_ctl_ext_create(&arcam_av->ext, name, mode);
+	if (err < 0)
+		goto error;
+
+	*handlep = arcam_av->ext.handle;
+	return 0;
+
+ error:
+	perror("arcam_av()");
+	arcam_av_close(&arcam_av->ext);
+	return err;
+}
+
+SND_CTL_PLUGIN_SYMBOL(arcam_av);
diff -Nrup alsa-plugins-1.0.18-orig/configure.in alsa-plugins-1.0.18/configure.in
--- alsa-plugins-1.0.18-orig/configure.in	2008-10-29 12:42:13.000000000 +0000
+++ alsa-plugins-1.0.18/configure.in	2009-01-04 18:03:29.000000000 +0000
@@ -140,6 +140,7 @@ AC_OUTPUT([
 	maemo/Makefile
 	doc/Makefile
 	usb_stream/Makefile
+	arcam-av/Makefile
 ])
 
 dnl Show the build conditions
diff -Nrup alsa-plugins-1.0.18-orig/doc/Makefile.am alsa-plugins-1.0.18/doc/Makefile.am
--- alsa-plugins-1.0.18-orig/doc/Makefile.am	2008-10-29 12:42:13.000000000 +0000
+++ alsa-plugins-1.0.18/doc/Makefile.am	2009-01-04 18:03:29.000000000 +0000
@@ -1,3 +1,3 @@
 EXTRA_DIST = README-pcm-oss README-jack README-pulse README-maemo \
 	upmix.txt vdownmix.txt samplerate.txt a52.txt lavcrate.txt \
-	speexrate.txt
+	speexrate.txt README-arcam-av
diff -Nrup alsa-plugins-1.0.18-orig/doc/README-arcam-av alsa-plugins-1.0.18/doc/README-arcam-av
--- alsa-plugins-1.0.18-orig/doc/README-arcam-av	1970-01-01 01:00:00.000000000 +0100
+++ alsa-plugins-1.0.18/doc/README-arcam-av	2009-01-04 18:03:29.000000000 +0000
@@ -0,0 +1,29 @@
+Arcam AV Amplifier ALSA Control plugin
+======================================
+
+This plugin exposes the controls for an Arcam AV amplifier
+(see: http://www.arcam.co.uk/) as an ALSA mixer device.
+
+To use this plugin you will need to connect the amplifier
+to the PC using an RS-232 null-modem cable and use the
+following ALSA configuration:
+
+	ctl.arcam_av {
+		type arcam_av
+		port /dev/ttyS0
+	}
+
+The "port" parameter is required and indicates the serial
+port to be used to communicate with the amplifier. There is
+an optional "zone" parameter, which accepts a value of
+either "1" (default) or "2", that indicates which of the
+amplifiers zones should be controlled.
+
+NB: You must ensure that any user accounts that are to use
+this plugin have both read and write access rights for the
+configured serial port.
+
+This plugin was developed and tested using an Arcam AVR 300
+amplifier. I believe most Arcam amplifiers use a sufficiently
+similar control system to be compatible with this plugin but
+your mileage may vary.

--Apple-Mail-60--606663862
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit




>> +int arcam_av_connect(const char* port)
>> +{
>> +	int fd = open(port, O_RDWR | O_NOCTTY);
>> +	if (fd < 0)
>> +		return -errno;
>> +
>> +	struct termios portsettings;
>
> Put this into the beginning to follow the standard C.
>

Sorry, I am more used to programming in C++. I have attempted to move  
all of the variable declarations to the top of scope sections, but I  
may have missed some. I assume that was what you meant?

>
>> +	if (bytes == 7)
>> +		return 0;
>> +	else if (bytes >= 0)
>> +		return -1;
>
> No proper error code?
>

I have modified this function to hopefully make it more robust.

>> +static int arcam_av_receive(int fd, arcam_av_cc_t* command,  
>> unsigned char*
>> param1, unsigned char* param2)
>> +{
>> +	static int index = 0;
>> +	static arcam_av_cc_t received_command;
>> +	static unsigned char received_param1;
>> +	static unsigned char received_param2;
>
> Are static variables safe to use here?
> That is, is the plugin designed to access exclusively with a proper
> protection?
>
>>

I believe so, yes.

The system is intended to broadly function as follows:

Each invocation of the plugin calls "arcam_av_connect()" to obtain a  
file descriptor for the serial device to be used to communicate with  
the amplifier. This file descriptor is used to send commands (requests  
to change state) directly to the amplifier (using the  
"arcam_av_send()" function). i.e. all invocations send directly to the  
amplifier.

Each invocation creates a server thread via the  
"arcam_av_server_start()" function. The server thread then switches  
into one of two state, master or slave. The server thread attempts to  
bind to a unix socket, if successful then there is currently no master  
server bound to the socket and the thread should become the master, if  
unsuccessful there is already a master bound to the socket and the  
thread should become a slave. The master server listens to the serial  
device for command responses from the amplifier (obtained using the  
"arcam_av_receive()" function). i.e. only the single master server  
receives directly from the amplifier.

Clients may connect to the master server via the unix socket (using  
the "arcam_av_client()" function). When the master server receives a  
successful command response from the amplifier it notifies all current  
clients that a change has occurred. This mechanism allows many clients  
(invocations of the plugin) to be notified of the change.

Slave servers also attach to the master server as a client. This  
connection is simply used to detect whether the master server has died  
as a result of the plugin invocation housing it being terminated. If  
the master server dies any slave servers attempt to bind to the unix  
socket and in doing so one would become the master server, any  
additional slaves would remain slaves.


>
> Well, I'll review the rest after my vacation is over...
>
>

Thanks! Enjoy your vacation.

Peter
--Apple-Mail-60--606663862
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Apple-Mail-60--606663862--
