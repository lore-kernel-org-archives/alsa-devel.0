From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: "Resource temporarily unavailable" while reading
 although poll returns POLLIN event
Date: Thu, 22 Apr 2010 12:15:29 +0200
Message-ID: <4BD021C1.5060705@gmail.com>
References: <4BCEE140.5060704@gmail.com>
	<v2q4f3252891004211941xcdf33e7enbda0c2a8dcfe9609@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from keymachine.tbmn.org (mail.tbmn.org [87.118.84.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BB0C10382A
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 12:15:30 +0200 (CEST)
In-Reply-To: <v2q4f3252891004211941xcdf33e7enbda0c2a8dcfe9609@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> 2010/4/21 Stefan Schoenleitner <dev.c0debabe@gmail.com>
>> If it helps, I pasted the source code here so that you can view it nicely:
>> http://pastebin.com/fCicqctq
>>
> which sound card are you using ?
> 
> The program did not run on my two sound card since you are using 160 frames
> and mono
> 
> are you using "pulse" device for testing since only pulse device return the
> error messages "could not read from capture device: Resource temporarily
> unavailable" ?

Yes, I am using pulseaudio since my hardware sound card (an audigy 2)
does not support the period size I'm using.


The error message above is is from my own program (line 444):

-----------------------------------------------------------------
if ((ret=snd_pcm_readi(capture_device, buffer, 160))<0)
{
	if (ret == -EPIPE)
	{
		fprintf(stderr, "XRUN while reading from capture device: %s\n",
snd_strerror(ret));
		snd_pcm_prepare(capture_device);
		snd_pcm_start(capture_device);
	}
	else
	{
		fprintf(stderr, "could not read from capture device: %s\n",
snd_strerror(ret));
		exit(EXIT_FAILURE);
	}
}
-----------------------------------------------------------------

cheers,
stefan
