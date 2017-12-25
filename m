From: Bard Liao <bardliao@realtek.com>
Subject: Re: Cherry Trail + RT5645 devices analog microphone
	not working.
Date: Mon, 25 Dec 2017 02:15:16 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7027476BE@RTITMBSV02.realtek.com.tw>
References: <d42279d7-0350-563f-fca7-27f32cb9e9ee@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DF39266E63
 for <alsa-devel@alsa-project.org>; Mon, 25 Dec 2017 03:15:24 +0100 (CET)
In-Reply-To: <d42279d7-0350-563f-fca7-27f32cb9e9ee@redhat.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Hans de Goede [mailto:hdegoede@redhat.com]
> Sent: Sunday, December 24, 2017 6:43 PM
> To: Bard Liao
> Cc: Pierre-Louis Bossart; alsa-devel@alsa-project.org
> Subject: Cherry Trail + RT5645 devices analog microphone not working.
> 
> Hi Bard,
> 
> I've been looking into getting the microphone to work on
> some Cherry Trail + RT5645 devices with what appears to
> be a simple analog microphone.
> 
> You can see the microphone on one of the models I'm trying
> to get it to work on soldered onto the right side of the PCB
> here: https://i.imgur.com/bJzBQWe.jpg
> 
> I'm using this ucm config:
> 
> https://fedorapeople.org/~jwrdegoede/chtrt5645/
> 
> Which is basically Pierre-Louis Bossart's config from:
> https://github.com/plbossart/UCM
> 
> Adjusted because the devices all have a mono speaker.
> 
> I've been trying to get this to work myself and I can get
> some sound while recording by adding:
> 
>                  cset "name='RECMIXL BST2 Switch' on"
>                  cset "name='RECMIXR BST2 Switch' on"
> 
> But then I mainly get noise, I do get some sound from the
> microphone if I talk really really loudly, but it is
> barely above the noise-floor. I've the feeling that BST2
> is only picking up the microphone via cross-talk and
> that BST1 indeed is the correct input, but for some reason
> I get complete silence when recording when only BST1 is
> selected in the RECMIXR, and yes I've checked / set the
> "IN1 boost volume".
> 
> TL;DR: I'm trying to get an analog mic to work on 3
> different models Cherry Trail + RT5645 devices and I've
> been unable to get this to work. I've put a registerdump
> of the rt5645 with gnome-sound-recorder running here:
> https://fedorapeople.org/~jwrdegoede/rt5645-mic-red.dump
> 
> Any insights / help with this would be very much
> welcome.

I don't have the schematic, but I think you probably need micbias
for the capture. Please add both "micbias1" and "micbias2" in
the audio route since I don't know which one is needed.
for example
static const struct snd_soc_dapm_route cht_rt5645_audio_map[] = {
...
	{"Int Mic", NULL, "micbias1"},
	{"Int Mic", NULL, "micbias2"},
...
};


> 
> Regards,
> 
> Hans
> 
> ------Please consider the environment before printing this e-mail.
