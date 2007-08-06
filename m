From: stan <stanl@cox.net>
Subject: Re: SOLVED Re: snd_pcm_hw_params_set_format fails with
 invalid argument
Date: Mon, 6 Aug 2007 09:22:01 -0700
Message-ID: <20070806092201.37bdc18e@localhost.localdomain>
References: <20070803112049.7ced76ec@localhost.localdomain>
	<20070805131041.67c04d1e@localhost.localdomain>
	<20070806090457.1ec96108@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao107.cox.net (fed1rmmtao107.cox.net [68.230.241.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 38656243DE
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Aug 2007 18:22:03 +0200 (CEST)
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao107.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
	id <20070806162202.FFZG7349.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>
	for <alsa-devel@alsa-project.org>; Mon, 6 Aug 2007 12:22:02 -0400
In-Reply-To: <20070806090457.1ec96108@localhost.localdomain>
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



On Mon, 6 Aug 2007 09:04:57 -0700
stan <stanl@cox.net> wrote:

> I downloaded the hg alsa-lib snapshot of July 14, 2007, compiled it,
> (on Fedora 7 you will have to make a link to compile,
> cd /usr/include
> ln -s python2.5 python)
> and linked my program against it.  It works again so the issue has
> been fixed in the latest version of alsa lib.  Any estimate of when
> this version will be released for public consumption?  My app is dead
> in the water with the current version of alsa, so anyone trying to
> use it will have a terrible user experience.  :-(  I want to give
> some indication of when people can expect it to start working again.
> In the meantime I'll create instructions on how to install the hg
> version to usr/local and change the library linking.
> 
> Thanks.
> 
For anyone interested, these are the formats that fail in 1.0.14 final

Value of last format 43
test of sample format 14 failed (Invalid argument)
test of sample format 15 failed (Invalid argument)
test of sample format 16 failed (Invalid argument)
test of sample format 17 failed (Invalid argument)
test of sample format 18 failed (Invalid argument)
test of sample format 19 failed (Invalid argument)
test of sample format 23 failed (Invalid argument)
test of sample format 24 failed (Invalid argument)
test of sample format 25 failed (Invalid argument)
test of sample format 26 failed (Invalid argument)
test of sample format 27 failed (Invalid argument)
test of sample format 28 failed (Invalid argument)
test of sample format 29 failed (Invalid argument)
test of sample format 30 failed (Invalid argument)
test of sample format 31 failed (Invalid argument)
Format returned (0)


and these are the formats that fail in the hg version.

Value of last format 43
test of sample format 18 failed (Invalid argument)
test of sample format 19 failed (Invalid argument)
test of sample format 23 failed (Invalid argument)
test of sample format 24 failed (Invalid argument)
test of sample format 25 failed (Invalid argument)
test of sample format 26 failed (Invalid argument)
test of sample format 27 failed (Invalid argument)
test of sample format 28 failed (Invalid argument)
test of sample format 29 failed (Invalid argument)
test of sample format 30 failed (Invalid argument)
test of sample format 31 failed (Invalid argument)
Format returned (16)

Because I am using format 16 (FLOAT64_LE), it now works.  Because
FLOAT64_BE is 17, it probably will still fail, but I have no way of
checking.  Sun? PowerPC?

Section of format enum from pcm.h

	/** Float 32 bit Little Endian, Range -1.0 to 1.0 */
	SND_PCM_FORMAT_FLOAT_LE,
	/** Float 32 bit Big Endian, Range -1.0 to 1.0 */
	SND_PCM_FORMAT_FLOAT_BE,
	/** Float 64 bit Little Endian, Range -1.0 to 1.0 */
#16     SND_PCM_FORMAT_FLOAT64_LE,
	/** Float 64 bit Big Endian, Range -1.0 to 1.0 */
	SND_PCM_FORMAT_FLOAT64_BE,
	/** IEC-958 Little Endian */
	SND_PCM_FORMAT_IEC958_SUBFRAME_LE,
	/** IEC-958 Big Endian */
	SND_PCM_FORMAT_IEC958_SUBFRAME_BE,
	/** Mu-Law */
	SND_PCM_FORMAT_MU_LAW,
	/** A-Law */
	SND_PCM_FORMAT_A_LAW,
	/** Ima-ADPCM */
	SND_PCM_FORMAT_IMA_ADPCM,
	/** MPEG */
	SND_PCM_FORMAT_MPEG,
	/** GSM */
	SND_PCM_FORMAT_GSM,
	/** Special */
	SND_PCM_FORMAT_SPECIAL = 31,
	/** Signed 24bit Little Endian in 3bytes format */
	SND_PCM_FORMAT_S24_3LE = 32,


> 
> On Sun, 5 Aug 2007 13:10:41 -0700
> stan <stanl@cox.net> wrote:
> 
> > On Fri, 3 Aug 2007 11:20:49 -0700
> > stan <stanl@cox.net> wrote:
> > 
> > > Fedora 7 upgraded alsa to 1.0.14 from RC3.  I was going to test
> > > the default device sound for my prior problem (as requested by
> > > Takashi weeks ago). Unfortunately when I try to run my app it
> > > won't start. The snd_pcm_hw_params_set_format fails when I try to
> > > use it as follows.
> > > 
> > >   err = snd_pcm_hw_params_set_access (alsa_dev, hw_params,
> > > ND_PCM_ACCESS_RW_INTERLEAVED); if (err < 0)
> > > 	{	fprintf (stderr, "cannot set access type (%s)\n",
> > > snd_strerror (err)) ; goto catch_error ;
> > > 		} ;
> > > 
> > >   err = snd_pcm_hw_params_set_format (alsa_dev, hw_params,
> > > SND_PCM_FORMAT_FLOAT64_LE); //err = snd_pcm_hw_params_set_format
> > > (alsa_dev, hw_params, SND_PCM_FORMAT_S32_LE); if (err < 0)
> > > 	{	fprintf (stderr, "cannot set sample format
> > > (%s)\n", snd_strerror (err)) ; goto catch_error ;
> > > 		} ;
> > > 
> > > 
> > > cannot set sample format (Invalid argument)
> > > 
> > > It compiles cleanly.  When I replace the SND_PCM_FORMAT_FLOAT64_LE
> > > with the S32_LE, it sets it, but of course the sound is garbage
> > > as it is still receiving doubles.
> > > 
> > > This code worked fine under RC3.
> > > Is there some change that occurred in the step from 1.0.14.rc3 to
> > > 1.0.14 that would explain the above and suggest a fix?
> > 
> > Used gdb to look at what was happening here.  It seems to succeed in
> > the alsa lib but a return value gets translated from 1 to -22.  
> > 
> > int _snd_pcm_hw_param_set(snd_pcm_hw_params_t *params,
> > 			  snd_pcm_hw_param_t var, unsigned int val,
> > int dir) { int changed;
> > 	if (hw_is_mask(var)) {
> > 		snd_mask_t *m = hw_param_mask(params, var);
> > 		if (val == 0 && dir < 0) {
> > 			changed = -EINVAL;
> > 			snd_mask_none(m);
> > 		} else {
> > 			if (dir > 0)
> > 				val++;
> > 			else if (dir < 0)
> > 				val--;
> > 			changed =
> > snd_mask_refine_set(hw_param_mask(params, var), val); }  <-- returns
> > 1, change occurred ...
> > 	if (changed) {  <-- this branch is taken
> > 		params->cmask |= 1 << var;
> > 		params->rmask |= 1 << var;
> > 	}
> > 	return changed;  <-- changed is still 1 at this point
> > }
> > 
> > 
> > In the function below, which calls the function above, gdb tells me
> > the return value, err, has been
> > optimized away when I try to check it.  When I check the return
> > value in the calling program for the function below it is -22.
> > 
> > int snd_pcm_hw_param_set(snd_pcm_t *pcm, snd_pcm_hw_params_t
> > *params, snd_set_mode_t mode,
> > 			 snd_pcm_hw_param_t var, unsigned int val,
> > int dir) { snd_pcm_hw_params_t save;
> > 	int err;
> > 	switch (mode) {
> > 	case SND_CHANGE:
> > 		break;
> > 	case SND_TRY:
> > 		save = *params;  <-- takes this branch
> > 		break;
> > 	case SND_TEST:
> > 		save = *params;
> > 		params = &save;
> > 		break;
> > 	default:
> > 		assert(0);
> > 		return -EINVAL;
> > 	}
> > 
> > err is optimized away in the code below, but must be less than zero
> > as it takes the _fail branch.  The return value from the function
> > above is 1 so it shouldn't be taking the fail branch.
> > 
> > 	err = _snd_pcm_hw_param_set(params, var, val, dir);  
> > 	if (err < 0)
> > 		goto _fail; 
> > 
> > When I ignore the return value in my program from within gdb,
> > everything runs, but the sound is incorrect (static).  And I get a
> > garbage value back.
> > 
> > Format (3157552) <-- actual value set by alsa-lib
> > Format (3157552) differs from requested (16) <-- this is
> > SND_PCM_FORMAT_FLOAT64
> > 
> > When I ignore the return value in my program with optimization (O2)
> > turned on, everything runs but the sound is incorrect (static).  
> > The value that comes back is different though.
> > 
> > Format (0) <-- actual value set by alsa-lib
> > Format (0) differs from requested (16) <-- this is
> > SND_PCM_FORMAT_FLOAT64
> > 
> > I find it hard to believe that this is a compiler optimization
> > error. It seems like the stack is becoming corrupted for just one
> > call.  All other calls succeed.
> > 
> > Has anyone a suggestion of where the error might be or a possible
> > workaround? Could invalid values in the ICE1724 driver cause this?
> > 
> > > 
> > > Thank you.
> > > 
> > > $ uname -r
> > > 2.6.22.1-41.fc7
> > > 
> > > $ cat /proc/asound/version
> > > Advanced Linux Sound Architecture Driver Version 1.0.14 (Thu May
> > > 31 09:03:25 2007 UTC).
> > > 
> > > $ ls /proc/asound/card0
> > > ice1724  id  oss_mixer  pcm0c  pcm0p  pcm1p  pcm2p
> > > 
