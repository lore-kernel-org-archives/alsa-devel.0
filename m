From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer dereference
 in soc_find_component
Date: Thu, 24 Jan 2019 13:07:17 -0600
Message-ID: <976ec85a-7b21-6c58-90cc-a3d104f9505a@linux.intel.com>
References: <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
 <CAOReqxjhZAzOpr-bGcV6uxPsOEid--Ym2Y0YZMHkybgZSePvtQ@mail.gmail.com>
 <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com>
 <c6721670-cf89-5d21-953d-c1fa10d87367@linux.intel.com>
 <CAOReqxgG4TJDXKCEVcDVXvpi_mnLUzqLwF7Rp0H5iAPdbMuZ_Q@mail.gmail.com>
 <44029078-2749-5a3b-7b03-f38461bf268f@linux.intel.com>
 <20190124184412.GH5641@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124184412.GH5641@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, lgirdwood@gmail.com, Curtis Malainey <cujomalainey@google.com>, plai@codeaurora.org, linux-kernel@vger.kernel.org, Ajit Pandey <ajitp@codeaurora.org>, tiwai@suse.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Matthias Reichl <hias@horus.com>, Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org, srinivas.kandagatla@linaro.org, Curtis Malainey <cujomalainey@chromium.org>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org


>> changes are legitimate. To move forward, maybe it's not worth spending too
>> much time on a grand unification of string theory, there are simpler
>> solutions: the Intel machine drivers already do get the platform driver name
>> as an platform_data argument, so we could modify the dailinks platform names
>> before even registering the card. I tested with the attached
> Yes, that would be much better - it's vastly more idiomatic.  The
> general idea is that a machine driver should know what it's expecting to
> find before it starts probing.

Thanks for the feedback, will send a formal patch with the helper and 
machine driver changes after I test more with the legacy drivers. Do you 
have a preference for one patch that deals with multiple machines 
drivers in one shot, or individual patches? The latter are nicer for 
backports (e.g. for Chrome), the former nicer for maintainers...

The goal of reusing machine drivers as is isn't really achievable 
anyways, it looks like we are going to have additional changes, e.g. if 
we want to avoid the calls to snd_pcm_suspend as suggested by Takashi, 
we'll have to add a reference to snd_soc_pm_ops that's only used for 
SOF, the Atom/SST driver does things in different ways mostly due to 
historical reasons.

-Pierre
