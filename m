From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] alsa: support module on-demand loading for
 seq and timer
Date: Tue, 23 Nov 2010 17:56:29 +0100
Message-ID: <4CEBF23D.6020801@ladisch.de>
References: <1290508964.1164.3.camel@yio> <4CEBE1B1.4070906@ladisch.de>
	<AANLkTi=j4XA5r4DSBdZKxLJNvoAQzR+daXu0UzjcvLo4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 5A00C103806
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 17:54:13 +0100 (CET)
In-Reply-To: <AANLkTi=j4XA5r4DSBdZKxLJNvoAQzR+daXu0UzjcvLo4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, jkysela@redhat.com
List-Id: alsa-devel@alsa-project.org

Kay Sievers wrote:
> On Tue, Nov 23, 2010 at 16:45, Clemens Ladisch <clemens@ladisch.de> wrote:
>> Kay Sievers wrote:
>>> +MODULE_ALIAS("devname:snd/seq");
>>
>> The device name that alsa-lib tries to use for autoloading is actually
>> /dev/aloadSEQ.
> 
> That might need to be changed then, if something depends on that, but
> nothing ever tries to open /dev/snd/seq.

No, alsa-lib pokes /dev/aloadSEQ only if opening /dev/snd/seq has
failed.  (Something historical, I believe.)

>> So you're going to add the entries for card driver autoloading
>> (/dev/aloadC*), too?
> 
> No, we only ever handle single-instance devices with a single fixed
> dev_t, not ones with an arbitrary number of device instances.
> 
> Card drivers are loaded by hardware matches today, not on-demand, and
> not by an card number.

There are card drivers without matching hardware (such as MIDI over
a serial port, or virtual devices).

> There are no configured numbered module aliases for sound cards
> anymore, that can't work with today's setups.

Just that it cannot work with systemd doesn't imply that nobody still
uses it or that it could be dropped without regards for backward
compatibility.


Anyway, this patch is independent of ALSA's old autoload code.
Applied.


Regards,
Clemens
