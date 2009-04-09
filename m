From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: question on hardware
Date: Thu, 9 Apr 2009 13:06:38 +0530
Message-ID: <98769532B4BB14429434178695419EAE447BADFA@bgsmsx501.gar.corp.intel.com>
References: <20081205165341.GA21294@rakim.wolfsonmicro.main>
	<1228496062-21379-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE26861315@bgsmsx501.gar.corp.intel.com>
	<75b66ecd0812052058r36ed20fdo3dc6e40ac23339bf@mail.gmail.com>
	<98769532B4BB14429434178695419EAE268614A1@bgsmsx501.gar.corp.intel.com>
	<493E31E3.2080504@ladisch.de>
	<98769532B4BB14429434178695419EAE268E0FA6@bgsmsx501.gar.corp.intel.com>
	<1228826665.6119.17.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id E52C11037EC
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Apr 2009 09:37:52 +0200 (CEST)
In-Reply-To: <1228826665.6119.17.camel@obelisk.thedillows.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, David Dillow <dave@thedillows.org>, Lee Revell <rlrevell@joe-job.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi ,

I need more help here. I tried looking at the .conf file but I have another requirement here. 

Let me put my requirements here. Please suggest me ways to get this done

1. When I get a .prepare call in my driver, I need to know the stream type
2. When I return from that call, I need to send to the user the locally allocated stream id

This is specific to the sound card/ DSP I am developing the driver for. The application is also proprietary.  Is this possible at all? Please suggest me ways to do the same.

Thanks,
Harsha

>-----Original Message-----
>From: David Dillow [mailto:dave@thedillows.org]
>Sent: Tuesday, December 09, 2008 6:14 PM
>To: Harsha, Priya
>Cc: Clemens Ladisch; alsa-devel@alsa-project.org; Lee Revell
>Subject: Re: [alsa-devel] question on hardware mixing
>
>On Tue, 2008-12-09 at 14:25 +0530, Harsha, Priya wrote:
>> If I define mixer controls to switch between each substream, I would
>> not be able to handle multiple streams at time....
>
>Check into the ALSA configuration file syntax -- there are number of
>things you can do there, like define a 'voice' device that uses hooks to
>set a control setting (snd_kcontrol) when you open a PCM. You can use
>that control setting to let your driver know if the PCM channel is being
>used for voice or audio traffic.
>
>Look at how the EMU10K1 handles surround sound audio
>in /etc/alsa/cards/EMU10K1.conf
>
>I started to do some similar things for sis7019 surround sound, but
>they've never made it out of my office due to lack of time/testing HW.
>
>> I had asked this in my earlier follow up email as well - can I use
>> snd_pcm_t->private_data to communicate if it's a voice or audio
>> I understand this private_data gets copied to substream->private data
>> which will reach the driver...
>> Am I right here?
>
>I can't answer this specifically, but I believe the answer is in the
>name -- 'private'. This is for the ALSA system to use, you can hang your
>own data off a substream using snd_pcm_substream_chip(). Besides, how do
>you plan on setting it in the snd_pcm_t type?
>
>I think that if you set up some controls, use the config file language,
>and have your audio apps open a 'voice' device, you can get where you
>want.
>
>Dave
