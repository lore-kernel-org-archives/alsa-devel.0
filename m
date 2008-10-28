From: Oliver Ford <ipaqlinux@oliford.co.uk>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Tue, 28 Oct 2008 21:51:02 +0000
Message-ID: <49078946.9030003@oliford.co.uk>
References: <48FF7538.3090000@oliford.co.uk>
	<20081023132705.GA20557@sirena.org.uk>
	<4900829A.8000703@oliford.co.uk>
	<20081023140116.GB17901@sirena.org.uk> <87mygvmci7.fsf@free.fr>
	<20081024172533.GA3328@sirena.org.uk> <87ej25ero2.fsf@free.fr>
	<20081028131031.GG9068@sirena.org.uk>
	<20081028153435.GK9068@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0.thdo.woaf.net (dog.thdo.woaf.net [213.230.192.130])
	by alsa0.perex.cz (Postfix) with ESMTP id D6A3A24544
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 22:51:06 +0100 (CET)
In-Reply-To: <20081028153435.GK9068@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Tue, Oct 28, 2008 at 01:10:31PM +0000, Mark Brown wrote:
>
>   
>> It looks like you might've been right after all.  I still can't see
>> where this makes a difference to the speaker paths but the patch below
>> seems to resolve the issues I'm seeing here.
>>     
>
>   
>> Oliver, could you test the patch below please?
>>     
>
> Gah, sorry - it doesn't help, I was masking the problem another way.
>   
Ok, well I tried it anyway and it doesn't solve the problem.

I've done a lot more tracing and think I may have found something 
relevant. I'm not entirely sure what is supposed to be happening so 
can't figure it out myself, but maybe you will know...

When turning the PCM->Speaker mixer on and off in alsamixer (before its 
broken) the mixer's widget->value seems to flick between 0x4000 and 
0x0000. After breaking it with amixer it flicks between 0x4001 and 
0x4000, both of which fire the lines:
        if (val)
            /* new connection */
            path->connect = invert ? 0:1;
in dapm_mixer_update_power().


I've put some debugging to report whats happening to path->connect in 
dapm_mixer_update_power() and this is what happens:


ON in alsamixer when working:
    +dapm_mixer_update_power(kcontrol=Speaker Mixer PCM Playback Switch, 
reg=0000000c, val=00000000, val_mask=00004001, invert=00000001)
        found path for kcontrol: name='PCM Playback Switch', 
long_name='Speaker Mixer PCM Playback Switch'
        val=false: path->connect: 0 --> 1
    -dapm_mixer_update_power()

OFF in alsamixer when working:
    +dapm_mixer_update_power(kcontrol=Speaker Mixer PCM Playback Switch, 
reg=0000000c, val=00004000, val_mask=00004001, invert=00000001)
        found path for kcontrol: name='PCM Playback Switch', 
long_name='Speaker Mixer PCM Playback Switch'
        val=true: path->connect: 1 --> 0
    -dapm_mixer_update_power()


Leaving it on in alsamixer and running the amixer on command. This happens:
    +dapm_mixer_update_power(kcontrol=Speaker Mixer PCM Playback Switch, 
reg=0000000c, val=00000001, val_mask=00004001, invert=00000001)
        found path for kcontrol: name='PCM Playback Switch', 
long_name='Speaker Mixer PCM Playback Switch'
        val=true: path->connect: 1 --> 0
    +dapm_power_widgets()

i.e it seems to turn it off?


 From then on, any further attempts to turn it on in amixer give:
    +dapm_mixer_update_power(kcontrol=Speaker Mixer PCM Playback Switch, 
reg=0000000c, val=00004001, val_mask=00004001, invert=00000001)
        found path for kcontrol: name='PCM Playback Switch', 
long_name='Speaker Mixer PCM Playback Switch'
        val=true: path->connect: 0 --> 0
    +dapm_power_widgets()

Any further off/on toggling in alsamixer once broken just results in:
    +dapm_mixer_update_power(kcontrol=Speaker Mixer PCM Playback Switch, 
reg=0000000c, val=00004001, val_mask=00004001, invert=00000001)
        found path for kcontrol: name='PCM Playback Switch', 
long_name='Speaker Mixer PCM Playback Switch'
        val=true: path->connect: 0 --> 0
    +dapm_power_widgets()
   
    +dapm_mixer_update_power(kcontrol=Speaker Mixer PCM Playback Switch, 
reg=0000000c, val=00000001, val_mask=00004001, invert=00000001)
        found path for kcontrol: name='PCM Playback Switch', 
long_name='Speaker Mixer PCM Playback Switch'
        val=true: path->connect: 0 --> 0
    +dapm_power_widgets()



Does that give you any ideas of what happening on my system?


Thanks,

Oliver
