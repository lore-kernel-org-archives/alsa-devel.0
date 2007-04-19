From: "nick smethurst" <nick.smethurst@gmail.com>
Subject: alsa-lib functions reporting conflicting information
	with two sound cards
Date: Thu, 19 Apr 2007 16:30:37 +0200
Message-ID: <560009e30704190730q1047b43fh37f5df5fef9ec51f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B91B24590
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2007 16:30:40 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c18so473374anc
	for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2007 07:30:38 -0700 (PDT)
Content-Disposition: inline
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

Hey guys

I am rather confused that I am getting crossed information when
calling snd_names_list
and snd_pcm_info in order to gather information about pcm devices.

I have two sound cards in my development pc: RME Digi 96/8 PCI and an
onboard VIA 8237.

I'm trying to develop a piece of code that generates a list of objects
containing pcm device information, including information on virtual
devices.

My current idea is to use snd_names_list() to get a full list of
devices, and then get information about them by opening each device
and querying.

The bizzare thing is that snd_names_list() is returning comments that
do not agree with the associated device.

For example, given the following code:

#include <alsa/asoundlib.h>
int main()
{
    snd_devname_t * list;
    snd_config_update();

    snd_names_list("pcm", &list);
    while (list) {
        if (!strcmp(list->name, "hw:0,0")) {
            printf("hw:0,0 comment: %s\n", list->comment);
            break;
        }
        list = list->next;
    }
    snd_names_list_free(list);

    snd_pcm_t * pcm;
    snd_pcm_info_t * pcm_info;
    snd_pcm_info_malloc(&pcm_info);
    snd_pcm_open(&pcm, "hw:0,0", SND_PCM_STREAM_PLAYBACK, 0);
    snd_pcm_info(pcm, pcm_info);
    printf("id: %s\n", snd_pcm_info_get_id(pcm_info));
    snd_pcm_close(pcm);
    snd_pcm_info_free(pcm_info);

    return 0;
}

The result on my pc is:
    hw:0,0 comment: Physical Device - VIA 8237 (Duplex)
    id: Digi96 IEC958

So I'm apparently doing something very wrong here.

I would like to ask if there is an easier and more reliable way of
getting a list of pcm devices and querying them, and if not, what I am
doing wrong here?

Regards

Nicholas
