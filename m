From: Apostolos Dimitromanolakis <apostolos@aei.ca>
Subject: Re: [PATCH] aureon.c - adc mux, master vol
Date: Thu, 15 Jul 2004 13:40:49 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40F6C1A1.5000803@aei.ca>
References: <40E6D4D0.6000206@gmx.at>	<s5h4qom93jx.wl@alsa2.suse.de>	<40EB4C68.2090804@aei.ca> <s5h4qo98ell.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qo98ell.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Yeah you are right about the master volume as it is implemented but I 
think there are seperate analog & digital volume control so it could be 
possible to use analog for the master and the digital for the DAC channels.

I will be away from my computer so I can't test the patch right now but 
I will have a look at the driver again soon.

Apostolos

Takashi Iwai wrote:

>Hi,
>
>it seems that my last post didn't go out properly...
>
>At Tue, 06 Jul 2004 21:05:44 -0400,
>Apostolos Dimitromanolakis wrote:
>  
>
>>I think it would be convenient for the end user  to keep the Master
>>volume attenuation on Aureon & Prodigy.  There are seperate analog and
>>digital volume controls on the chip and since each DAC has it's analog
>>volume control as a mixer element, why not have the master digital
>>volume as another control?
>>    
>>
>
>The master volume control on WM codec seems not to be a real 'master
>control'.  It's no independent control but just modifies the all DAC
>volumes at once.
>
>If we keep this, the DAC volumes must be updated and the changes must
>be notified.  But then the question is how to handle master volume
>when only a DAC volume is changed?
>
>
>BTW, the attached patch is to use more intuitive control names for
>volume and capture controls.  The bogus master volume is removed.
>Could aureon/prodigy owners can test it?
>
>It's to the latest CVS.
>
>
>thanks,
>
>Takashi
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
