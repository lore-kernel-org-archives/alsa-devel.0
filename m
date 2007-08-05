From: stan <stanl@cox.net>
Subject: Re: snd_pcm_hw_params_set_format fails with invalid
	argument
Date: Sun, 5 Aug 2007 13:10:41 -0700
Message-ID: <20070805131041.67c04d1e@localhost.localdomain>
References: <20070803112049.7ced76ec@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao107.cox.net (fed1rmmtao107.cox.net [68.230.241.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 495D61038C9
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Aug 2007 22:10:45 +0200 (CEST)
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao107.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
	id <20070805201042.RYIM7349.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>
	for <alsa-devel@alsa-project.org>; Sun, 5 Aug 2007 16:10:42 -0400
In-Reply-To: <20070803112049.7ced76ec@localhost.localdomain>
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

On Fri, 3 Aug 2007 11:20:49 -0700
stan <stanl@cox.net> wrote:

> Fedora 7 upgraded alsa to 1.0.14 from RC3.  I was going to test the
> default device sound for my prior problem (as requested by Takashi
> weeks ago). Unfortunately when I try to run my app it won't start.
> The snd_pcm_hw_params_set_format fails when I try to use it as
> follows.
> 
>   err = snd_pcm_hw_params_set_access (alsa_dev, hw_params,
> ND_PCM_ACCESS_RW_INTERLEAVED); if (err < 0)
> 	{	fprintf (stderr, "cannot set access type (%s)\n",
> snd_strerror (err)) ; goto catch_error ;
> 		} ;
> 
>   err = snd_pcm_hw_params_set_format (alsa_dev, hw_params,
> SND_PCM_FORMAT_FLOAT64_LE); //err = snd_pcm_hw_params_set_format
> (alsa_dev, hw_params, SND_PCM_FORMAT_S32_LE); if (err < 0)
> 	{	fprintf (stderr, "cannot set sample format (%s)\n",
> snd_strerror (err)) ; goto catch_error ;
> 		} ;
> 
> 
> cannot set sample format (Invalid argument)
> 
> It compiles cleanly.  When I replace the SND_PCM_FORMAT_FLOAT64_LE
> with the S32_LE, it sets it, but of course the sound is garbage
> as it is still receiving doubles.
> 
> This code worked fine under RC3.
> Is there some change that occurred in the step from 1.0.14.rc3 to
> 1.0.14 that would explain the above and suggest a fix?

Used gdb to look at what was happening here.  It seems to succeed in
the alsa lib but a return value gets translated from 1 to -22.  

int _snd_pcm_hw_param_set(snd_pcm_hw_params_t *params,
			  snd_pcm_hw_param_t var, unsigned int val, int dir) {
	int changed;
	if (hw_is_mask(var)) {
		snd_mask_t *m = hw_param_mask(params, var);
		if (val == 0 && dir < 0) {
			changed = -EINVAL;
			snd_mask_none(m);
		} else {
			if (dir > 0)
				val++;
			else if (dir < 0)
				val--;
			changed =
snd_mask_refine_set(hw_param_mask(params, var), val); }  <-- returns 1, change occurred
 ...
	if (changed) {  <-- this branch is taken
		params->cmask |= 1 << var;
		params->rmask |= 1 << var;
	}
	return changed;  <-- changed is still 1 at this point
}


In the function below, which calls the function above, gdb tells me the 
return value, err, has been
optimized away when I try to check it.  When I check the return value 
in the calling program for the function below it is -22.

int snd_pcm_hw_param_set(snd_pcm_t *pcm, snd_pcm_hw_params_t *params,
			 snd_set_mode_t mode,
			 snd_pcm_hw_param_t var, unsigned int val, int dir) {
	snd_pcm_hw_params_t save;
	int err;
	switch (mode) {
	case SND_CHANGE:
		break;
	case SND_TRY:
		save = *params;  <-- takes this branch
		break;
	case SND_TEST:
		save = *params;
		params = &save;
		break;
	default:
		assert(0);
		return -EINVAL;
	}

err is optimized away in the code below, but must be less than zero
as it takes the _fail branch.  The return value from the function above
is 1 so it shouldn't be taking the fail branch.

	err = _snd_pcm_hw_param_set(params, var, val, dir);  
	if (err < 0)
		goto _fail; 

When I ignore the return value in my program from within gdb, everything runs, 
but the sound is incorrect (static).  And I get a garbage value back.

Format (3157552) <-- actual value set by alsa-lib
Format (3157552) differs from requested (16) <-- this is SND_PCM_FORMAT_FLOAT64

When I ignore the return value in my program with optimization (O2) turned on,
everything runs but the sound is incorrect (static).  
The value that comes back is different though.

Format (0) <-- actual value set by alsa-lib
Format (0) differs from requested (16) <-- this is SND_PCM_FORMAT_FLOAT64

I find it hard to believe that this is a compiler optimization error.
It seems like the stack is becoming corrupted for just one call.  All
other calls succeed.

Has anyone a suggestion of where the error might be or a possible workaround?
Could invalid values in the ICE1724 driver cause this?

> 
> Thank you.
> 
> $ uname -r
> 2.6.22.1-41.fc7
> 
> $ cat /proc/asound/version
> Advanced Linux Sound Architecture Driver Version 1.0.14 (Thu May 31
> 09:03:25 2007 UTC).
> 
> $ ls /proc/asound/card0
> ice1724  id  oss_mixer  pcm0c  pcm0p  pcm1p  pcm2p
> 
