From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Userspace ALSA Soundcard
Date: Fri, 15 Oct 2004 13:59:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <416FC9B8.6020308@superbug.co.uk>
References: <MEMPHISWYTZiAXCKe570000000d@Memphis.stud.so.fhnw.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <MEMPHISWYTZiAXCKe570000000d@Memphis.stud.so.fhnw.ch>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Roger Villars <roger.villars@fhso.ch>
Cc: 'Takashi Iwai' <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Roger,

pcm_jack lets alsa-lib talk to the jackd daemon.
So, you implement your own bluez daemon, and then implement a plugin for 
alsa-lib that talks to it.

You just need to think of the problem slighly differently.
If you look at any standard alsa application, it does:
open()
set_params()
read_write_samples()
close()

With an alsa-lib plugin, at the open() step, it could talk to the bluez 
daemon, and see if the bluez connections are up, and if so, allow the 
open, otherwise, fail the open() call.

The current ALSA API does not allow for more complicated audio devices. 
You have to use extra other apis to implement what you want.
e.g. A headset with volume up/down buttons. The buttons arrive via the 
kernel input/events api, and the sound goes via ALSA.

For an application to use a bluetooth headset, the application will 
first have to talk to the bluetooth api to set up the bluetooth specific 
connections, and then once bluetooth is set up, it would open an ALSA 
device in order to send sound to the device.



Roger Villars wrote:
> Thanks for your answer!
> 
> I looked at pcm_jack a bit closer and it seems to be
> some sort of plugin for ALSA. Actually, this is not exactly
> what I need. I thought about something like this:
> 
> int main(......)
> {
> 	create a new soundcard
> 	connect to the headset using blueZ
> 	while(true) {
> 		get the audio stream from blueZ
> 		give the audio stream to the soundcard
> 		same thing, other direction
> 	}
> 	remove the soundcard
> }
> 
> (programming could be so easy ;-) )
> 
> That's why I mentioned the deamon. With this, I can use the headset
> with the program running in the background without the need to change 
> any kernel stuff. But it seems to me that ALSA is not made for this. 
> So it would be very complicated, don't you think?
> 
> Roger 
> 
> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net] On Behalf Of Takashi Iwai
> Sent: Thursday, October 14, 2004 5:36 PM
> To: Roger Villars
> Cc: alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] Userspace ALSA Soundcard
> 
> At Thu, 14 Oct 2004 09:32:52 +0200,
> Roger Villars wrote:
> 
>>
>>Hello
>>
>>I'm new to the ALSA Framework and I'm trying to program a "virtual" 
>>soundcard for a Bluetooth Headset that is running completely in 
>>userspace. No kernel modules or something.
>>
>>You should only start a deamon program and then every ALSA beware 
>>program can "see" a new Soundcard.
> 
> 
> Even the daemon wouldn't needed, I guess.
> Well, the mixer might be problematic in some cases.
> 
> 
>>First Question: Do you think this is possible?
> 
> 
> Yes.
> 
> 
>>Second Question: How?
> 
> 
> A good question :)  There is no real documentation for this.
> As you wrote below, jack_pcm.c is the best example to rerfer to.
> 
> 
>>I heard that there is a file called pcm_jack.c in ALSA that is doing 
>>exactly what I need. But as I'm new to ALSA I don't know how and where 
>>in the code it is doing it.
>>
>>Would be nice if somebody can give me some Know-how. 
> 
> 
> Basically, you need to write dozen of callbacks for each pcm operation.  The
> most cryptical part is the PCM configuration.
> The PCM layer calls hw_params, hw_refine, and sw_params callbacks for
> querying and setting up the proper configuration.
> 
> 
> Takashi
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
