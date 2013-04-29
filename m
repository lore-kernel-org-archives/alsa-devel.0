From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/4] Rename functions, structure and member name for AMDTP
Date: Mon, 29 Apr 2013 13:21:20 +0900
Message-ID: <517DF540.4080506@sakamocchi.jp>
References: <1367125334-446-1-git-send-email-o-takashi@sakamocchi.jp>
	<1367125334-446-2-git-send-email-o-takashi@sakamocchi.jp>
	<517D1B96.3070304@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <517D1B96.3070304@ladisch.de>
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

Thanks for your review.

 > Please adjust the indentation in such cases.

OK. I check whole indentation of arguments in functions and rewrite if 
needed.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

(Apr 28 2013 21:52), Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> This patch rename some functions, structure and member name to reuse them
>> in both AMDTP receive and AMDTP transmit stream.
>
>> +++ b/sound/firewire/amdtp.c
>
>> -int amdtp_out_stream_init(struct amdtp_out_stream *s, struct fw_unit *unit,
>> -			  enum cip_out_flags flags)
>> +int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
>> +			  enum cip_flags flags)
>
> Please adjust the indentation in such cases.
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
