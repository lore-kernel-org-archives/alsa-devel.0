From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Can someone verify support for "AzTech Sound
 Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset - FCC-ID:I38-MMSN846"
 ?
Date: Tue, 15 May 2007 00:22:03 +0200
Message-ID: <4648E10B.4010403@gmail.com>
References: <20070513101757.8C8191BF23B@ws1-1.us4.outblaze.com>
	<4648DA4E.8050107@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060206080107020005040703"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id C2B0E247D4
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 00:24:41 +0200 (CEST)
In-Reply-To: <4648DA4E.8050107@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ramkromberg@mail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060206080107020005040703
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 05/14/2007 11:53 PM, Rene Herman wrote:

> In the next message I'll post a small userspace program to do the
> enabling from userspace so that you can use that for now and then just
> use either snd-sb8 or snd-sgalaxy to drive the card.

As said. If you execute this as root it should enable the card. You can pick 
the base address (the one JMPB0 is set to) with "-p 0x220|0x240". Default is 
0x200 if you don't specify one.

You can supply a configuration value yourself; you'd want the same value as 
the parameter to EEPROM.SYS in CONFIG.SYS under your DOS install. However, 
if you do not supply a a value the card will just be enabled using a default 
value (same default value DOS uses) and this should work fine assuming you 
have those default resources free/reserved.

so:

sudo ./eeprom
sudo modprobe snd-sb8 port=0x220 irq=5 dma8=1

or

sudo ./eeprom
sudo modprobe snd-sgalaxy sbport=0x220 wssport=0x530

Once you have the card set to wss mode (ie, have loaded snd-sgalaxy) you 
can't unload snd-sgalaxy again and start using snd-sb8; the card would have 
to be reset to SB mode first again.

After that sudo ./eeprom, the drivers should not only load but in fact work. 
Remember to increase/unmute the volumes in a mixer...

The program needs to talk to I/O ports and therefore needs root priviliges. 
It's generally a fairly bad idea to run root programs you haven't compiled 
yourself, but if compiling this userspace program is also a problem for you 
currently, there's a binary at:

http://members.home.nl/rene.herman/eeprom

was compiled on slackware 11.0, staticly linked.

If this still doesn't work you... I'm going to be sad.

Rene.

--------------060206080107020005040703
Content-Type: text/plain;
 name="eeprom.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="eeprom.c"

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>

#include <sys/io.h>
#include <unistd.h>

#define SB_PORT_RESET		0x06
#define SB_PORT_READ		0x0a
#define SB_PORT_STATUS		0x0c
#define SB_PORT_COMMAND		0x0c
#define SB_PORT_DATA_AVAIL	0x0e

#define SB_DSP_GALAXY		9
#define GALAXY_DSP_MPU		2
#define GALAXY_DSP_MPUA		4

#define GALAXY_PORT_CONFIG		0x400

#define GALAXY_CONFIG_MPU_ENABLE        (1 << 21)
#define GALAXY_CONFIG_MPUA_330          (1 << 20)

#define BUSY_LOOPS 100000

int sbdsp_reset(long int port)
{       
        int i;

        outb(1, port + SB_PORT_RESET);
        usleep(10);
        outb(0, port + SB_PORT_RESET);
        usleep(30);

        for (i = BUSY_LOOPS; i; i--)
                if (inb(port + SB_PORT_DATA_AVAIL) & 0x80) {
                        if (inb(port + SB_PORT_READ) == 0xaa)
                                return 0;
                        break;
                }

        return 1;
}

int sbdsp_command(long int port, unsigned char val)
{
        int i;

        for (i = BUSY_LOOPS; i; i--)
                if ((inb(port + SB_PORT_STATUS) & 0x80) == 0) {
                        outb(val, port + SB_PORT_COMMAND);
                        return 0;
                }

        return 1;
}

int galaxy_set(long int port, unsigned char cmd, int set)
{
        if (sbdsp_command(port, SB_DSP_GALAXY) != 0)
		return 1;

        if (sbdsp_command(port, cmd) != 0)
		return 1;

        return sbdsp_command(port, set ? 255 : 0);
}

int main(int argc, char *argv[])
{
	long int port = 0x220;
	uint32_t conf = 0x887C0101;

	unsigned char val;

	char *s;
	int c = getopt(argc, argv, "p:");

	if (c != -1) {
		if (c != 'p')
			goto usage;

		port = strtol(optarg, &s, 0);
		if (*s || (port != 0x220 && port != 0x240))
			goto usage;
	}

	if (optind < argc) {
		conf = strtol(argv[optind++], &s, 16);
		if (*s)
			goto usage;
	}
		
	if (optind < argc) {
  usage:		
		printf("usage: %s [-p <port>] [value]\n", argv[0]);
		return EXIT_FAILURE;
	}

	if (iopl(3) != 0)
		goto iopl;

	if (sbdsp_reset(port) != 0) {
		printf("could not find board\n");
		return EXIT_FAILURE;
	}

        if (galaxy_set(port, GALAXY_DSP_MPU,
			     conf & GALAXY_CONFIG_MPU_ENABLE) != 0)
		goto set;

        if (galaxy_set(port, GALAXY_DSP_MPUA,
			     conf & GALAXY_CONFIG_MPUA_330) != 0) {
  set:		
		printf("could not set board\n");
		return EXIT_FAILURE;
	}

	val = inb(port + GALAXY_PORT_CONFIG + 4);

	outb(val | 0x80, port + GALAXY_PORT_CONFIG + 4);
	usleep(100);

        outb(conf, port + GALAXY_PORT_CONFIG + 3);
        conf >>= 8;
        outb(conf, port + GALAXY_PORT_CONFIG + 2);
        conf >>= 8;
        outb(conf, port + GALAXY_PORT_CONFIG + 1);
        conf >>= 8;
        outb(conf, port + GALAXY_PORT_CONFIG);

        outb(val & 0x7f, port + GALAXY_PORT_CONFIG + 4);

	if (iopl(0) != 0) {
  iopl:
		perror ("iopl");
		return EXIT_FAILURE;
	}

	return EXIT_SUCCESS;
}

--------------060206080107020005040703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060206080107020005040703--
