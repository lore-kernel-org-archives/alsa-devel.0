From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Mixer volume dB settings.
Date: Sat, 10 Sep 2005 18:33:50 +0100
Message-ID: <432318FE.3060106@superbug.demon.co.uk>
References: <42ECC061.9070104@superbug.demon.co.uk> <Pine.LNX.4.61.0507311641140.8921@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0507311641140.8921@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Sun, 31 Jul 2005, James Courtier-Dutton wrote:
> 
> 
>>Hi,
>>
>>I am thinking of a method to provide dB volume setting with alsamixer. 
>>My suggestion is to add another variable to the mixer control structure. 
>>This variable will be an integer identifying the conversion function. If 
>>set to 0, no conversion function has been defined. If set to 1 or above, 
>>use a lookup table in alsa-lib to select the conversion function. The 
>>user land api would then be: snd_mixer_convert_hardware_to_db( 
>>hardware_value, conversion_function, &db_value); 
>>snd_mixer_convert_db_to_hardware( db_value, conversion_function, 
>>hardware_value )
>>
>>The reason for this, is that it seems to me that only the hardware 
>>driver will have full knowledge of what the conversion function should 
>>be, and setting a simple integer for conversion_function_type would seem 
>>the simplest solution.
>>
>>The global conversion functions could then be defined in an alsa-lib 
>>config file.
>>
>>This would also allow the application to increase/decrease the hardware 
>>value, but display to the user the dB value.
>>
>>Any comments?
> 
> 
> I already defined the interface in alsa-lib/include/mixer.h. Look for dB 
> functions there.
> 
> Also, the skeleton of the new mixer with abstraction layer is quite 
> finished. I need only implement a first real code for one driver as 
> example and we can start adding the abstraction code for all cards.
> 
> 						Jaroslav
> 

Can you point me in the direction of the new mixer abstraction layer.
It is unclear to me which alsa-lib files are associated with the 
abstraction layer.

I am thinking that the alsa-driver module for the sound card will have 
to attach an index value identifying the vol % -> dB conversion routine 
to use with the mixer element. Then alsa-lib could then simply do a 
lookup for the index and then process the associated conversion routine.

The reason for this is that I think that the same sound card controller 
chip might have different other sound chips associated with it, but the 
mixer elem name might be the same for both. I suppose we could then give 
a different name in the driver, and then rename it at the abstraction layer.

Any pointers you can give would be helpful.

James


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
