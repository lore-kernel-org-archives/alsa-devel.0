From: "John Utz" <john.utz@dmx.com>
Subject: Re: Softvol controls
Date: Thu, 29 Nov 2007 15:46:57 -0800
Message-ID: <20071129154657.2a7a2be1@jutz-gnto64>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5htznfhmhy.wl%tiwai@suse.de>
	<20071129232859.GA18138@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 9892324368
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 00:47:18 +0100 (CET)
In-Reply-To: <20071129232859.GA18138@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Lennart!

On Fri, 30 Nov 2007 00:28:59 +0100
"Lennart Poettering" <mznyfn@0pointer.de> wrote:

> On Wed, 21.11.07 12:22, Takashi Iwai (tiwai@suse.de) wrote:
> 
> > >    Now, is there a way I can detect for a mixer element if it is
> > >    "real" or if it is implemented only for the "plughw" PCM? As it
> > >    seems the "hw:0" mixer device does contain "virtual" tracks,
> > > isn't that a bit strange? Shouldn't the virtual mixer tracks be
> > > available only in a mixer device "plughw:0"? That at least would
> > > be symmetric to the PCM case, wouldn't it?
> > 
> > Check snd_ctl_elem_info_is_user().  All softvol controls are
> > implemented as user elements.
> 
> Hmm, how am I supposed to get the snd_ctl_elem_info_t from a
> snd_mixer_elem_t or snd_mixer_selem_id_t?
> 
> I figure there is no useful documentation or even example how this is
> supposed to work? Hmm, is there any real documentation available which
> describes the relation of ctl, hctl, mixer and smixer at all? For the
> uninitated the whols structure looks overly complex and redundant.

Here's my take on it....HTH

dont hesitate to ask


// ALSA Mixer creation and manipulation routines
//
// The alsa api is pretty cool once you find a working example :-)
//  
// One first creates the mixer representation and then 1 element
// representation for each item that you need to manipulate.
// create the individual elements, ie PCM, Surround, etc

snd_mixer_elem_t *
alsa_mixer_elem_instantiate(char *pNameElem, snd_mixer_t *pSndMxr)
{
  char  acLog[256] = "";
  int    iErr      = 0;

  snd_mixer_elem_t      *pSndMxrElem;
  snd_mixer_selem_id_t  *pSndMxrSlem;

  snd_mixer_selem_id_alloca(&pSndMxrSlem);
  snd_mixer_selem_id_set_name(pSndMxrSlem, pNameElem);

  sprintf(acLog, "Initializing ALSA Mixer Element: %s", pNameElem);
  aeiu_logprint("PC18", AEIU_LOG_INFO, acLog);

  // find element based on name

  if(!(pSndMxrElem=snd_mixer_find_selem(pSndMxr, pSndMxrSlem))) goto
fin;

  // make sure they are turned on so we can hear them, not always the
case

  aeiu_logprint("PC19", AEIU_LOG_INFO, "ALSA Mixer Element Enable"  );
  if(snd_mixer_selem_has_playback_switch(pSndMxrElem))
    if((iErr=snd_mixer_selem_set_playback_switch_all(pSndMxrElem, 1)))
      goto fin;

  // configure them for the old style 0-100 oss volume range

  aeiu_logprint("PC20", AEIU_LOG_INFO, "ALSA Mixer Element Set
Range"  );

  if((iErr=snd_mixer_selem_set_playback_volume_range(pSndMxrElem, 0,
100))) goto fin;

  // set to a reasonable starting value

  aeiu_logprint("PC21", AEIU_LOG_INFO, "ALSA Mixer Element Set
Volume"  );

  if((iErr=snd_mixer_selem_set_playback_volume_all(pSndMxrElem, 65)))
goto fin;

 fin:

  if(!pSndMxrElem || iErr)
  {
    sprintf(acLog,"alsa_mixer_elem_instantiate: %s Failed: %s\n",
pNameElem, iErr ? snd_strerror(iErr) : "Mixer Device Not Found");
    aeiu_logprint("PC22", AEIU_LOG_ERROR, acLog);
  }

  return pSndMxrElem;
}


int
alsa_mixer_instantiate()
{
  int    iErr        = 0;
  char *pcNameDevMxr = "default";

  aeiu_logprint("PC23", AEIU_LOG_INFO, "Initializing ALSA Mixer");

  if(gpSndMxr)
  {
    aeiu_logprint("PC24", AEIU_LOG_ERROR,"alsa_mixer_instantiate:
pSndMxr!=NULL"); iErr=1;
    goto fin;
  }

  if((iErr = snd_mixer_open(&gpSndMxr, 0)))                   goto fin;

  if((iErr = snd_mixer_attach(gpSndMxr, pcNameDevMxr)))       goto fin;
   
  if((iErr = snd_mixer_selem_register(gpSndMxr, NULL, NULL))) goto fin;

  if((iErr = snd_mixer_load(gpSndMxr)))                       goto fin;

  // mixer device is now live, create the control elements, note that
  // we dont error check here because we do it in the function and we
  // dont want to break execution flow here if we fail for some reason
  // (rather have 2 channels than no channels!)

  gpSndMxrElemCrdV = alsa_mixer_elem_instantiate("PCM",      gpSndMxr);

  gpSndMxrElemCrd0 = alsa_mixer_elem_instantiate("Master",   gpSndMxr);
 
  gpSndMxrElemCrd1 = alsa_mixer_elem_instantiate("Surround", gpSndMxr);

  // this exists only for a function called pcm_lowervolumes()

  gpSndMxrElemCrdM = alsa_mixer_elem_instantiate("Mic",      gpSndMxr);

fin:

  if(iErr)
  {
    if(gpSndMxr)
    {
      snd_mixer_close(gpSndMxr);
      gpSndMxr = NULL;
    }

    char  acLog[256] = "";
    sprintf(acLog, "alsa_mixer_instantiate: Failed: %s",
snd_strerror(iErr)); aeiu_logprint("PC25", AEIU_LOG_ERROR, acLog);
  }
  return iErr;
}




> Lennart
> 
