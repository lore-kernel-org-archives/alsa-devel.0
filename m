From: Christophe Aeschlimann <c.aeschlimann-5/WUhD8XThOVQ4qyx6sgCw@public.gmane.org>
Subject: Re: ALSA issue on DA850/OMAP-L138/AM18x
Date: Wed, 16 Feb 2011 15:07:57 +0100
Message-ID: <4D5BDA3D.5080905@acn-group.ch>
References: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Rajashekhara, Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Cc: "khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Sudhakar,

On 18.01.2011 05:43, Rajashekhara, Sudhakar wrote:

[...]

 > With the above fixes, arecord and aplay does not work for the first time.
 > Couple of times I get the below error:
 >
 > root@da850-omapl138-evm:~# arecord -f dat | aplay -f dat
 > arecord: main:608: audio open error: Invalid argument
 > aplay: playback:2297: read error
 > root@da850-omapl138-evm:~# arecord -f dat | aplay -f dat
 > aplay: main:608: audio open error: Invalid argument
 > Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, 
Stereo
 >
 > Third time arecord and aplay work normally.
 >
 > Has anyone seen such issues on DA850 or any other platform?
 >
 > I am currently debugging this issue. I'll submit the above patch to 
community
 > once the issue of fixed.

I'm facing the same issue here.

Did you make any progress on that one ?

 > Regards,
 > Sudhakar

Regards,

Christophe
