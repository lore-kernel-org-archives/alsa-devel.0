From: Paul Davis <pbd@op.net>
Subject: Re: ALSA Hammerfall DSP driver
Date: Thu, 23 May 2002 18:34:26 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205232232.g4NMW9b04424@post2.fast.net>
References: <3CED4A57.9E8EC888@telia.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA21177
	for <alsa-devel@alsa-project.org>; Fri, 24 May 2002 00:32:20 +0200
In-Reply-To: Your message of "Thu, 23 May 2002 22:00:23 +0200."
             <3CED4A57.9E8EC888@telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Marcus Andersson <054185595@telia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>Paul Davis wrote:
>> i have been using alsamixer to control the playback volumes, and it
>> seems to work fine. amixer reports the values correctly as well, so
>> try
>> 
>>     amixer cget numid=11  # channel 1 playback volume
>
>numid=11,iface=MIXER,name='Chn',index=1
>  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
>  : values=49818
>
>>     amixer cget numid=17  # channel 2 playback volume
>
>numid=17,iface=MIXER,name='Chn',index=2
>  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
>  : values=49818

these values indicate that the playback volumes are set so that you
should be able to hear stuff. unfortunately, there is no way to read
the actual h/w values - these rely on a driver-side cache. but with
this setting, i hear stuff played by aplay and/or ardour.

i know its mundane, but are you sure you have the cables hooked up
correctly? you can set the passthru control 

	   amixer cset name=Passthru 1

and check that passthru is working OK.

>Could it be that my kernel is too old? 2.4.7.
>
>Could it be that I am using alsa-utils-0.9.0rc1? The one in CVS fails
>with:

no, neither of these are likely causes.

>Is it possible to route sound to the line out port?

there are two levels of control. the "line out" control, which is a
boolean, and not represented by the ALSA controls (but the driver
turns it on). then there is the matrix mixer; the line outs are
channels ... hmmm ... on a multiface, i'm not sure if they will be
channels 25+26 or 19+20. 

these aren't represented in the regular PCM interface, because they
are not playback streams per se. Instead, you control what is sent to
them via the matrix mixer. this works, but there aren't any ALSA tools
that can use the matrix mixer control yet. see the discussion about
this over the last few weeks. jaroslav and abramo seem to think its ok
to have thousands of controls; takashi and myself prefer a different
model. its not resolved yet.

>Which channel and card do the OSS layer use? How can I control this?

/dev/dsp0 -> plughw:0,0,0  # card 0, device 0, subdevice 0
/dev/dsp1 -> plughw:1,0,0  # card 1, device 0, subdevice 0
/dev/dsp2 -> plughw:2,0,0  # card 2, device 0, subdevice 0

there are ways to modify this, but this is the basic setup for OSS
emulation under ALSA. the channels used will start at the first one.
i haven't tried OSS emulation on either of my RME cards, but its
reported to work.

--p

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
