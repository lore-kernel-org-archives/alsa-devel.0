From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 3/3] Add handling CMP output connection
Date: Mon, 29 Apr 2013 18:25:38 +0900
Message-ID: <517E3C92.3050801@sakamocchi.jp>
References: <1367125189-377-1-git-send-email-o-takashi@sakamocchi.jp>
	<1367125189-377-4-git-send-email-o-takashi@sakamocchi.jp>
	<517D1B89.506@ladisch.de> <517DF48A.9000702@sakamocchi.jp>
	<517E1383.3000603@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <517E1383.3000603@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens,

 > The specification was written for the general case where the device
 > that creates the connection might be different from the transmitting
 > and receiving devices.  In that case, the payload size is needed for
 > correct bandwidth allocation.

I'm sure that the general case.

 > In our case, the Linux PC does not have plugs that could be accessed
 > by anybody else.

I'm sure that host system (Linux PC) doesn't have no plugs.

 >  (And I'm not sure if the value set by the Fireworks
 > firmware is correct enough so that we'd want to use it.)

With my Fireworks device, it always report 0, it means 1024 bytes for 
max payload size for output plug. But I'm not sure that it always report 
the same value. Especially at 192.0 kHz, the payload size is over 1024 
bytes but my device supports up to 96.0 kHz...

Actually the target device seems to update the max payload size after 
host connects to CMP output plug because its initial value is zero. Then 
we already allocate isochronous resources and isochronous packet to host 
system. I don't think it better to reallocate them after the connecting.

It's reasonable to ignore the payload field in any processing.


Regards

Takashi Sakamoto

(Apr 29 2013 15:30), Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> Then I have a question about handling payload field. In specification,
>> "The payload field shall specify the maximum number of quadlets that
>> may be transmitted in a single isochronous packet for this plug" but
>> actually cheking this field seems to make no sense because there is no
>> checking process in the procedure. I think I can do nothing for
>> payload field.
>
> The specification was written for the general case where the device that
> creates the connection might be different from the transmitting and
> receiving devices.  In that case, the payload size is needed for correct
> bandwidth allocation.
>
> In our case, the Linux PC does not have plugs that could be accessed by
> anybody else.  (And I'm not sure if the value set by the Fireworks
> firmware is correct enough so that we'd want to use it.)
>
>
> Regards,
> Clemens


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
