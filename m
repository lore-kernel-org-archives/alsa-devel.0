From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Fwd: [usb-midi-fw-devel] proposal concerning cooperation of snd-usb-usx2x.o and rbtload
Date: Fri, 29 Aug 2003 13:29:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308291329.17781.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_NkzT/h82XgOVnsT"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_NkzT/h82XgOVnsT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,
please check the hotplug strategy outlined in the forward.
If it's ok, i'll prepare a next patch based on what is in the forward.

regards,
Karsten

--Boundary-00=_NkzT/h82XgOVnsT
Content-Type: message/rfc822;
  name="forwarded message"
Content-Transfer-Encoding: 7bit
Content-Description: Karsten Wiese <annabellesgarden@yahoo.de>: [usb-midi-fw-devel] proposal concerning cooperation of snd-usb-usx2x.o and rbtload

X-Apparently-To: annabellesgarden@yahoo.de via 216.136.173.85; Thu, 28 Aug 2003 14:51:39 -0700
Return-Path: <usb-midi-fw-devel-admin@lists.sourceforge.net>
Received: from 66.35.250.206  (EHLO sc8-sf-list2.sourceforge.net) (66.35.250.206)
  by mta135.mail.scd.yahoo.com with SMTP; Thu, 28 Aug 2003 14:51:39 -0700
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.13] helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list2.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19sUg8-0000wE-00; Thu, 28 Aug 2003 14:51:40 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19sUed-0004vc-00
	for <usb-midi-fw-devel@lists.sourceforge.net>; Thu, 28 Aug 2003 14:50:07 -0700
Received: from smtp016.mail.yahoo.com ([216.136.174.113])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19sUeb-0007H2-ET
	for usb-midi-fw-devel@lists.sourceforge.net; Thu, 28 Aug 2003 14:50:05 -0700
Received: from p50818346.dip0.t-ipconnect.de (HELO 192.168.1.11) (annabellesgarden@80.129.131.70 with plain)
  by smtp.mail.vip.sc5.yahoo.com with SMTP; 28 Aug 2003 21:50:00 -0000
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: usb-midi-fw-devel@lists.sourceforge.net
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2mnT/PdwPlgs4M2"
Message-Id: <200308282352.54486.annabellesgarden@yahoo.de>
X-Spam-Score: 0.0 (/)
X-Spam-Report: 0.0/5.0
	The original message has been attached along with this report, so
	you can recognize or block similar mail in future.
	See http://spamassassin.org/tag/ for more details.
	Content preview:  hi colegas, have been trying the 0.1 and yes, the fpga
	code does it also for us428 ! concerning cooperation of snd-usb-us428.o
	and rbtload i've implemented a hack: when a hotplug occurs (EZUSB
	Firmware not being looked at here, works as before), the kernel 1.)
	asks snd-usb-us428.o, if it wants to have the device. snd-usb-us428.o
	says 'yes!'. this latest snd-usb-us428.o will not start any
	ALSA-Activity in this stage. It just owns the interface to the us428
	(and implements 2 new ioctl-able entriepoints). 2.) starts rbtload (by
	means of the hotplug-scripts) to download the fpga code. this hacked
	rbtload does the download by means of standard ioctl() - calls to
	snd-usb-us428.o. Thus we don't need libusb here anymore. (libusb is
	still used here for minimizing changing efforts.) if download is
	finished, snd-usb-us428.o ALSA-Activities are started by another ioctl
	to snd-usb-us428.o. [...]
	Content analysis details:   (0.00 points, 5 required)
	USER_AGENT_KMAIL   (0.0 points)  User-Agent header indicates a non-spam MUA (KMail)
Subject: [usb-midi-fw-devel] proposal concerning cooperation of snd-usb-usx2x.o and rbtload
Sender: usb-midi-fw-devel-admin@lists.sourceforge.net
Errors-To: usb-midi-fw-devel-admin@lists.sourceforge.net
X-BeenThere: usb-midi-fw-devel@lists.sourceforge.net
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Help: <mailto:usb-midi-fw-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:usb-midi-fw-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/usb-midi-fw-devel>,
	<mailto:usb-midi-fw-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: USB MIDI firmware loaders - developers <usb-midi-fw-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/usb-midi-fw-devel>,
	<mailto:usb-midi-fw-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=usb-midi-fw-devel>
X-Original-Date: Thu, 28 Aug 2003 23:52:54 +0200
Date: Thu, 28 Aug 2003 23:52:54 +0200
Status: RO
X-Status: O
X-KMail-EncryptionState: N
X-KMail-SignatureState: N


--Boundary-00=_2mnT/PdwPlgs4M2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi colegas,

have been trying the 0.1 and yes, the fpga code does it also for us428 !
concerning cooperation of snd-usb-us428.o and rbtload i've implemented a  
hack:
when a hotplug occurs (EZUSB Firmware not being looked at here, works as 
before), the kernel 
1.) asks snd-usb-us428.o, if it wants to have the device. snd-usb-us428.o says 
'yes!'. this latest snd-usb-us428.o will not start any ALSA-Activity in this 
stage. It just owns the interface to the us428 (and implements 2 new 
ioctl-able entriepoints).
2.) starts rbtload (by means of the hotplug-scripts) to download the fpga 
code. this hacked rbtload does the download by means of standard ioctl() - 
calls to snd-usb-us428.o. Thus we don't need libusb here anymore. (libusb is 
still used here for minimizing changing efforts.) if download is finished, 
snd-usb-us428.o ALSA-Activities are started by another ioctl to 
snd-usb-us428.o.

Result: us428 works as before.

What do you think about setting up a 0.2 this way? 

If you might wonder why snd-usb-us428 is still seperate from snd-usb-audio:
- us428 (and possibly usx2x) use a non standard way of synching audio in & 
out.
- us428 and us224 (don't know about us122) have those knobs & sliders. they 
are also special.
if everything works fine some day, i'd gladly say yes to integrate those 
non-standard stuffs into snd-usb-audio. until then the code is (getting ;-) 
smaller and thus easier to handle.

attached are for illustrating purposes:
1.) rbtload.c : still needs some polishing. libusb can be taken out.
2.) usbus428.c : implements the us428_ioctl(). we can further migrate it to a 
usbusx2x.c for a snd-usb-usx2x.o. 
3.) usbusx2xioctl.h : ioctl codes
everything else is unchanged from the latest versions.

t+,
Karsten

--Boundary-00=_2mnT/PdwPlgs4M2
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="rbtload.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="rbtload.c"

/*
 * rbtload.c
 * Loads a rbt file (fpga configuration) into a tascam usb device
 *
 * Copyright (c) 2003 Pedro L=F3pez-Cabanillas <plcl@bigfoot.com>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions, and the following disclaimer,
 *    without modification.
 * 2. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * Alternatively, this software may be distributed and/or modified under the
 * terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option) any lat=
er
 * version.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPO=
SE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE F=
OR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRI=
CT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

/*
 * This program supports loading firmware into a target USB device
 * that is discovered and referenced by the hotplug usb agent.
 *
 *     -I <path>       -- Download this firmware (rbt bitstream format)
 *     -D <path>       -- Use this device, instead of $DEVICE
 *     -V              -- Print version ID for program
 *     -v              -- more verbose output
 *     -i              -- USB interface number, defaults to 0
 *     -c              -- USB configuration, defaults to 0
 *     -a              -- USB alternate setting, defaults to 0
 *     -e              -- USB endpoint, defaults to 2
 *     -p              -- prepadding bytes, defaults to 0
 *     -t              -- USB bulk transfer timeout, defaults to 1000 ms
 *
 * This program is intended to be started by hotplug scripts in
 * response to a device appearing on the bus. It therefore also
 * expects these environment variables which are passed by hotplug to
 * its sub-scripts:
 *
 *     DEVICE=3D<path>
 *         This is the path to the device is /proc/bus/usb. It is the
 *         complete path to the device, that I can pass to open and
 *         manipulate as a USB device.
 */

#include  <stdlib.h>
#include  <stdio.h>
#include  <getopt.h>
#include  <string.h>
#include  <ctype.h>
#include  <errno.h>
#include  <stdarg.h>
#include  <sys/types.h>
#include  <sys/stat.h>
#include  <sys/ioctl.h>=20
#include  <fcntl.h>
#include  <unistd.h>
#include  <usb.h>
#include  <linux/usbdevice_fs.h>
#include  "usbusx2xioctl.h"

#ifndef	RBTLOAD_VERSION
#	define RBTLOAD_VERSION ("0.2")
#endif
#define PROGNAME "rbtload"

typedef unsigned char byte;

static int verbose =3D 0;

void usage()
{
	fprintf(stderr,
		"usage: " PROGNAME
		" [-h] [-vV] [-D devpath] [-t timeout]\n");
	fprintf(stderr,
		"               [-i interface] [-c configuration] [-a altsetting]\n");
	fprintf(stderr,
		"               [-e endpoint] [-p prepadding] -I rbt_file\n");
	fprintf(stderr, "[-D devpath] overrides DEVICE=3D in env\n");
	fprintf(stderr, "[-e endpoint] defaults to 2\n");
	fprintf(stderr, "[-t timeout] defaults to 1000\n");
	exit(EXIT_FAILURE);
}

/*
 * read a xilinx bitstream file
 */
static byte *read_xilinx_image(const char *fname, int *imglen)
{
	FILE *fp;
	char buf[256];
	int data, c, idx, length;
	char *p;
	byte *imgbuf;

	if ((fp =3D fopen(fname, "r")) =3D=3D NULL) {
		fprintf(stderr, PROGNAME ": cannot open %s\n", fname);
		exit(EXIT_FAILURE);
	}

	c =3D 0;
	data =3D 0;
	idx =3D 0;
	length =3D 0;
	while (fgets(buf, sizeof(buf), fp)) {
		if (strncmp(buf, "Bits:", 5) =3D=3D 0) {
			for (p =3D buf + 5; *p && isspace(*p); p++);
			if (!*p) {
				fprintf(stderr,
					PROGNAME
					": corrupted file %s in Bits line\n",
					fname);
				fclose(fp);
				exit(EXIT_FAILURE);
			}
			length =3D atoi(p);
			length /=3D 8;
			if (length <=3D 0) {
				fprintf(stderr,
					PROGNAME
					": corrupted file %s, detected length =3D %d\n",
					fname, length);
				fclose(fp);
				exit(EXIT_FAILURE);
			}
			*imglen =3D length;
			imgbuf =3D malloc(length);
			if (!imgbuf) {
				fprintf(stderr,
					PROGNAME
					": cannot alloc %d bytes\n",
					length);
				fclose(fp);
				exit(EXIT_FAILURE);
			}
			continue;
		}
		if ((buf[0] !=3D '0') && (buf[0] !=3D '1')) {
			//printf("line %d skipped\n", line);
			continue;
		}
		if (length <=3D 0) {
			fprintf(stderr,
				PROGNAME
				": corrupted file %s, starting without Bits line\n",
				fname);
			fclose(fp);
			exit(EXIT_FAILURE);
		}
		//printf("\n idx=3D%d", idx);
		for (p =3D buf; *p =3D=3D '0' || *p =3D=3D '1'; p++) {
			data |=3D (*p - '0') << c;
			c++;
			if (c >=3D 8) {
				//printf(" %02X", data);
				imgbuf[idx++] =3D data;
				data =3D c =3D 0;
				if (idx > length)
					break;
			}
		}
	}
	if (c)
		imgbuf[idx++] =3D data;
	if (idx !=3D length) {
		fprintf(stderr,
			PROGNAME ": length doesn't match: %d !=3D %d\n", idx,
			length);
		fclose(fp);
		exit(EXIT_FAILURE);
	}
	fclose(fp);
	return imgbuf;
}

usb_dev_handle *usb_find_device(char *devpath, int configuration, int inter=
face,
				int altsetting)
{
	struct usb_bus *bus;
	struct usb_device *dev;
	struct usb_device *found =3D NULL;
	usb_dev_handle *usbdev =3D NULL;
	char filename[64];
	char lastpath[64];
	char *tok;
	char *pos;
	int i, ret;

	// initialize libusb
	usb_init();
	// search for USB busses
	if ((usb_find_busses()) < 0) {
		fprintf(stderr, PROGNAME ": USB Error %s\n",
			usb_strerror());
		exit(EXIT_FAILURE);
	}
	// search for devices on USB busses
	if ((ret =3D usb_find_devices()) < 0) {
		fprintf(stderr, PROGNAME ": USB Error %s\n",
			usb_strerror());
		exit(EXIT_FAILURE);
	}
	pos =3D devpath;
	memset(&lastpath, 0, sizeof(lastpath));
	memset(&filename, 0, sizeof(filename));
	while ((tok =3D strsep(&pos, "/"))) {
		strncpy(lastpath, filename, sizeof(lastpath));
		strncpy(filename, tok, sizeof(filename));
	}
	// go through all busses and devices
	for (bus =3D usb_busses; bus; bus =3D bus->next) {
		for (dev =3D bus->devices; dev; dev =3D dev->next) {
			if (!strcmp(filename, dev->filename)
			    && !(strcmp(lastpath, bus->dirname))) {
				found =3D dev;
				break;
			}
		}
	}
	// check if we found the device
	if (!found) {
		fprintf(stderr, PROGNAME ": Device %s not found\n",
			devpath);
		exit(EXIT_FAILURE);
	}
	// set errno to zero here. this is necessary, because above each USB-device
	// is opend and then ioctl'd, which results in EPERM errors on some. These
	// are remembered in errno, which is _not_ updated on success in usb_open.
	// So the if clause afterwards will return, despite the error was earlier
	// and harmless.
	errno =3D 0;
	// open a connection to this device
	usbdev =3D usb_open(found);
	if ((!usbdev) | (errno)) {
		fprintf(stderr, PROGNAME ": USB Error %s\n",
			usb_strerror());
		exit(EXIT_FAILURE);
	}
/* 	{ */
/* 		char			buf[] =3D "der puffer"; */
/* 		struct usbdevfs_ioctl	io =3D {0,IOCTL_USx2x_OUT_PIPE2(sizeof(buf)),buf=
}; */

/* 		if(ioctl( *(int*)usbdev, USBDEVFS_IOCTL, &io)) */
/* 			perror( "ioctl!"); */
/* 	} */
/* 	{ */
/* 		struct usbdevfs_ioctl io =3D {0,IOCTL_USx2x_START_ALSA,NULL}; */
/* 		if(ioctl( *(int*)usbdev, USBDEVFS_IOCTL, &io)) */
/* 			perror( "ioctl!"); */
/* 	} */
/* 	{ */
/* 		struct usbdevfs_ioctl io =3D {0,IOCTL_USx2x_STOP_ALSA,NULL}; */
/* 		if(ioctl( *(int*)usbdev, USBDEVFS_IOCTL, &io)) */
/* 			perror( "ioctl!"); */
/* 	} */

/* 	// set configuration */
/* 	i =3D usb_device(usbdev)->config[configuration].bConfigurationValue; */
/* 	if (usb_set_configuration(usbdev, i) < 0) { */
/* 		fprintf(stderr, PROGNAME ": USB Error %s\n", */
/* 			usb_strerror()); */
/* 		exit(EXIT_FAILURE); */
/* 	} */
/* 	// set interface */
/* 	i =3D usb_device(usbdev)->config[configuration].interface[interface]. */
/* 	    altsetting[altsetting].bInterfaceNumber; */
/* 	if (usb_claim_interface(usbdev, i) < 0) { */
/* 		fprintf(stderr, PROGNAME ": USB Error %s\n", */
/* 			usb_strerror()); */
/* 		exit(EXIT_FAILURE); */
/* 	} */
/* 	// set alternate interface */
/* 	i =3D usb_device(usbdev)->config[configuration].interface[interface]. */
/* 	    altsetting[altsetting].bAlternateSetting; */
/* 	if (usb_set_altinterface(usbdev, i) < 0) { */
/* 		fprintf(stderr, PROGNAME ": USB Error %s\n", */
/* 			usb_strerror()); */
/* 		exit(EXIT_FAILURE); */
/* 	} */
	return usbdev;
}

void download_image(usb_dev_handle * usbdev, int pipe, byte * imgbuf,
		    int length, int timeout)
{
	int ret;
	int todo;
	int pos =3D 0;

	if (!imgbuf || !length) {
		fprintf(stderr,
			PROGNAME ": invalid download_image params\n");
		exit(EXIT_FAILURE);
	}
	while (pos < length) {
		todo =3D 0x1000;
		if ((length - pos) < todo)
			todo =3D (length - pos);
		{
			struct usbdevfs_ioctl	io =3D {0,IOCTL_USx2x_OUT_PIPE2(todo), imgbuf+pos};
		=09
			ret =3D ioctl( *(int*)usbdev, USBDEVFS_IOCTL, &io);
		}

		if (ret) {
			perror( PROGNAME ": USB Error");
			exit(EXIT_FAILURE);
		}
		//printf("."); fflush(stdout);
		pos +=3D todo;
	}
	//printf("\n");
}

int main(int argc, char *argv[])
{
	char *firmware_path =3D 0;
	char *device_path =3D getenv("DEVICE");
	int prepadding =3D 0;
	int endpoint =3D 2;
	int interface =3D 0;
	int configuration =3D 0;
	int altsetting =3D 0;
	int timeout =3D 1000;
	int configuration_length =3D 0;
	int opt;
	byte *configuration_data;
	byte *pad_data;
	usb_dev_handle *usbdev =3D NULL;

	while ((opt =3D getopt(argc, argv, "hvVD:I:i:c:a:e:p:t:")) !=3D EOF)
		switch (opt) {
		case 'D':
			device_path =3D optarg;
			break;

		case 'I':
			firmware_path =3D optarg;
			break;

		case 'V':
			puts(RBTLOAD_VERSION);
			return 0;

		case 'v':
			verbose++;
			break;

		case 'i':
			interface =3D atoi(optarg);
			break;

		case 'c':
			configuration =3D atoi(optarg);
			break;

		case 'a':
			altsetting =3D atoi(optarg);
			break;

		case 'e':
			endpoint =3D atoi(optarg);
			break;

		case 'p':
			prepadding =3D atoi(optarg);
			break;

		case 't':
			timeout =3D atoi(optarg);
			break;

		case 'h':
		default:
			usage();
		}

	if (!device_path) {
		fputs(PROGNAME ": no device specified!\n", stderr);
		usage();
	}

	if (!firmware_path) {
		fputs(PROGNAME ": missing firmware file name!\n", stderr);
		usage();
	}

	configuration_data =3D
	    read_xilinx_image(firmware_path, &configuration_length);
	usbdev =3D
	    usb_find_device(device_path, configuration, interface,
			    altsetting);

	if (prepadding) {
		pad_data =3D malloc(prepadding);
		memset(pad_data, 0, prepadding);
		download_image(usbdev, endpoint, pad_data, prepadding,
			       timeout);
	}
	download_image(usbdev, endpoint, configuration_data,
		       configuration_length, timeout);
	{
		struct usbdevfs_ioctl io =3D {0,IOCTL_USx2x_START_ALSA, NULL};
		if(ioctl( *(int*)usbdev, USBDEVFS_IOCTL, &io));
		perror( "ioctl!");
	}

	// close USB handle
	if (usb_close(usbdev) < 0) {
		fprintf(stderr, PROGNAME ": USB Error %s\n",
			usb_strerror());
		return EXIT_FAILURE;
	}
	return EXIT_SUCCESS;
}

--Boundary-00=_2mnT/PdwPlgs4M2
Content-Type: text/x-chdr;
  charset="us-ascii";
  name="usbusx2xioctl.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="usbusx2xioctl.h"

#ifndef USBUS428IOCTL_H
#define USBUS428IOCTL_H
#include <linux/ioctl.h>

#define IOCTL_USx2x_OUT_PIPE2(len)	_IOC(_IOC_WRITE,'U',0,len)
#define IOCTL_USx2x_START_ALSA		_IO('U', 1)
#define IOCTL_USx2x_STOP_ALSA		_IO('U', 2)

#endif

--Boundary-00=_2mnT/PdwPlgs4M2
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="usbus428.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="usbus428.c"

/*
 * usbus428.c - ALSA USB US-428 Driver
 *
2003-08-22 Karsten Wiese
	Version 0.0.8:
	Removed EZUSB Firmware. First Stage Firmwaredownload is now done by tascam-firmware downloader.
	See:
	http://usb-midi-fw.sourceforge.net/tascam-firmware.tar.gz

2003-06-18 Karsten Wiese
	Version 0.0.5:
	changed to compile with kernel 2.4.21 and alsa 0.9.4

2002-10-16 Karsten Wiese
	Version 0.0.4:
	compiles again with alsa-current.
	USB_ISO_ASAP not used anymore (most of the time), instead
	urb->start_frame is calculated here now, some calls inside usb-driver don't need to happen anymore.

	To get the best out of this:
	Disable APM-support in the kernel as APM-BIOS calls (once each second) hard disable interrupt for many precious milliseconds.
	This helped me much on my slowish PII 400 & PIII 500.
	ACPI yet untested but might cause the same bad behaviour.
	Use a kernel with lowlatency and preemptiv patches applied.
	To autoload snd-usb-midi append a line 
		post-install snd-usb-us428 modprobe snd-usb-midi
	to /etc/modules.conf.

	known problems:
	sliders, knobs, lights not yet handled except MASTER Volume slider.
       	"pcm -c 2" doesn't work. "pcm -c 2 -m direct_interleaved" does.
	KDE3: "Enable full duplex operation" deadlocks.

	
2002-08-31 Karsten Wiese
	Version 0.0.3: audio also simplex;
	simplifying: iso urbs only 1 packet, melted structs.
	ASYNC_UNLINK not used anymore: no more crashes so far.....
	for alsa 0.9 rc3.

2002-08-09 Karsten Wiese
	Version 0.0.2: midi works with snd-usb-midi, audio (only fullduplex now) with i.e. bristol.
	The firmware has been sniffed from win2k us-428 driver 3.09.

 *   Copyright (c) 2002 Karsten Wiese
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
*/

#include <sound/driver.h>
#include <sound/core.h>
#include <sound/seq_device.h>
#define SNDRV_GET_ID
#include <sound/initval.h>
#include <sound/pcm.h>

#include <sound/rawmidi.h>
#include <linux/usb.h>
#include "usbus428.h"
#include "usbus428ctls.h" 
#include "usbus428ctldefs.h" 
#include "usbus428ioctl.h" 



MODULE_AUTHOR("Karsten Wiese <annabellesgarden@yahoo.de>");
MODULE_DESCRIPTION("USB TASCAM (0x1604) US-428 (0x8001) Version 0.0.8");
MODULE_LICENSE("GPL");
MODULE_CLASSES("{sound}");

static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
static char* id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for this card */
static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP; /* Enable this card */

MODULE_PARM(index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
MODULE_PARM_DESC(index, "Index value for USB MIDI.");
MODULE_PARM_SYNTAX(index, SNDRV_INDEX_DESC);
MODULE_PARM(id, "1-" __MODULE_STRING(SNDRV_CARDS) "s");
MODULE_PARM_DESC(id, "ID string for USB MIDI.");
MODULE_PARM_SYNTAX(id, SNDRV_ID_DESC);
MODULE_PARM(enable, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
MODULE_PARM_DESC(enable, "Enable USB MIDI.");
MODULE_PARM_SYNTAX(enable, SNDRV_ENABLE_DESC);


static int snd_us428_card_used[SNDRV_CARDS];
DECLARE_MUTEX(snd_us428_open_mutex);
static void snd_us428_Out04Int(urb_t* urb);

static void* us428_usb_probe(struct usb_device* device,
				   unsigned int ifnum,
				   const struct usb_device_id* device_id);
static void snd_us428_usb_disconnect(struct usb_device* usb_device, void* ptr);

struct us428_control{
	unsigned short TransferBuLe;
	unsigned char  TransferBuffer[16];
	unsigned char  Request;
	unsigned short Value;
};


static void snd_us428_In04Int(urb_t* urb){
	int		err = 0;
	us428dev_t*	us428 = urb->context;
	
	us428->In04IntCalls++;

	if (urb->status){
		snd_printk( "Interrupt Pipe 4 came back with status=%i\n", urb->status);
		return;
	}

        {
		int diff = -1, i, j, v;
	//	printk("%i:0x%02X ", 8, (int)((unsigned char*)us428->In04Buf)[8]); Master volume shows 0 here if fader is at max during boot ?!?
		for (i = 0; i < 21; i++){
			if (us428->In04Last[i] != ((char*)us428->In04Buf)[i]){
/* 				printk("%i:0x%02X ", i, (int)((unsigned char*)us428->In04Buf)[i]); */
				diff = i;
				us428->In04Last[i] = ((char*)us428->In04Buf)[i];
				switch(i){
				case eFaderM:		// Master Volume
					v = 0x40 * ((unsigned char*)us428->In04Last)[i];
					for (j = 0; j < URBS_AsyncSeq; ++j)
						if (0 == us428->AS04.urb[j]->status){
							usb_fill_bulk_urb(	us428->AS04.urb[j], us428->chip.dev,
										usb_sndbulkpipe(us428->chip.dev, 0x04),
										us428->AS04.urb[j]->transfer_buffer, 5,
										snd_us428_Out04Int, us428
										);
							((char*)us428->AS04.urb[j]->transfer_buffer)[0] = 4;
							((char*)us428->AS04.urb[j]->transfer_buffer)[1] =
							((char*)us428->AS04.urb[j]->transfer_buffer)[3] = (v & 0xff00) >> 8;
							((char*)us428->AS04.urb[j]->transfer_buffer)[2] =
							((char*)us428->AS04.urb[j]->transfer_buffer)[4] = v & 0xff;
							//printk(" %i ", v);
							us428->AS04.urb[j]->transfer_flags = USB_QUEUE_BULK;
							/*if ((err =*/ usb_submit_urb(us428->AS04.urb[j]);//))
							break;
						}
				}
			}
		}
		if (diff >= 0  &&  P_us428ctls_sharedmem_u){
			us428ctls_sharedmem_t* us428ctls = &(P_us428ctls_sharedmem_u->us428ctls);
			int n = us428ctls->CtlSnapShotLast + 1;

			if (n >= N_us428_ctl_BUFS  ||  n < 0)
				n = 0;
			memcpy(us428ctls->CtlSnapShot + n, us428->In04Buf, sizeof(us428ctls->CtlSnapShot[0]));
			us428ctls->CtlSnapShotDiffersAt[n] = diff;
			us428ctls->CtlSnapShotLast = n;
			wake_up(&us428ctls_wait_queue_head);
		}
	}
	
	
	if (us428->US04){
		if (0 == us428->US04->submitted){
			do{
				err = usb_submit_urb(us428->US04->urb[us428->US04->submitted++]);
			}while (! err && us428->US04->submitted < us428->US04->len);
			snd_printd("us428->US04->submitted=%i\n", us428->US04->submitted);
		}
	}else
		if (P_us428ctls_sharedmem_u){
			us428ctls_sharedmem_t* us428ctls = &(P_us428ctls_sharedmem_u->us428ctls);
			if (us428ctls->MakeLightLast != us428ctls->MakeLightSent
			       && us428ctls->MakeLightLast >= 0
			       && us428ctls->MakeLightLast < N_us428_light_BUFS
				){
				int j;
				for (j = 0; j < URBS_AsyncSeq; ++j)
					if (0 == us428->AS04.urb[j]->status){
						usb_fill_bulk_urb(	us428->AS04.urb[j], us428->chip.dev,
									usb_sndbulkpipe(us428->chip.dev, 0x04),
									us428ctls->MakeLight + us428ctls->MakeLightLast, sizeof(us428ctls->MakeLight[0]),
									snd_us428_Out04Int, us428
							);
						us428->AS04.urb[j]->transfer_flags = USB_QUEUE_BULK;
						/*if ((err =*/ usb_submit_urb(us428->AS04.urb[j]);//))
						us428ctls->MakeLightSent = us428ctls->MakeLightLast;
						break;
					}

				;
			}
		}


	if (err){
		snd_printk("In04Int() usb_submit_urb err=%i\n", err);
	}
}





static int snd_us428_In04_init(us428dev_t* us428)
{
	int	err = 0;
	if (! (us428->In04urb = usb_alloc_urb(0)))
		return -ENOMEM;

	if (! (us428->In04Buf = kmalloc(21, GFP_KERNEL))){
		usb_free_urb(us428->In04urb);
		return -ENOMEM;
	}
	 
	init_waitqueue_head(&us428->In04WaitQueue);
	usb_fill_int_urb(	us428->In04urb, us428->chip.dev, usb_rcvintpipe(us428->chip.dev, 0x4),
				us428->In04Buf, 21,
				snd_us428_In04Int, us428,
				10);
	us428->In04urb->transfer_flags = USB_QUEUE_BULK;
	err = usb_submit_urb(us428->In04urb);
	return err;
}



/* 
 * pipe 4 is used for switching the lamps, setting samplerate, volumes ....   
 */
static void snd_us428_Out04Int(urb_t* urb){
	if (urb->status){
		int		i;
		us428dev_t*	us428 = urb->context;
		for (i = 0; i < 10 && us428->AS04.urb[i] != urb; i++);
		snd_printd("snd_us428_Out04Int() us428->Seq04=%i urb %i status=%i\n", us428->Seq04, i, urb->status);
	}
}
/*
 * Prepare some urbs
 */
static int snd_us428_AsyncSeq04_init(us428dev_t* us428)
{
	int	err = 0,
		i;
	us428->Seq04 = 0;

	if (NULL == (us428->AS04.buffer = kmalloc(URB_DataLen_AsyncSeq*URBS_AsyncSeq, GFP_KERNEL))){
		err = -ENOMEM;
	}else
		for (i = 0; i < URBS_AsyncSeq; ++i){
			if (NULL == (us428->AS04.urb[i] = usb_alloc_urb(0))){
				err = -ENOMEM;
				break;
			}
			usb_fill_bulk_urb(	us428->AS04.urb[i], us428->chip.dev,
						usb_sndbulkpipe(us428->chip.dev, 0x04),
						us428->AS04.buffer + URB_DataLen_AsyncSeq*i, 0,
						snd_us428_Out04Int, us428
				);
		}
	return err;
}


static void snd_us428_unlinkSeq(snd_us428_AsyncSeq_t* S)
{
	int	i;
	for (i = 0; i < URBS_AsyncSeq; ++i){
		if (S[i].urb){
			usb_unlink_urb(S->urb[i]);
			usb_free_urb(S->urb[i]);
			S->urb[i] = NULL;
		}
	}
	kfree(S->buffer);
}



static int snd_us428_create_usbmidi(snd_card_t* card )
{
	static snd_usb_midi_endpoint_info_t quirk_data = {
		.out_ep =0x06,
		.in_ep = 0x06,
		.out_cables =	0x003,
		.in_cables =	0x003
	};
	static snd_usb_audio_quirk_t quirk = {
		.vendor_name =	"TASCAM",
		.product_name =	"US-428",
		.ifnum = 	0,
       		.type = QUIRK_MIDI_FIXED_ENDPOINT,
		.data = &quirk_data
	};

	snd_printd("snd_us428_create_usbmidi \n");

        INIT_LIST_HEAD(&us428(card)->chip.midi_list);

	return snd_usb_create_midi_interface(&us428(card)->chip, us428(card)->chip.dev->actconfig->interface , &quirk);
}




static int snd_us428_create_alsa_devices(snd_card_t* card)
{
	int err;

	do {
		if ((err = snd_us428_create_usbmidi(card)) < 0){
			snd_printk("snd_us428_create_alsa_devices: snd_us428_create_usbmidi error %i \n", err);
			break;
		}
		err = snd_us428_audio_create(card);
		if (err < 0) 
			break;
		err = snd_card_register(card);
		if (err < 0) 
			break;
	} while (0);

	return err;
} 

static void snd_us428_card_private_free(snd_card_t *card)
{
	if (us428(card)->chip.index >= 0  &&  us428(card)->chip.index < SNDRV_CARDS){
		snd_us428_card_used[us428(card)->chip.index] = 0;
	}
}

static struct usb_device_id snd_us428_usb_id_table[] = {
	{
		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
		.idVendor =	0x1604,
		.idProduct =	0x8001 
	},
	{ /* terminator */ }
};

static snd_card_t* snd_us428_create_card(struct usb_device* device)
{
	int		err = 0,	
			dev;
	snd_card_t*	card = NULL;

	do{
		for (dev = 0; dev < SNDRV_CARDS; ++dev){
			if (enable[dev] && !snd_us428_card_used[dev])
				break;
		}
		if (dev >= SNDRV_CARDS){
			err = -ENOENT;
			break;
		}
		card = snd_card_new(index[dev], id[dev], THIS_MODULE, sizeof(us428dev_t));
		if (! card) {
			err = -ENOMEM;
			break;
		}
		snd_us428_card_used[us428(card)->chip.index = dev] = 1;
		card->private_free = snd_us428_card_private_free;
		us428(card)->chip.dev = device;
		us428(card)->chip.card = card;
		us428(card)->stride = 4;		// 16 Bit 
		strcpy(card->driver, "USB US-428");
		sprintf(card->shortname, "TASCAM US-428");
		sprintf(card->longname, "%s (%x:%x if %d at %03d/%03d)",
			card->shortname, 
			snd_us428_usb_id_table[0].idVendor, snd_us428_usb_id_table[0].idProduct,
			0,//us428(card)->usbmidi.ifnum,
			us428(card)->chip.dev->bus->busnum, us428(card)->chip.dev->devnum
			);
	} while (0);
	return card;
}


/* int snd_us428_initPipe2(struct usb_device* dev) */
/* { */
/* 	char *argv [3], **envp, *buf, *scratch; */
/* 	int i = 0, value; */

/* 	if (in_interrupt ()) { */
/* 		dbg ("In_interrupt"); */
/* 		return -1; */
/* 	} */
/* 	if (dev->devnum < 0) { */
/* 		dbg ("device already deleted ??"); */
/* 		return -1; */
/* 	} */
/* 	if (!(envp = (char **) kmalloc (20 * sizeof (char *), GFP_KERNEL))) { */
/* 		dbg ("enomem"); */
/* 		return -1; */
/* 	} */
/* 	if (!(buf = kmalloc (256, GFP_KERNEL))) { */
/* 		kfree (envp); */
/* 		dbg ("enomem2"); */
/* 		return -1; */
/* 	} */

/* 	/\* only one standardized param to hotplug command: type *\/ */
/* 	argv [0] = "/etc/hotplug/usb/tascam_fpga"; */
/* 	argv [1] = "-a1"; */
/* 	argv [2] = 0; */

/* 	/\* minimal command environment *\/ */
/* 	envp [i++] = "HOME=/"; */
/* 	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin"; */

/* #ifdef	DEBUG */
/* 	/\* hint that policy agent should enter no-stdout debug mode *\/ */
/* 	envp [i++] = "DEBUG=kernel"; */
/* #endif */
/* 	/\* extensible set of named bus-specific parameters, */
/* 	 * supporting multiple driver selection algorithms. */
/* 	 *\/ */
/* 	scratch = buf; */

/* 	/\* action:  add, remove *\/ */
/* 	envp [i++] = "PRODUCT=1604/8001/"; */
/* 	envp [i++] = scratch; */
/* 	scratch += sprintf (scratch, "DEVICE=/proc/bus/usb/%03d/%03d", */
/* 		dev->bus->busnum, dev->devnum) + 1; */
/* 	envp [i++] = 0; */
/* 	/\* assert: (scratch - buf) < sizeof buf *\/ */

/* 	/\* NOTE: user mode daemons can call the agents too *\/ */

/* 	dbg ("kusbd: %s %s %d", argv [0], verb, dev->devnum); */
/* 	value = call_usermodehelper (argv [0], argv, envp); */
/* 	kfree (buf); */
/* 	kfree (envp); */
/* 	if (value != 0) */
/* 		dbg ("kusbd policy returned 0x%x", value); */
/* 	return value; */
/* } */


static int us428_start_alsa(struct usb_device* device)
{
	snd_card_t*		card = NULL;
	int			err = 0;
	struct usb_interface*	interface = device->actconfig->interface + 0;
	
	down(&snd_us428_open_mutex);
	do {
			/* See if the device offered us matches what we can accept */
		if (device->descriptor.idVendor != 0x1604 || device->descriptor.idProduct != 0x8001)
			break;
		
		snd_printd("us428_start_alsa(interface->act_altsetting=%i)\n", (int)interface->act_altsetting);

				// altsetting 1: 16 Bit;  2: 24 Bit FIXME for 24 bit
		if ((err = usb_set_interface(device, 0, 1))){
			snd_printd("usb_set_interface error \n");
			break;
		}
		if (1 != interface->act_altsetting){
			snd_printd("act_altsetting != 1\n");
			break;
		}

		if (err)
			break;

		if (NULL == (card = snd_us428_create_card(device)))
			break;

		us428(card)->Seq04Complete = 1;

		if ((err = snd_us428_AsyncSeq04_init(us428(card)))){
			snd_printd("snd_us428_AsyncSeq04_init error \n");
			break;
		}
		if ((err = snd_us428_create_alsa_devices(card))){
			snd_printd("snd_us428_create_alsa_devices error %i \n", err);
			snd_card_free(card);
			break;
		}
		if ((err = snd_us428_In04_init(us428(card)))){
			snd_printd("snd_us428_In04_init error \n");
			break;
		}
		if ((err = init_us428ctls(us428(card)))){
			snd_printd("init_us428ctls error \n");
			break;
		}
		snd_printd(" us428_start_alsa succeeded :-)\n");
	} while (0);

	if (err){
		snd_card_free(card);
		card = NULL;
	} else
		usb_ifnum_to_if(device, 0)->private_data = card;

	up(&snd_us428_open_mutex);
	return err;
}


/*
 * Probes for an us428 in hot boot state
 */
static void* us428_usb_probe(struct usb_device* device, unsigned int ifnum, const struct usb_device_id* device_id)
{
	struct usb_interface*	interface = device->actconfig->interface + ifnum;
	
			/* See if the device offered us matches what we can accept */
	if (device->descriptor.idVendor != 0x1604 || device->descriptor.idProduct != 0x8001)
		return 0;
		
	snd_printd("us428_usb_probe(ifnum=%i, d_id=%i, interface->act_altsetting=%i)\n", ifnum, (int)device_id, (int)interface->act_altsetting);
		
	return (void*)-1;	// Marker: we govern this device, no alsa yet.
}


MODULE_DEVICE_TABLE(usb, snd_us428_usb_id_table);
static int us428_ioctl(struct usb_device *dev, unsigned int code, void *buf);
static struct usb_driver snd_us428_usb_driver = {
	.name =		"snd-usb-us428",
	.probe =	us428_usb_probe,
	.disconnect =	snd_us428_usb_disconnect,
	.id_table =	snd_us428_usb_id_table,
	.driver_list =	LIST_HEAD_INIT(snd_us428_usb_driver.driver_list),
	.ioctl =        us428_ioctl
};


static int us428_ioctl(struct usb_device *dev, unsigned int code, void *buf)
{
	if ('U' != _IOC_TYPE(code))
		return -EBADRQC;

	if ((void*)-1 != usb_ifnum_to_if(dev, 0)->private_data)
		return -EBUSY;		// ALSA Interface activ. nobody may disturb.

	switch (_IOC_NR(code)) {
	case _IOC_NR(IOCTL_USx2x_OUT_PIPE2(0)):
	{
		int lret;
		return usb_bulk_msg(dev, usb_sndbulkpipe(dev, 2), buf, _IOC_SIZE(code), &lret,  HZ);
	}
	case _IOC_NR(IOCTL_USx2x_START_ALSA):
		us428_start_alsa(dev);
		break;
	case _IOC_NR(IOCTL_USx2x_STOP_ALSA):
		return -ENOSYS;
		break;
	default:
		return -EBADRQC;
	}

	snd_printk( "us428_ioctl(usb_device * %p, code %X, buf %p)\n", dev, code, buf);
	return 0;
}

/*
 * Frees the device.
 */
static void snd_us428_usb_disconnect(struct usb_device* device, void* ptr)
{
	if (ptr && (void*)-1 != ptr) {
		snd_card_t*		card = ptr;
		struct list_head*	p;

		down(&snd_us428_open_mutex);
		cleanup_us428ctls();
		/* release the midi resources */
		list_for_each(p, &us428(card)->chip.midi_list) {
			snd_usbmidi_disconnect(p, &snd_us428_usb_driver);
		}

		snd_printd("snd_us428_usb_disconnect(struct usb_device* =0x%X, void* ptr)\n", (int)device);

		snd_us428_unlinkSeq(&(us428(card)->AS04));

		usb_unlink_urb(us428(card)->In04urb);
		kfree(us428(card)->In04Buf);
		usb_free_urb(us428(card)->In04urb);

		snd_card_free(card);
		up(&snd_us428_open_mutex);
	}
	snd_printd("snd_us428_usb_disconnect() end\n");
}

static int __init snd_us428_module_init(void)
{
	int err;

	err = usb_register(&snd_us428_usb_driver);
	if (err < 0) {
		return err;
	}
	return 0;
}

static void __exit snd_us428_module_exit(void)
{
	usb_deregister(&snd_us428_usb_driver);
}

module_init(snd_us428_module_init)
module_exit(snd_us428_module_exit)

#ifndef MODULE

/* format is: snd-usb-us428=enable,index,id */

static int __init snd_us428_setup(char* str)
{
	static unsigned __initdata nr_dev = 0;

	if (nr_dev >= SNDRV_CARDS)
		return 0;
	(void)(get_option(&str, &enable[nr_dev]) == 2 &&
	       get_option(&str, &index[nr_dev]) == 2 &&
	       get_id(&str, &id[nr_dev]) == 2);
	nr_dev++;
	return 1;
}

__setup("snd-usb-us428=", snd_us428_setup);

#endif /* !MODULE */

--Boundary-00=_2mnT/PdwPlgs4M2--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
usb-midi-fw-devel mailing list
usb-midi-fw-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/usb-midi-fw-devel

--Boundary-00=_NkzT/h82XgOVnsT--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
