From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: quattro usb-audio endianess conversion layer
Date: Tue, 15 Jun 2004 00:38:25 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40CDC671.4020706@boosthardware.com>
References: <Pine.HPX.4.33n.0406101848280.3148-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Patrick Shirkey wrote:
> 
>>It turns out the reason for the noise in the input channels all this
>>time is due to the quattro only reading big endian at input.
> 
> 
> Does this happen all of the time?  There is a bug report which says
> that it works sometimes.
> 
> 
>>Has anyone had ideas on how to implement a layer that works to
>>automatically convert the quattros big endian input into little endian
>>to enable ease of use with most Linux audio apps?
> 
> 
> With the patch below, it should work with plughw:X.  Does it?
> 

Thanks Clemens.


I finally was able to test the patch and my first impression is that it 
has made a significant difference and should be committed immediately.

I recorded with
	
	arecord -f cd -d 10 -D plughw:2,0 test.wav

played back with

	aplay -f cd -d hw:2,1 test.wav

The sound is much clearer.


My next question is: Does anyone have a good idea how to apply this to a 
jack setup without sacrificing latency?


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org/LAU/guide/ - The Linux Audio Users guide
Http://www.djcj.org/gigs/ - Gigs guide Korea
Http://www.nana7.net - Bar Nana - Itaewon, Seoul, Sth Corea
========================================


Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
