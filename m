From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: HDSP matrix mixer
Date: 30 Nov 2002 20:06:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1038683190.8316.48.camel@satellite.undata.org>
References: <E18ICLN-0003XJ-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18ICLN-0003XJ-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>    #define SAMPLE_MAX_24BIT  8388607.0f
> 
>     floatval = (peakval >> 8) / SAMPLE_MAX_24BIT;
> 
Thanks, my meters look better now :)

> i don't know enough about the rms values to comment on this. i would
Neither do I...

> imagine that the RMS values are in dB[something], and thus would span
> a rather narrow numerical range, but actually represent a very large
> range because of the logarithmic scaling. i can try to dig through the
> emails i have where martin from rme described what the rms meters do.
> 
Please do, I would really appreciate any information on the subject.


Thomas




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
