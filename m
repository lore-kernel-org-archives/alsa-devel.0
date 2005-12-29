From: Florian Schmidt <mista.tapas@gmx.net>
Subject: can't figure out how to send events via alsa_seq
Date: Thu, 29 Dec 2005 17:28:34 +0100
Message-ID: <20051229172834.596572c0@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id CB7C1193
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2005 17:28:34 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi,

the below example code was planned for me to be a testcase to figure out
where the timing instabilities i see with different midi sequencers come
from. So i created this little program running SCHED_FIFO at prio 98
(higher than jack, so it will not be disturbed by it, etc..), mlocking
memory, yada yada

But when i hook up the created ports to some softsynth or even a midi
monitor app i don't get anything. No event is ever sent. I must be
missing something obvious, so please enlighten me (i don't need
any steenking queue's i just want to send a midi event _now_ ):

#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <cstdlib>
#include <iomanip>

#include <pthread.h>
#include <linux/rtc.h>
#include <sys/ioctl.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <poll.h>
#include <signal.h>
#include <time.h>

#include <alsa/asoundlib.h>

#define RTC_FREQ  2048.0
#define NOTE_FREQ    1.0
#define RT_PRIO     98

int main() 
{
	int fd;

	fd = open("/dev/rtc", O_RDONLY);

	if (fd ==  -1) {
		perror("/dev/rtc");
		exit(errno);
	}

	int retval = ioctl(fd, RTC_IRQP_SET, (int)RTC_FREQ);

	if (retval == -1) {
		perror("ioctl");
		exit(errno);
	}

	std::cout << "locking memory" << std::endl;
	mlockall(MCL_CURRENT);

	// std::cout << "sleeping 1 sec" << std::endl;
	// sleep(1);

	snd_seq_t *seq_handle;

	int err, port_no;

	err = snd_seq_open(&seq_handle, "default", SND_SEQ_OPEN_OUTPUT, 0);

	if (err < 0) {
		std::cout << "error" << std::endl;
		exit(0);
	}

	std::string port_name = "midi_timer";
	// set the name to something reasonable..

	err = snd_seq_set_client_name(seq_handle, port_name.c_str());

	if (err < 0) {
		std::cout << "error" << std::endl;
		exit(0);
	}

	// this is the port others can connect to. we don't do autoconnect ourself
	err = snd_seq_create_simple_port(seq_handle, "midi_timer:output", SND_SEQ_PORT_CAP_READ|SND_SEQ_PORT_CAP_SUBS_READ, SND_SEQ_PORT_TYPE_MIDI_GENERIC);

	if (err < 0) {
		std::cout << "error" << std::endl;
		exit(0);
	}

	// on success we know our port no
	port_no = err;

	struct sched_param param;
	int policy;

	pthread_getschedparam(pthread_self(), &policy, &param);
	param.sched_priority = RT_PRIO;
	policy = SCHED_FIFO;
	pthread_setschedparam(pthread_self(), policy, &param);
	

	std::cout << "turning irq on" << std::endl;
	retval = ioctl(fd, RTC_PIE_ON, 0);

	if (retval == -1) {
		perror("ioctl");
		exit(errno);
	}

	snd_seq_event_t ev;

	unsigned long data;
	
	int ticks_passed = 0;

	while(1) {
		// then we read it
		retval = read(fd, &data, sizeof(unsigned long));
		if (retval == -1) {
			perror("read");
			exit(errno);
		}
		if ((float)ticks_passed >= (RTC_FREQ/NOTE_FREQ)) {
			std::cout << "play note" << std::endl;
			ticks_passed -= (long int)(RTC_FREQ/NOTE_FREQ);

			// play note
			snd_seq_ev_clear(&ev);
			snd_seq_ev_set_direct(&ev);
			snd_seq_ev_set_source(&ev, port_no);
			ev.type = SND_SEQ_EVENT_NOTEON;
			ev.data.note.note = 53;
			ev.data.note.velocity = 100;
			
			snd_seq_event_output_direct(seq_handle, &ev);

			snd_seq_drain_output(seq_handle);
		}
		data = (data >> 8);
		// std::cout << data << std::endl;
		ticks_passed += data;
	}
	return 0;
}


-- 
Palimm Palimm!
http://tapas.affenbande.org


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
