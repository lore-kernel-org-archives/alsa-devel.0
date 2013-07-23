From: Daniel Mack <zonque@gmail.com>
Subject: Re: Ambiguous DAPM widget names and DPCM
Date: Tue, 23 Jul 2013 17:34:59 +0200
Message-ID: <51EEA2A3.8030106@gmail.com>
References: <51EE3F18.3030207@gmail.com> <20130723123017.GV9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f48.google.com (mail-ee0-f48.google.com [74.125.83.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E9E12650B8
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 17:34:38 +0200 (CEST)
Received: by mail-ee0-f48.google.com with SMTP id b47so4530510eek.7
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 08:34:38 -0700 (PDT)
In-Reply-To: <20130723123017.GV9858@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 23.07.2013 14:30, Mark Brown wrote:
> On Tue, Jul 23, 2013 at 10:30:16AM +0200, Daniel Mack wrote:
> 
>> DPCM uses DAPM widgets and routes in order to determine the FE <-> BE
>> connections at runtime. The problem with this is that widget names are
>> very ambiguous, as the automatically created widgets for DAIs are named
>> after their stream_name properties, which contain "Playback" or
>> "Capture" for all components in my case. Hence, the code which walks the
> 
> Could you go into more detail about the ambiguity you see here?

I have a platform which has two codecs (cs4271, ak4101) connected to one
McASP instance. For DPCM, the link structure looks like this:

  mcasp <-> snd-soc-dummy, .dynamic = 1
  mcasp <-> cs4271, .no_pcm = 1
  mcasp <-> ak4101, .no_pcm = 1

With printk() in snd_soc_dapm_new_control(), I see the following widgets
being created during boot (one pair for each Codec, and two pairs for
the platform dai):

[    1.963501]  snd_soc_dapm_new_control() ceb6b680 name Playback
[    1.971739]  snd_soc_dapm_new_control() ceb6b5c0 name Capture
[    1.996001]  snd_soc_dapm_new_control() ceb6b500 name Playback
[    2.004354]  snd_soc_dapm_new_control() ceb6b440 name Capture
[    2.019684]  snd_soc_dapm_new_control() ceb6b380 name Playback
[    2.028053]  snd_soc_dapm_new_control() ceb6b2c0 name Capture
[    2.047526]  snd_soc_dapm_new_control() ceb6b200 name Playback
[    2.055846]  snd_soc_dapm_new_control() ceb6b140 name Capture
[    2.071168]  snd_soc_dapm_new_control() ceb6b080 name Playback
[    2.079461]  snd_soc_dapm_new_control() ceb8ff00 name Capture

And the widgets referenced by the audio map will hence have to be named
"Playback" or "Capture" as well, which has no chance to refer to the
correct one, right?

>> I hacked the names of all components so they are unique, but even then,
> 
> This is obviously required, yes - just as with everything else you
> shouldn't use the same name twice.

Yeah, but snd_soc_dapm_new_dai_widgets() relies on
dai->driver->playback.stream_name and takes that as widget name. So is
this approach faulty, and the automatically generated name would need to
be based on dev_name(dai->dev)? Or do we need to clean up all drivers in
order to make their streams unique? Then again, the question is how to
deal with multiple instances of the same dai driver, and how to tell
them apart in the audio map.

>> the problem is that snd_soc_dapm_new_dai_widgets() is called twice for
>> the CPU DAI, once from soc_probe_platform(), and later from
>> soc_probe_link_dais(), and both calls would create DAPM widgets with
>> identical names, resulting in the same problem as described above.
> 
> The theory here is that the CPUs should be converted into components and
> then have the DAIs instantiated at component probe time - the creation
> at link time is there as a crutch for older drivers.

Which older driver would rely on that, and can we safely remove it?

>> I don't know how to handle this, but I believe that nobody was really
>> hit by this issue yet, as DPCM doesn't seem to be used widely, at least
>> not by any machine code in mainline.
> 
> Yes, there's zero use in mainline.  I don't think this code has ever
> been tested.

No problem. I think it's a really essential feature which just needs
some fixups and explanation ...


Daniel
