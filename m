From: Nikesh <noswal@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: add kcontrol to switch regulator to
 regulated/bypass state
Date: Thu, 10 Sep 2015 11:13:42 +0100
Message-ID: <55F157D6.5000307@opensource.wolfsonmicro.com>
References: <1441707249-11259-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
 <20150908132247.GD9751@sirena.org.uk>
Reply-To: <nikesh@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150908132247.GD9751@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Nikesh.Oswal@cirrus.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Thanks for your response. The problem we had is the dapm is holding an 
instance of the regulator and we wanted to control that instance based 
on use-case. But I understand your point that we should not be exposing 
regulators to userspace but manage it in the driver itself..will have a 
re-think

Thanks,
Nikesh

On 08/09/15 14:22, Mark Brown wrote:
> On Tue, Sep 08, 2015 at 11:14:09AM +0100, Nikesh Oswal wrote:
>> When regulator is defined with SND_SOC_DAPM_REGULATOR_CONTROL_BYPASS
>> flag, then a kcontrol will be created which can be used to switch
>> regulator to regulated/bypass state. This will help to control the
>> behaviour of the regulator based on a usecase. For example voice call
>> may need a regulated voltage to acheive higher quality whereas voice
>> trigger may need bypass voltage so as to save on power.
> This is really not a good idea, moving a regulator from regulated to
> bypass without coordination with the driver is a recipie for bugs at
> best and physical damage at worst.  It's something that should be being
> done by the device driver based on the current state of the device, the
> general model is that we always drive to the lowest power state possible
> based on what the device is currently doing.  If the device is set up to
> do something that can use an unregulated supply then it should put the
> supply into bypass mode without any help from userspace.
>
> As I think we went through the last time you submitted code to the core
> it is very important that we have coherent and safe abstractions that
> result in code which does what it says.  The code in the core has to
> work coherently for everyone, just randomly punching holes through
> abstractions for system specific hacks from userspace is not going to do
> that.
