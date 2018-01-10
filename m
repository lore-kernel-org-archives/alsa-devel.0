From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [ANNOUNCE] SOF 1.0 Release
Date: Wed, 10 Jan 2018 09:08:24 +0100
Message-ID: <06f9354e-99cb-6324-12e9-e184fad78d25@perex.cz>
References: <1515525458.1844.203.camel@linux.intel.com>
 <s5ha7xmyx7m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5ha7xmyx7m.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "sound-open-firmware@alsa-project.org" <sound-open-firmware@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 10.1.2018 v 08:44 Takashi Iwai napsal(a):
> On Tue, 09 Jan 2018 20:17:38 +0100,
> Liam Girdwood wrote:
>>
>> I'd like to announce the 1.0 release of Sound Open Firmware (SOF) is
>> available for download on git.alsa-project.org. 
>>
>> SOF is an open source BSD licensed audio DSP firmware that currently
>> runs on Cadence xtensa architecture DSPs found on Intel Baytrail,
>> Braswell and Cherrytrail based devices, however SOF is architecture and
>> platform independent meaning it's not tightly coupled to xtensa DSPs or
>> Intel CPUs/SoCs.
>>
>> The 1.0 release supports limited playback and capture topologies
>> alongside volume, mixing and sample format conversion.
>>
>> Information about SOF can be found on the ALSA SOF wiki here :-
>>
>> https://www.alsa-project.org/main/index.php/Firmware
>>
>> Development for SOF 1.1 has started which will include support for
>> Haswell, Broadwell and Apollolake platform alongside support for SRC
>> and more complex topologies.
> 
> Do you plan for a classical tarball release, or it's only over git
> repo?  I'm asking it since I'm considering to package for distro.

I can create and host the tarballs on alsa-project.org. Liam, could you
add missing pieces to Makefile.am for 'make dist'?

					Thanks,
						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
