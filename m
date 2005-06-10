From: Gregor Jasny <jasny@vidsoft.de>
Subject: How to get CardId for pseudo soundcards like dmix and dsnoop
Date: Fri, 10 Jun 2005 16:02:04 +0200
Message-ID: <42A99D5C.5080002@vidsoft.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080507010804080602030707"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from baldur.vidconference.de (venus.vidconference.de [212.227.158.183])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 31541217
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2005 16:02:06 +0200 (MEST)
Received: from [62.206.249.2] (helo=orca)
	by baldur.vidconference.de with esmtp (Exim 3.35 #1 (Debian))
	id 1Dgk5F-0003yE-00
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2005 16:02:05 +0200
Received: from dell1 ([192.168.1.62])
	by orca with esmtp (Exim 3.35 #1 (Debian))
	id 1Dgk5F-00036V-00
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2005 16:02:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080507010804080602030707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

In my application the user can specify the pcm devices as a string (i.e. 
hw:0,0, plughw:1, dmix, default).

Now I want to open the corresponding mixer device. At the moment I fetch 
the cardid via snd_pcm_info_get_card. Then I build a string hw:<cardid> 
and attach to that string. This works fine for hw and plughw devices. 
Doing this for dmix or dsnoop devices fails because the cardid is -1.

Another way I tried is to attach to the user supplied pcm string 
directly. But this does not work for dmix and dsnoop.

How do I get the right mixer for a opened pcm device?

Thank you for answering.

Gregor

PS: I've attached a small test case

--------------080507010804080602030707
Content-Type: text/x-csrc;
 name="mixer.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mixer.c"


#include <stdio.h>
#include <stdlib.h>

#include <alsa/asoundlib.h>



int main (int argc, char *argv[])
{
	snd_pcm_t *pcm;
	snd_mixer_t *mixer;
	int err;
	int incoming = 1;
	snd_pcm_info_t *pcm_info;
	int cardid;
	char dev[64];

	if (argc < 2)
		exit (EXIT_FAILURE);
	
	if ((err = snd_pcm_open (&pcm,
	                         argv[1],
	                         (incoming?SND_PCM_STREAM_CAPTURE:SND_PCM_STREAM_PLAYBACK),
	                         SND_PCM_NONBLOCK)) < 0) {
		fprintf (stderr, "Can not determine card id: %s (%s)\n", argv[1], snd_strerror (err));
		return EXIT_FAILURE;
	}

	snd_pcm_info_alloca(&pcm_info);
	if ((err = snd_pcm_info( pcm, pcm_info )) < 0) {
        	fprintf (stderr, "Can not get pcm info: %s (%s)\n", argv[1], snd_strerror (err));
		snd_pcm_close(pcm);
		return EXIT_FAILURE;
	}

	cardid = snd_pcm_info_get_card( pcm_info );

	printf ("CardId: %i\n", cardid);

	sprintf(dev, "hw:%i", cardid); /* Option 1 */
//	strcpy (dev, argv[1]); /* Option 2 */

	if ((err = snd_mixer_open(&mixer, 0)) < 0) {
		fprintf (stderr, "snd_open_mixer(): %s\n", snd_strerror(-err));
		return EXIT_FAILURE;
	}
	if ((err = snd_mixer_attach(mixer, dev)) < 0) {
		fprintf (stderr, "snd_mixer_attach(%s): %s\n", dev, snd_strerror(-err));
		return EXIT_FAILURE;
	}
	printf("Attached to mixer: %s\n", dev);
	
	return EXIT_SUCCESS;
}

--------------080507010804080602030707--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
