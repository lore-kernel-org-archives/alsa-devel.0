From: Paul Davis <pbd@op.net>
Subject: Re: ALSA Hammerfall DSP driver
Date: Thu, 23 May 2002 00:13:20 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205230411.GAA05795@alsa.alsa-project.org>
References: <3CEBD23F.AA8817D2@telia.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id GAA05795
	for <alsa-devel@alsa-project.org>; Thu, 23 May 2002 06:11:32 +0200
In-Reply-To: Your message of "Wed, 22 May 2002 19:15:43 +0200."
             <3CEBD23F.AA8817D2@telia.com>
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
>> I am sure there will be minor glitches along the way. I would really
>> appreciate feedback from anyone with an H-DSP (marcus - that means
>> you! :)
>
>Everything looks good, I just can't get it to play anything for me.
>Probably due to my limited ALSA knowledge.
>
>I have Ardour up and running with the hdsp driver and it lets me choose
>between 18 output channels. I choose 'out1' and 'out2' and start
>playback. I have set the volume on 'Chn',1 and 'Chn',2 with amixer;
>'amixer Chn,1 65535' 'amixer Chn,2 65535'. No sound. What am I missing?

that doesn't look like a real amixer control ID to me. did you try:

     amixer name=Chn,index=1 32768

i have been using alsamixer to control the playback volumes, and it
seems to work fine. amixer reports the values correctly as well, so
try

    amixer cget numid=11  # channel 1 playback volume
    amixer cget numid=17  # channel 2 playback volume

or the more mnemonic:

    amixer cget name=Chn,index=1
    amixer cget name=Chn,index=2

let me know. 

Note, 65536 =approx +2dB. 0dB is at 32768 ...

--p



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
