From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: HDSP matrix mixer
Date: Sat, 30 Nov 2002 13:32:16 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18ICLN-0003XJ-00@sc8-sf-list1.sourceforge.net>
References: <1038677584.8314.38.camel@satellite.undata.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "30 Nov 2002 18:33:04 +0100."
             <1038677584.8314.38.camel@satellite.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>I started implementing a GUI for the HDSP matrix mixer using the fltk
>toolkit. I want to get as close as possible to the TotalMix RME
>application, thus I'm trying to implement hardware metering using the
>Peak and RMS HDSP registers. The peak value covers the whole int range,

actually, no. it covers the range from 2^8 .. (2^32)-1. you need to
first adjust the value to a true 24 bit value, or more conveniently, a
normalized 32 bit float. here is the code from JACK which does this
(it could be optimized, i would expect):

    #define SAMPLE_MAX_24BIT  8388607.0f

    floatval = (peakval >> 8) / SAMPLE_MAX_24BIT;

>and seems quite usable to me (though it would need some king of
>logarithmic scaling), but the rms value, despite being an integer64,
>only covers a very narrow range. What is the correct way to handle those
>values ?

i don't know enough about the rms values to comment on this. i would
imagine that the RMS values are in dB[something], and thus would span
a rather narrow numerical range, but actually represent a very large
range because of the logarithmic scaling. i can try to dig through the
emails i have where martin from rme described what the rms meters do.

--p


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
