From: Carlo Wood <carlo@alinoe.com>
Subject: Bug in OSS simulation (ALSA 0.9.4)
Date: Thu, 10 Jul 2003 03:33:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030710013326.GA12086@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
List-Id: alsa-devel@alsa-project.org

I pinpointed the problem and wrote a small program
to illustrate the problem.

When compiling the program given below with:

  gcc -DUSE_DSP_SETFMT=0 troep.c

it runs fine.

But, when compiling it with:

  gcc -DUSE_DSP_SETFMT=1 troep.c

It stops rather quickly with reading data.

Example output of the latter:

~>a.out
Fragment size: 1024
Number of fragments: 32767
Number of channels: 1
Sample rate: 22050
Read 1024 bytes.
Number of full fragments that can be read or written without blocking: 0
Total number of fragments allocated for buffering: 2
Size of a fragment in bytes: 1024
Number of bytes that can be read or written immediately without blocking: 0
#fragments, #bytes: 0, 0
#fragments, #bytes: 1, 1632
Read 1024 bytes.
#fragments, #bytes: 2, 2048
Read 1024 bytes.
#fragments, #bytes: 1, 1024
Read 1024 bytes.
#fragments, #bytes: 0, 0
#fragments, #bytes: 0, 0
#fragments, #bytes: 0, 0
...etc

-- 
Carlo Wood <carlo@alinoe.com>


The program:


#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <linux/soundcard.h>
#include <time.h>

int main(void)
{
  int res;
  char buf[1024];

  int fd = open("/dev/dsp", O_RDONLY);
  if (fd == -1)
  {
    perror("open");
    exit(1);
  }

  res = 0x7fff000a;
  if (ioctl(fd, SNDCTL_DSP_SETFRAGMENT, &res) == -1)
  {
    perror("ioctl");
    exit(1);
  }
  printf("Fragment size: %d\n", 1 << (res & 0xffff));
  printf("Number of fragments: %d\n", res >> 16);

#if USE_DSP_SETFMT
  res = AFMT_S16_LE;
  if (ioctl(fd, SNDCTL_DSP_SETFMT, &res) == -1)
  {
    perror("ioctl");
    exit(1);
  }
#endif

  res = 0;	// Not stereo (1 channel).
  if (ioctl(fd, SNDCTL_DSP_STEREO, &res) == -1)
  {
    perror("ioctl");
    exit(1);
  }
  printf("Number of channels: %d\n", res ? 2 : 1);

  res = 22050;
  if (ioctl(fd, SOUND_PCM_READ_RATE, 0xbfffdcfc) == -1)
  {
    perror("ioctl");
    exit(1);
  }
  printf("Sample rate: %d\n", res);

  ssize_t rlen = read(fd, buf, sizeof(buf));
  if (rlen <= 0)
  {
    perror("read");
    exit(1);
  }
  printf("Read %d bytes.\n", rlen);

  audio_buf_info info;

  if (ioctl(fd, SNDCTL_DSP_GETISPACE, &info) == -1)
  {
    perror("read");
    exit(1);
  }
  printf("Number of full fragments that can be read or written without blocking: %d\n", info.fragments);
  printf("Total number of fragments allocated for buffering: %d\n", info.fragstotal);
  printf("Size of a fragment in bytes: %d\n", info.fragsize);
  printf("Number of bytes that can be read or written immediately without blocking: %d\n", info.bytes);

  int i;
  for (i = 0; i < 100; ++i)
  {
    if (ioctl(fd, SNDCTL_DSP_GETISPACE, &info) == -1)
    {
      perror("read");
      exit(1);
    }
    printf("#fragments, #bytes: %d, %d\n", info.fragments, info.bytes);
    if (info.fragments > 0)
    {
      ssize_t rlen = read(fd, buf, sizeof(buf));
      if (rlen <= 0)
      {
	perror("read");
	exit(1);
      }
      printf("Read %d bytes.\n", rlen);
    }
    static struct timespec naptime = { 0, 100000000 };
    nanosleep(&naptime, 0);
  }

  close(fd);
  return 0;
}


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
