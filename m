From: stan <stanl@cox.net>
Subject: Re: Unable to open plughw:0,0 from user program.
Date: Thu, 23 Aug 2007 14:50:27 -0700
Message-ID: <46CE0123.2030707@cox.net>
References: <46CDD5A8.3000006@cox.net>
	<s5hlkc2yrax.wl%tiwai@suse.de>	<46CDF600.6030509@cox.net>
	<75b66ecd0708231429p41ede740q73d34461d00fa130@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao104.cox.net (fed1rmmtao104.cox.net [68.230.241.42])
	by alsa0.perex.cz (Postfix) with ESMTP id 54D5E103828
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Aug 2007 23:50:29 +0200 (CEST)
In-Reply-To: <75b66ecd0708231429p41ede740q73d34461d00fa130@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On 8/23/07, stan <stanl@cox.net> wrote:
>   
>> I don't think so.  Here is the output of fuser /dev/snd/*
>> /dev/snd/pcmC0D0p:    3069m
>> /dev/snd/timer:       3069
>>     
>
> Looks like it's in use by process 3069?  What is that?
>
> Lee
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   
That is esd, Esound daemon.

NAME
       esd - The Enlightened Sound Daemon

DESCRIPTION
       Starts up EsounD, which provides a sound mixing server.

USAGE
       esd [options]

         -d DEVICE     force esd to use sound device DEVICE
         -b            run server in 8 bit sound mode
         -r RATE       run server at sample rate of RATE
         -as SECS      free audio device after SECS of inactivity (-1 to 
disable)
         -unix         use unix domain sockets instead of tcp/ip
         -tcp          use tcp/ip sockets instead of unix domain
         -public       make tcp/ip access public (other than localhost)
         -promiscuous  start unlocked and owned (disable authenticaton) 
NOT RECOMMENDED
         -terminate    terminate esd daemon after last client exits
         -noterminate  do not terminate esd daemon after last client exits
         -nobeeps      disable startup beeps
         -beeps        enable startup beeps
         -trust        start esd even if use of /tmp/.esd can be insecure
         -port PORT    listen for connections at PORT (only for tcp/ip)
         -bind ADDRESS binds to ADDRESS (only for tcp/ip)

         -v --version  print version information

       Possible devices are:  /dev/dsp, /dev/dsp2, etc.

FILES /etc/esd.conf           daemon configuration file

And it must be my problem.  It must have been started by default because 
I didn't start it.  I'll see if I can configure it to share the sound 
card or disable it.

Thank you very much.
