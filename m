From: Mark Canter <marcus@vfxcomputing.com>
Subject: Re: Re: intel 8x0 went silent in 2.6.11
Date: Fri, 4 Mar 2005 15:44:26 -0500 (EST)
Message-ID: <Pine.LNX.4.62.0503041540210.28922@krusty.vfxcomputing.com>
References: <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com><4227085C.7060104@drzeus.cx>
 <1109875926.2908.26.camel@mindpipe> <4228C7CE.5010109@tmr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
In-Reply-To: <4228C7CE.5010109@tmr.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Nish Aravamudan <nish.aravamudan@gmail.com>, Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Bill:

As I have been running through the kernel setting:

2.6.11/sound/pci/ac97/ac97_patch.c:

static const snd_kcontrol_new_t snd_ac97_ad1981x_jack_sense[] = {
     AC97_SINGLE("Headphone Jack Sense", AC97_AD_JACK_SPDIF, 11, 1, 1),

Note the last "1" is originally "0" in the kernel.  This might do it, but 
the issue for me remains that the line-detect for line-out should turn off 
the internal speakers (as it previously has).  Instead I have line-out 
working and internal speakers going.  And, yes, the headphones still work. 
All of this with 'headphone jack sense' enabled.

If you're not using line-out (out of a docking station) the above may work 
for you.  I tested plugging my speakers from the docking station into the 
headphone jack and the interal speakers did cut off as expected.

mark

On Fri, 4 Mar 2005, Bill Davidsen wrote:

> Lee Revell wrote:
>> On Thu, 2005-03-03 at 13:46 -0500, Mark Canter wrote:
>> 
>>> The same issue exists on a T42p (ICH4).  Doesn't that kind of defeat the 
>>> purpose?  The thought of having to disable the headphone jack and reenable 
>>> it each time is trivial considering you can go with the fact that sound 
>>> did not require the sound system touched under <= 2.6.10.
>> 
>> 
>> You don't have to disable and re-enable it each time, if your system is
>> configured correctly then your mixer settings will be saved.
>
> I don't think you understand the problem. Saving the settings does help, you 
> have to change the settings every time you switch from headphones to speaker. 
> Assuming I follow the o.p. issue... alsamixer shows no "sense" settings for 
> my ASUS laptop, and I have to boot 2.4 to get sound.
>
> -- 
>   -bill davidsen (davidsen@tmr.com)
> "The secret to procrastination is to put things off until the
> last possible moment - but no longer"  -me
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
