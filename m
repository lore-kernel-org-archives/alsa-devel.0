From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 1/1] media: Entities with sink pads must have at least one
 enabled link
Date: Wed, 14 Nov 2012 10:23:19 +0100
Message-ID: <50A36307.50502@samsung.com>
References: <1351280777-4936-1-git-send-email-sakari.ailus@iki.fi>
 <20121113142409.GR25623@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-reply-to: <20121113142409.GR25623@valkosipuli.retiisi.org.uk>
Sender: linux-media-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, alsa-devel@alsa-project.org, laurent.pinchart@ideasonboard.com, broonie@opensource.wolfsonmicro.com, hverkuil@xs4all.nl
List-Id: alsa-devel@alsa-project.org

Hi Sakari,

On 11/13/2012 03:24 PM, Sakari Ailus wrote:
> Hi all,
> 
> Comments would be appreciated, either positive or negative. The omap3isp
> driver does the same check itself currently, but I think this is more
> generic than that.
> 
> Thanks.
> 
> On Fri, Oct 26, 2012 at 10:46:17PM +0300, Sakari Ailus wrote:
>> If an entity has sink pads, at least one of them must be connected to
>> another pad with an enabled link. If a driver with multiple sink pads has
>> more strict requirements the check should be done in the driver itself.
>>
>> Just requiring one sink pad is connected with an enabled link is enough
>> API-wise: entities with sink pads with only disabled links should not be
>> allowed to stream in the first place, but also in a different operation mode
>> a device might require only one of its pads connected with an active link.
>>
>> If an entity has an ability to function as a source entity another logical
>> entity connected to the aforementioned one should be used for the purpose.

Why not leave it to individual drivers ? I'm not sure if it is a good idea
not to allow an entity with sink pads to be used as a source only. It might
be appropriate for most of the cases but likely not all. I'm inclined not to
add this requirement in the API. Just my opinion though.

--
Thanks,
Sylwester
