From: "John L. Utz III" <john.utz@dmx.com>
Subject: Some good progress,
 but...Re: using 'type softvol' in a card conf file in
 /usr/share/alsa/cards, am i doing this right?
Date: Tue, 5 Jun 2007 10:47:44 -0700
Message-ID: <20070605104744.2216e6be@jutz-fc6.na.corp.dmxmusic.com>
References: <20070604152306.61bb6a2b@jutz-fc6.na.corp.dmxmusic.com>
	<s5hwsyi65p7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 33FB624435
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2007 19:45:13 +0200 (CEST)
In-Reply-To: <s5hwsyi65p7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thankyou for your response Takashi!

On Tue, 05 Jun 2007 12:44:52 +0200
"Takashi Iwai" <tiwai@suse.de> wrote:

> At Mon, 4 Jun 2007 15:23:06 -0700,
> John L. Utz III wrote:
> > 
> > Hello;
> > 
> > I am working with an CMEDIA 8738-MC6 and i am trying to gain
> > control of the second DAC by way of softvolume.
> > i have modified it to look thusly:
> > 
> > # 2nd DAC
> > CMI8738-MC6.pcm.rear.0 {
> >         @args [ CARD ]
> >         @args.CARD {
> >                 type string
> >         }
> >         type softvol
> >         slave.pcm {
> >                 type hw
> >                 card $CARD
> >                 device 1
> >         }
> >         control {
> >                 name "Rear Playback Volume"
> >                 card $CARD
> >         }
> > }
> The control is created first when you access this defined PCM.
> Try to open "rear" PCM first, then check amixer.
> 
> Once after a user-defined control is created, it can be saved/restored
> via alsactl save/restore command.

So i added the following code to our app and the device now shows up
in amixer, but it doesnt actually change the volume! dang!

Here's the code snippet that creates and closes the device

   if(!snd_pcm_open(&pPcm, "rear", SND_PCM_STREAM_PLAYBACK, 0))
       snd_pcm_close(pPcm);

Here's the code snippet that instantiates the mixer elemement, it used
to fail to find the 'Rear' element, but now it works:

   snd_mixer_selem_id_t  *pSndMxrSlem;

   snd_mixer_selem_id_alloca(&pSndMxrSlem);
   snd_mixer_selem_id_set_name(pSndMxrSlem, pNameElem);

   pSndMxrElemCard1 = snd_mixer_find_selem(pSndMxr, pSndMxrSlem);

Heres code that doesnt return an error, but based on the amixer output,
it doesnt actually work for the 'Rear' element. Note that it works for
the 'PCM' and 'Master' devices:

   int 
   card_setvol_alsa(int iNumCard, unsigned char ucVolLeft,
                    unsigned char ucVolRight, int iCtl) 
   {
     int   iErr = 0;
     char acLog[256] = "";
     snd_mixer_elem_t *pSndMxrElem = NULL;

     if(iCtl) pSndMxrElem =
	          iNumCard ? pSndMxrElemCard1 : pSndMxrElemCard0; 
     else     pSndMxrElem = pSndMxrElemCardV;

     if(!pSndMxrElem)
     {
       aeiu_logprint("PCMX", AEIU_LOG_INFO, "SETVOL pSndMxrElem=NULL");
       return iErr;
     }

     if((iErr = snd_mixer_selem_set_playback_volume(pSndMxrElem,
  	    					    SND_MIXER_SCHN_FRONT_LEFT,
  						    ucVolLeft)))
       goto fin;
 
     iErr = snd_mixer_selem_set_playback_volume(pSndMxrElem,
					        SND_MIXER_SCHN_FRONT_RIGHT,
					        ucVolRight);
   fin:

     if(iErr)
     {
        sprintf(acLog, "pcm_setvol_alsa: Card: %d  Failed: %s",
                iNumCard, snd_strerror(iErr));

       aeiu_logprint("PCMX", AEIU_LOG_ERROR, acLog);
     }
     return iErr;
   }


Here's the outputs: PCM, Master are great, Rear is bad

[root@DMX-98165 jutz]# amixer sget Rear
Simple mixer control 'Rear',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%]
  Front Right: Playback 0 [0%]

[root@DMX-98165 jutz]# amixer sget Master
Simple mixer control 'Master',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 20 [65%]
  Front Right: Playback 20 [65%]

[root@DMX-98165 jutz]# amixer sget PCM   
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 20 [65%] [on] Capture [off]
  Front Right: Playback 20 [65%] [on] Capture [off]

 
Can you or anybody else offer any further suggestions?

tnx!

johnu

> 
> Takashi
> 
