From: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Subject: Re: [PATCH v8 05/12] media: Entity use count
Date: Fri, 04 Feb 2011 14:34:02 +0200
Message-ID: <4D4BF23A.1050800@maxwell.research.nokia.com>
References: <1296131437-29954-1-git-send-email-laurent.pinchart@ideasonboard.com> <1296131437-29954-6-git-send-email-laurent.pinchart@ideasonboard.com> <201102041122.03886.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201102041122.03886.hverkuil@xs4all.nl>
Sender: linux-media-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi,

And many thanks for the comments!

Hans Verkuil wrote:
...
>> diff --git a/include/media/media-entity.h b/include/media/media-entity.h
>> index b82f824..114541a 100644
>> --- a/include/media/media-entity.h
>> +++ b/include/media/media-entity.h
>> @@ -81,6 +81,8 @@ struct media_entity {
>>  	struct media_pad *pads;		/* Pads array (num_pads elements) */
>>  	struct media_link *links;	/* Links array (max_links elements)*/
>>  
>> +	int use_count;			/* Use count for the entity. */
> 
> Isn't unsigned better?

Could be. The result, though, will be slightly more difficult checking
for bad use count --- which always is a driver bug.

me->use_count += change;
WARN_ON(me->use_count < 0);

we must do something like this:

if (change < 0)
	WARN_ON(me->use_count < (unsigned)-change);
me->use_count += change;

I'd perhaps also go with unsigned int; the choice for signed was made
mainly since the above check and with signed int the check was more trivial.

Regards,

-- 
Sakari Ailus
sakari.ailus@maxwell.research.nokia.com
