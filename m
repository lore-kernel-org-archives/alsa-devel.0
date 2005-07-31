From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Mixer volume dB settings.
Date: Sun, 31 Jul 2005 13:13:21 +0100
Message-ID: <42ECC061.9070104@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I am thinking of a method to provide dB volume setting with alsamixer.
My suggestion is to add another variable to the mixer control structure. 
This variable will be an integer identifying the conversion function.
If set to 0, no conversion function has been defined. If set to 1 or 
above, use a lookup table in alsa-lib to select the conversion function.
The user land api would then be:
snd_mixer_convert_hardware_to_db( hardware_value, conversion_function, 
&db_value);
snd_mixer_convert_db_to_hardware( db_value, conversion_function, 
hardware_value )

The reason for this, is that it seems to me that only the hardware 
driver will have full knowledge of what the conversion function should 
be, and setting a simple integer for conversion_function_type would seem 
the simplest solution.

The global conversion functions could then be defined in an alsa-lib 
config file.

This would also allow the application to increase/decrease the hardware 
value, but display to the user the dB value.

Any comments?

If this seems ok, I will start implementing it.

James


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
