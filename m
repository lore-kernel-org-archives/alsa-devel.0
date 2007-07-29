From: Mark Hills <mark@pogo.org.uk>
Subject: aoss never returns POLLIN
Date: Sun, 29 Jul 2007 01:08:26 +0100 (BST)
Message-ID: <Pine.BSO.4.64.0707290107100.27312@metheny.ijneb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 36D42103831
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Jul 2007 02:08:27 +0200 (CEST)
Received: from localhost ([127.0.0.1] ident=mark)
	by metheny.ijneb.com with esmtp (Exim 4.62)
	(envelope-from <mark@pogo.org.uk>) id 1IEwKg-0000Ol-G3
	for alsa-devel@alsa-project.org; Sun, 29 Jul 2007 01:08:26 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

When using the aoss wrapper, poll() is never woken by POLLIN.

This happens with devices opened in either O_RDWR or O_RDONLY and is 
demonstrated by the trivial example below, which never prints "POLLIN".

The example performs correctly using the kernel OSS emulation. Is this a 
(known) bug in aoss? I've now seen it on different distributions and in 
the latest code from the repository.

Enabling ALSA_OSS_DEBUG shows that the struct pollfd is being correctly 
manipulated:

Orig enter POLL nfds: 1, timeout: 1000
fd=3, events=d, revents=0
Changed enter POLL nfds: 2, timeout: 1000
fd=5, events=2c, revents=0
fd=6, events=29, revents=0

Changed exit POLL nfds: 2, timeout: 1000
fd=5, events=2c, revents=4
fd=6, events=29, revents=0
Orig exit POLL nfds: 1, timeout: 1000
fd=3, events=d, revents=4

The file descriptors are:

lrwx------ 1 mark users 64 Jul 29 00:46 /proc/5399/fd/3 -> /dev/null
lrwx------ 1 mark users 64 Jul 29 00:46 /proc/5399/fd/5 -> /dev/snd/pcmC0D0p
lrwx------ 1 mark users 64 Jul 29 00:46 /proc/5399/fd/6 -> /dev/snd/pcmC0D0c

The pass through to the _poll() call inside poll_with_pcm() in alsa-oss.c 
isn't being woken by POLLIN for the capture device.

Mark


#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/poll.h>
#include <sys/soundcard.h>

#define CHANNELS 2
#define SAMPLES 64

int main(int argc, char *argv[]) {
      int fd, p, r;
      struct pollfd pe;
      char buf[CHANNELS * SAMPLES];

      /* Change below to O_RDWR, O_RDONLY or O_WRONLY */

      fd = open("/dev/dsp", O_RDWR, 0);
      if(fd == -1) {
          perror("open");
          return -1;
      }

      p = AFMT_S16_LE;
      if(ioctl(fd, SNDCTL_DSP_SETFMT, &p) == -1) {
          perror("SNDCTL_DSP_SETFMT");
          return -1;
      }

      p = CHANNELS;
      if(ioctl(fd, SNDCTL_DSP_CHANNELS, &p) == -1) {
          perror("SNDCTL_DSP_CHANNELS");
          return -1;
      }

      p = 44100;
      if(ioctl(fd, SNDCTL_DSP_SPEED, &p) == -1) {
          perror("SNDCTL_DSP_SPEED");
          return -1;
      }

      if(fcntl(fd, F_SETFL, O_NONBLOCK) == -1) {
          perror("fcntl");
          return -1;
      }

      pe.fd = fd;
      pe.events = POLLERR | POLLIN | POLLOUT;

      for(;;) {
          fputs("poll", stderr);

          pe.revents = 0;
          poll(&pe, 1, 1000);

          if(pe.revents & POLLOUT) {
              fputs(" POLLOUT", stderr);
              r = write(fd, buf, CHANNELS * SAMPLES);
              if(r == -1 && errno != EAGAIN) {
                  perror("read");
                  return -1;
              }
          }

          if(pe.revents & POLLIN) {
              fputs(" POLLIN", stderr);
              r = read(fd, buf, CHANNELS * SAMPLES);
              if(r == -1 && errno != EAGAIN) {
                  perror("read");
                  return -1;
              }
          }

          fputc('\n', stderr);
      }

      close(fd);
      return 0;
}
