From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 18/44] fireworks: Add connection and stream
	management
Date: Fri, 04 Apr 2014 17:05:06 +0200
Message-ID: <533ECA22.5010509@ladisch.de>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
	<1395400229-22957-19-git-send-email-o-takashi@sakamocchi.jp>
	<533DCB08.3040404@ladisch.de> <533EC039.7080907@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <533EC039.7080907@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> (Apr 04 2014 05:56), Clemens Ladisch wrote:
>> Takashi Sakamoto wrote:
>>> +++ b/sound/firewire/fireworks/fireworks.c
>>> +static int
>>> +init_stream(struct snd_efw *efw, struct amdtp_stream *stream)
>>> +{
>>> +    ...
>>> +    err = amdtp_stream_init(stream, efw->unit, s_dir, CIP_BLOCKING);
>>
>> amdtp_stream_destroy() must be called.
>
> For me, there is an ambiguous on what you said. Must it be called before
> calling amdtp_stream_init() or in a case that the function returns error?

It must be called when the driver is disconnected normally (I guess in
snd_efw_stream_destroy_duplex), or when driver amdtp_stream_init() has
succeeded but driver loading aborts due to some other error.

> is it due to reference counter of firewire unit? (fw_unit_get/put)

Yes, and any other resources it might have allocated.


Regards,
Clemens

------------------------------------------------------------------------------
