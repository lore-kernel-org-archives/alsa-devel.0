From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Question: setting up the hardware for alsa
Date: Fri, 04 Nov 2005 16:13:50 +0000
Message-ID: <436B88BE.1090106@superbug.co.uk>
References: <b15982770511040749k3ccbaa07gcbd7bac05689a8e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <b15982770511040749k3ccbaa07gcbd7bac05689a8e7@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Smoot <davidsmoot@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

David Smoot wrote:
> Greetings, first post to the list and hopefully a simple question:
> 
> My company builds Linux based telemetry systems. We are working on an
> airborne telemetry platform. The customer has expressed a desire to record
> the pilot voice traffic on the data stream with the other data from the
> instruments.
> 
> We use a stripped down kernel and build pretty much everything by hand. I'm
> attempting to set up ALSA so I can pull the audio data from the line in.
> 
> At this point I at least knew libasound was OK because I could execute some
> simple code that listed libasound data types and parameters.
> 
> But I can't open any devices and talk to them. I know I am missing some kind
> of crucial step in setting up the hw:0,0 device but I can't seem to figure
> out the next step. I've read tutorials, googled, but I am stuck. If someone
> would point me to the proper documents I would be grateful.
> 
> David
> 

The ca0106 alsa driver is quite new and as such might not be the most 
reliable driver to use for avionics systems. Line in/Mic input was only 
recently added to the driver, so it would be important for you to tell 
us which alsa version you are using. The following will tell you.
cat /proc/asound/version.

Another problem you will have is noise on the input. Special care has to 
be taken when recording voice in an aircraft.

A good application to use to test voice capture is arecord.
The ca0106 card is very basic, and you should only really use a capture 
rate of 48000 Hz if you want any sort of quality captured. You can 
resample it in your application to a lower rate, or compress it using a 
codec before transmission over the telemetry link. The ca0106 is 
particulary bad at 44100 Hz, but should be ok at rates 24000, 12000,8000 Hz

You should open the devices directly, but instead use the libasound 
snd_pcm_open() call.

James



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
