From: Dan Tihelka <dtihelka@kky.zcu.cz>
Subject: Re: Build-in mixer
Date: Wed, 15 Oct 2003 11:15:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F8D1037.8060701@kky.zcu.cz>
References: <200310141134.h9EBYMEM002694@oud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200310141134.h9EBYMEM002694@oud>
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

Paul Davis wrote:

>perhaps you know this, but 
>
>	"an error occured"
>
>is an extremely content-free way of describing a problem.
>  
>
I am sorry. I know it. But i don't know, if it was error caused by ALSA. 
There is a part of code in audio.c in alsa-xmms-0.9 which probably 
caused the error (I add some printf there):

	if(alsa_cfg.debug)
	   printf("Starting to open device ....\n");

	if(alsa_cfg.use_user_device)
	{
	   if(alsa_cfg.debug) printf("Opening user device: --%s--\n", alsa_cfg.user_device);
	   if((err = snd_pcm_open(&alsa_pcm, alsa_cfg.user_device, SND_PCM_STREAM_PLAYBACK, SND_PCM_NONBLOCK)) < 0)
	       alsa_error("error opening alsa device: %s", err);
	}

	if(alsa_cfg.debug)
	   printf("Device opened\n");



and there is console output:

	Starting to open device ....
	Opening user device: --default--
	Xlib: unexpected async reply (sequence 0x963)!


I have no idea what kind of error it is.... But what it do, is to try open "default" device only, i suppose. And it should not caused problems, if I understand well:

>no other change is necessary. however, to do what you want, you have
>to redefine the "default" device to be a dmix device. clemens
>takashi posted within the last couple of days how to do this.
>  
>
My ~/.asoundrc file is:

	pcm.!default {
		type plug
		slave.pcm "dmix"
	}

And some lines behind #. It must be correct, because more than one 'aplay' play simultenaously (even though with "underrun!!! (...)" message).



I found other ALSA setting where hw: is used. It is called before snd_pcm_open() is called, and it looks like:

	void alsa_setup_mixer(void)
	{
        	debug("alsa_setup_mixer")

	        if(alsa_cfg.audio_card != 0)
        	   sprintf(card_id, "hw:%i", alsa_cfg.audio_card);
	

	        snd_mixer_open(&mixer, 0);
        	snd_mixer_attach(mixer, card_id);              // <------ there hw:0 is used
	        snd_mixer_selem_register(mixer, NULL, NULL);
	        snd_mixer_load (mixer);
        	snd_mixer_selem_id_malloc(&pcm_elt);

		...... and many others, i don't know, if it is important.



I found, that variable card_id is set to "hw:0" string. Is there anything else, what should i try? Because i really love to use dmix plug-in together with another applications :-)


Thank You very much,
Dan


P.S. Frank Barknecht suggested: "You might have success with running these apps in OSS-mode and useing
alsa-oss". I try it, but it only one program was able to use ALSA at the same time. 





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
