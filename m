From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [patch 1/2] ALSA: oxfw: some signedness bugs
Date: Sat, 13 Dec 2014 19:14:46 +0900
Message-ID: <548C1196.4010503@sakamocchi.jp>
References: <20141212192703.GA22234@mwanda> <548BC973.3090004@sakamocchi.jp> <20141213070414.GA4973@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20141213070414.GA4973@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Dec 13 2014 16:04, Dan Carpenter wrote:
> On Sat, Dec 13, 2014 at 02:06:59PM +0900, Takashi Sakamoto wrote:
>> On Dec 13 2014 04:27, Dan Carpenter wrote:
>>> This code tends to use unsigned variables by default and it causes
>>> signedness bugs when we use negative variables for error handling.
>>> The "i" and "j" variables are used to iterated over small positive
>>> values and so they should be type "int".  The "len" variable doesn't
>>> *need* to be signed but it should be signed to make the code easier to
>>> read and audit.
>>>
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
>> Thanks, but I prefer to use 'unsigned int' for loop counter, like the
>> other drivers.
> 
> Unthinking use of unsigned int every where is a kind of leprosy.  It
> just makes the code hard to read and it causes bugs.

In the beginning of last year, I received a comment from Clemens to use
'unsigned int' type for loop counter instead of 'int' type. Since then,
for ALSA firewire stack, I've been following his advice. (but actually I
missed to OXFW driver...)

For consistency inner this stack, I request you to follow this.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
