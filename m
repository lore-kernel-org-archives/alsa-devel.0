From: Colin Fletcher <colinf@axicon.com>
Subject: Re: [alsa-devel] Fw: BUG: Kernel panic when 	disconnecting
 Edirol USB2 audio interface
Date: Tue, 28 Jun 2005 11:19:59 +0100
Message-ID: <42C1244F.3060602@axicon.com>
References: <Pine.HPX.4.33n.0506271650140.7308-100000@studcom.urz.uni-halle.de>	 <42C07072.1050105@axicon.com> <20050628020344.C5075C8944@blackbox.site>	 <1119925811.13519.4.camel@mindpipe>	 <20050628033156.9FB22BFF40@blackbox.site> <1119931807.13519.13.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <1119931807.13519.13.camel@mindpipe>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: david-b@pacbell.net, linux-usb-devel@lists.sourceforge.net, clemens@ladisch.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Mon, 2005-06-27 at 20:31 -0700, david-b@pacbell.net wrote:

>>No.  "frame" == ambiguous.  This message is on a USB list, where the
>>no-adjective version means "USB frame".  It's also cross-posted to
>>a list where the no-adjective version means something very different.
>>
>>The only solution that removes ambiguity for _everyone_ is to ensure
>>that such words never appear without an adjective.
>>

I'm sorry for being the originator of such confusion. I'll try to be 
less ambiguous from now on :-)

> So what the poster was saying was that if he uses 64 audio frames per
> period, which at 44.1KHz requires the audio interface to deliver a chink
> of data every ~1.4ms, he gets periodic xruns, IOW the audio interface is
> not able to do that.  If he uses 128, he gets no xruns, so he's getting
> a chunk of data every 2.8ms, but it's corrupted, hence the crackling.


That's exactly right, though yesterday's ALSA CVS almost completely 
cures the xruns (only four in > 25 minutes so far today).

Colin Fletcher

-- 
This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you have received this email in error please notify the system manager. This message contains confidential information and is intended only for the individual named. If you are not the named addressee you should not disseminate, distribute or copy this e-mail.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
