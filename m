From: Pete Black <pete@claudia.daemon.sh>
Subject: Re: ALSA 'share' device, or 'software multi-open'
Date: Tue, 01 Oct 2002 10:11:48 +1200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D98CC24.4090206@claudia.daemon.sh>
References: <20020930123444.5C7846875@claudia.daemon.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from claudia.daemon.sh (202-0-34-141.cable.paradise.net.nz [202.0.34.141])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA01408
	for <alsa-devel@alsa-project.org>; Tue, 1 Oct 2002 00:10:46 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Paul Davis <pbd@op.net>, Patrick Shirkey <pshirkey@boosthardware.com>
List-Id: alsa-devel@alsa-project.org

This would be the same smix plugin that isn't in the ALSA tree then? 
Unless it has recently been added to CVS, i can find no trace of it in 
my 0.9rc trees.

Suggesting a solution that doesn't exist outside the context of 'some 
guy who used to work for SuSE and might have got this to work once on 
his own tree but didn't commit it' is not only frustrating, but also 
misleading.

A simple 'No, ALSA is not capable of mixing multiple streams in software 
for playback on single-channel hardware' would have sufficed.

However, now that we have established that there is no specific problem 
with doing this in the context of ALSA, and that it has, in fact 
supposedly been done, I would welcome any information on where this smix 
plugin might be found, and how it might be used.

I feel like i'm in the Matrix  -

'Do not try to use the smix plugin, there is no documentation. Instead, 
only try to realise the truth...The truth?...There is no smix plugin'

Does anyone know abramo's (sp?) email address so that i could ask him 
for some information directly?

Thanks

-Pete




>[ please forward to alsa-devel for me. thanks. ]
>
>  
>
>>IIUC the share plugin is not even intended to do what you want (as you 
>>mention above) it is written to share audio between different devices 
>>specified in the asoundrc file. Not to mix multiple streams from 
>>multiple apps. Paul you should stop suggesting the share plugin as an 
>>almost possible option. It is a red herring.
>>    
>>
>
>sorry, its a mis-identification rather than anything else. the plugin
>i am trying to refer to exists, but as usual with ALSA, its not
>documented and so even i don't know its name :) but yes, "mix" or
>"smix" is the right one, not "share". 
>
>--p
>
>  
>





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
