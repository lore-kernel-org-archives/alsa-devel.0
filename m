From: Paul Davis <pbd@op.net>
Subject: Re: HDSP advanced routing (matrix mixer)
Date: Fri, 06 Sep 2002 10:02:24 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17nJeb-0006X5-00@usw-sf-list1.sourceforge.net>
References: <1031318910.7294.26.camel@satellite.undata.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "06 Sep 2002 15:28:25 +0200."
             <1031318910.7294.26.camel@satellite.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I'm considering writing an application to control the HDSP matrix mixer,
>but so far I could only figure out how to route physical inputs to the
>line out (First integer value (0-25) : input, second integer value
>(26-27) : line out L-R, third integer value (0-65536) : gain). Paul,
>could you please document a little the channel-to-output,
>channel-to-line-out, and input-to-output cases ?

first value: input source
second value: output source
third value: gain

input source: 0-25  (physical channels), 26-51 (audio output streams)
output source: 0-27 (physical channels)

output channels 26 and 27 are the two line outs on the I/O box.

i hope this is clearer. let me know if you have more questions.

--p


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
