From: Anders Gnistrup <agn@datarespons.dk>
Subject: What is wrong in this code.
Date: Tue, 18 Oct 2011 15:18:16 +0200
Message-ID: <C516192DA6D2B74F8192CDC209D958FD5830652574@dr-mail>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.datarespons.com (mailgw01.datarespons.com
	[81.0.189.39]) by alsa0.perex.cz (Postfix) with ESMTP id 9D65A10390D
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 15:18:19 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello

I have some code, which I just can figure out why it is not working.

I have tried ti varify this using amixer.
agn@agn-HP-EliteBook-2540p:~/laerdal/audio-pulse2alsa/system/vs2-system/bu/var/lib/alsa$ amixer -Dhw:0 cget numid=23
numid=23,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---RW-,values=2,min=0,max=255,step=0
  : values=100,200
  | dBscale-min=-51.00dB,step=0.20dB,mute=0

Ofcourse I can use the "cset" command to set the volumes. No problem.

Now, I would like to do this in code. Listed below.
The code works just as expected when using the: 
    snd_ctl_elem_id_set_name(id, "PCM Playback Volume"); 
Should be similar to "amixer -c0 cset name='PCM Playback Volume' 100,200"
But when I use the snd_ctl_elem_id_set_numid(id, numid); (with numid=23) it fails. snd_hctl_find_elem simply does not find the element!

The version I use is 1.0.24. I have looked into the amixer.c source code, and it works.
So I gees i am just missing a tiny option to make it work, but I hust can't figure out which one!

#include <errno.h>
#include <assert.h>
#include <alsa/asoundlib.h>
#include <sys/poll.h>


int main()
{
	snd_hctl_t *hctl;
	snd_ctl_elem_id_t *id;
	int err;
	unsigned int numid = 23;

	err = snd_hctl_open(&hctl, "hw:0", 0);
	err = snd_hctl_load(hctl);

	snd_ctl_elem_id_alloca(&id);
	snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);

	//snd_ctl_elem_id_set_numid(id, numid);
	snd_ctl_elem_id_set_name(id, "PCM Playback Volume");

	snd_hctl_elem_t *elem = snd_hctl_find_elem(hctl, id);
	if (elem != NULL)
	{
		snd_ctl_elem_value_t *control;
		snd_ctl_elem_value_alloca(&control);
		snd_ctl_elem_value_set_id(control, id);

		snd_ctl_elem_value_set_integer(control, 0, 100);
		err = snd_hctl_elem_write(elem, control);

		snd_ctl_elem_value_set_integer(control, 1, 200);
		err = snd_hctl_elem_write(elem, control);
	}
	else
		printf("Cound not find elem.\n");
	snd_hctl_close(hctl);



}
