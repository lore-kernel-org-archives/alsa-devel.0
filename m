From: Miguel Duarte <mjrduarte@mail.telepac.pt>
Subject: Audigy 2 Platinum eX Remote (Some developer please read this)
Date: Wed, 24 Sep 2003 10:36:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030924093645.NWH9998.fep06-svc.mail.telepac.pt@[127.0.0.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi,

Until now I wasn't able to make my remote work.
While posting in the EMU10K1 devel mailing list, someone said that it was necessary to "initialize" the MIDI device used by the remote. A SysEx sequence has to be send to '/dev/snd/midiC0D1'. The sequence is '0xf0, 0x00, 0x20,0x21, 0x61, 0x0, 0x00, 0x00, 0x7f, 0x0, 0xf7'.

The source code bellow is of a program that does just that. After modprobing the modules with the correct options (the options are the same as the Platinum), just run this prog to "initialize" the midi device. Voi-lá! The remote works! I think this is an ugly hack. I'm sure that this can be implemented in the driver itself. Remember that this "initialization" is only required by the Audigy 2 Platinum eX.


Hope this helps.



Miguel Duarte



--------------Start code-------------------

//
// Programmer:    Craig Stuart Sapp [craig@ccrma.stanford.edu]
// Creation Date: Mon Dec 21 18:00:42 PST 1998
// Last Modified: Mon Dec 21 18:00:42 PST 1998
// Filename:      ...linuxmidi/output/method1.c
// Syntax:        C
// $Smake:        gcc -O -o devmidiout devmidiout.c && strip devmidiout
//

#include <linux/soundcard.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>

int main(void) {
   char* device =  "/dev/snd/midiC0D1" ;
   unsigned char data[11] = {0xf0, 0x00, 0x20, 0x21, 0x61, 0x0, 0x00, 0x00, 
0x7f, 0x0, 0xf7};

   // step 1: open the OSS device for writing
   int fd = open(device, O_WRONLY, 0);
   if (fd < 0) {
      printf("Error: cannot open %s\n", device);
      exit(1);
   }

   // step 2: write the MIDI information to the OSS device
   write(fd, data, sizeof(data));

   // step 3: (optional) close the OSS device
   close(fd);

   return 0;
}

--------------End code-------------------



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
