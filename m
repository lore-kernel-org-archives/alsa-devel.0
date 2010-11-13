From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: wrong channel mappings for HDMI audio
Date: Sat, 13 Nov 2010 05:32:18 +0200
Message-ID: <4CDE06C2.7020704@iki.fi>
References: <87fwv8puuo.fsf@uwo.ca> <4CDDBA8C.30600@iki.fi>
	<87hbfmkr18.fsf@uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sypressi.dnainternet.net (sypressi.dnainternet.net
	[83.102.40.135])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F5E8103929
	for <alsa-devel@alsa-project.org>; Sat, 13 Nov 2010 04:32:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sypressi.dnainternet.net (Postfix) with ESMTP id DF931C6AD8
	for <alsa-devel@alsa-project.org>; Sat, 13 Nov 2010 05:32:19 +0200 (EET)
Received: from sypressi.dnainternet.net ([83.102.40.135])
	by localhost (sypressi.dnainternet.net [127.0.0.1]) (amavisd-new,
	port 10041)
	with ESMTP id 6Px2ywSVnJh6 for <alsa-devel@alsa-project.org>;
	Sat, 13 Nov 2010 05:32:19 +0200 (EET)
Received: from kirsikkapuu.dnainternet.net (kirsikkapuu.dnainternet.net
	[83.102.40.214])
	by sypressi.dnainternet.net (Postfix) with ESMTP id BCE17C6ACC
	for <alsa-devel@alsa-project.org>; Sat, 13 Nov 2010 05:32:19 +0200 (EET)
Received: from mail.onse.fi (unknown [109.204.162.131])
	by kirsikkapuu.dnainternet.net (Postfix) with ESMTP id B235D2BB13
	for <alsa-devel@alsa-project.org>; Sat, 13 Nov 2010 05:32:18 +0200 (EET)
Received: from sigma.onse.fi (sigma [10.0.0.8])
	by mail.onse.fi (Postfix) with ESMTP id 7CACB20800A
	for <alsa-devel@alsa-project.org>; Sat, 13 Nov 2010 05:32:18 +0200 (EET)
In-Reply-To: <87hbfmkr18.fsf@uwo.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 13.11.2010 02:26, Dan Christensen wrote:
> Anssi Hannula <anssi.hannula@iki.fi> writes:
> 
>> This is a known issue, the NVIDIA MCP79/7A HDMI hardware has incorrect
>> channel mapping.
>>
>> I reported this several months ago as "Wrong channel order with
>> multichannel HDMI on MCP7A":
>> http://www.spinics.net/lists/alsa-devel/msg35948.html
>> (there are some earlier reports from 2009 as well)
> 
> Great, thanks for confirming it's not just me.
> 
>> I'm using this workaround at the moment:
>>  pcm.!hdmi {
>>      type             route
>>      slave.pcm "cards.HDA-Intel.pcm.hdmi.0:CARD=NVidia,AES0=0x4,AES1=0x82,AES2=0x0,AES3=0x2"
>>      ttable.0.0 1
>>      ttable.1.1 1
>>      ttable.2.4 1
>>      ttable.3.5 1
>>      ttable.4.2 1
>>      ttable.5.3 1
>>      ttable.6.6 1
>>      ttable.7.7 1
>>  }
> 
> I can confirm that this fixes things for me.
> 
>> (not a perfect workaround as I'm hardcoding AESx instead of using the
>> ones provided as arguments, but at least you get the idea)
> 
> I don't understand this comment, but hopefully if I just put the above
> in my asound.conf, all should be fine, right?

Yes, it is just that programs can't specify their own AES parameters. If
everything works with your receiver, it is ok.

>> As for the preferred solution to this problem, as far as I understand,
>> that would be for the driver to have some ioctl that would provide
>> alsa-lib information about the unusual channel mapping, and alsa-lib
>> could then remap the channels using a channel remapping plugin.
> 
> Alternatively, can the fix just be hardcoded for this audio card?

Unfortunately I don't see a way of doing that, as all HDA-Intel codecs
use the same HDA-Intel.conf...
Maybe someone more knowledged knows a way, though.

-- 
Anssi Hannula
