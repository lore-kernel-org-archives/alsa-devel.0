From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: alsa memory leaks
Date: Tue, 15 Oct 2002 00:13:51 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DAAD11F.2050602@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Has anyone run a diagnosis tool like "memprof" on an application that 
uses alsa for audio out ?
I recently did this, and have found that alsa is a little leaky. It is 
mainly the mixer part of alsa.
Here is an example backtrace for the call to the malloc that is never 
freed even if the application exits.
Maybe I am just missing the alsa-lib api call to free up all the memory, 
but I thought I would mention it anyway.

There are lots of these: -
Leaked 0x8106038 (12 bytes)
        [0x400157b0]
        bag_add(): /alsa-lib/src/mixer/bag.c:47
        snd_mixer_elem_attach(): /alsa-lib/src/mixer/mixer.c:88
        simple_add1(): /alsa-lib/src/mixer/simple.c:966
        simple_event_add(): /alsa-lib/src/mixer/simple.c:1029
        simple_event(): /alsa-lib/src/mixer/simple.c:1062
        hctl_event_handler(): /alsa-lib/src/mixer/mixer.c:175
        snd_hctl_throw_event(): /alsa-lib/src/control/hcontrol.c:178
        snd_hctl_load(): /alsa-lib/src/control/hcontrol.c:567
        snd_mixer_load(): /alsa-lib/src/mixer/mixer.c:448
        ao_alsa_mixer_init(): /xine-lib/src/audio_out/audio_alsa_out.c:858

Cheers
James




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
