From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 0/2] amidi: fix handling of ignored
	messages
Date: Sun, 14 Aug 2016 19:19:46 +0900
Message-ID: <37ea9554-6954-5e5c-2843-7c8c4d884131@sakamocchi.jp>
References: <ac3f1f9a-5201-7a98-e659-fd9bbcf41ab7@ladisch.de>
 <bde1ef45-8255-5ca7-01fc-5dbf0b8f3684@ladisch.de>
 <b630d5ab-da0d-d92f-010b-b8c8e4698be7@sakamocchi.jp>
 <7982b196-edae-3330-86a8-83338e182f3e@sakamocchi.jp>
 <7105f8ec-be96-04af-45b0-e86326e1cf62@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 6FDE0265964
 for <alsa-devel@alsa-project.org>; Sun, 14 Aug 2016 12:19:52 +0200 (CEST)
In-Reply-To: <7105f8ec-be96-04af-45b0-e86326e1cf62@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Aug 13 2016 23:40, Clemens Ladisch wrote:
> Clemens Ladisch (2):
>       amidi: ignore not only Active Sensing but also Clock bytes
>       amidi: fix timeout handling
> 
> v2: fix short_options
> 
>  amidi/amidi.1 |   19 ++++++++---
>  amidi/amidi.c |   84 ++++++++++++++++++++++++++++++++++++++------------
>  2 files changed, 79 insertions(+), 24 deletions(-)

Reviewd-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

I tested these patches with loopbacked MIDI interface and this program.
Then, This command finishes as expected.
$ ./amidi -p hw:1,0,0 -d -t 5

-------- 8< --------

#include <stdio.h>
#include <stdlib.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <stdint.h>
#include <unistd.h>

int main(void)
{
        int fd;
        uint8_t buf = 0xfe;

        fd = open("/dev/snd/midiC1D0", O_WRONLY);
        if (fd < 0) {
                return EXIT_FAILURE;
        }

        while (write(fd, &buf, sizeof(buf)) > 0)
                ;

        close(fd);

        return EXIT_FAILURE;
}

-------- 8< --------


Regards

Takashi Sakamoto
