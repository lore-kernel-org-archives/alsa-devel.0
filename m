From: William <walsac2@liam2.demon.co.uk>
Subject: Re: CVS ALSA failed upgrade in Linux 2.6.3
Date: Tue, 2 Mar 2004 15:52:24 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403021552.PAA17739@liam2.demon.co.uk>
References: <s5h3c8rfeg8.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3c8rfeg8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> wrote:
>>William wrote:
>> Jaroslav wrote on alsa-project.org:
>> 
>>    "simply copy files from the ALSA's alsa-kernel CVS module to relevant
>>    locations in the 2.6 kernel tree."
>> 
>> This is one method of upgrading to CVS ALSA.
>
>"simply copy" doesn't mean so simply copy :)

Thanks for explaining that.  Please would you delete the word "simply" in
the explanation on alsa-project.org because it's misleading.

>for example, alsa-kernel/include directory goes to
>linux/include/sound.

Ok, so is my summary below correct?

   $ cp -fR alsa-kernel/include/*  linux/include/sound
   $ mv -f alsa-kernel/include  out-of-the-way-temporarily
   $ cp -fR alsa-kernel/*  linux/sound

> also, it might be safer to leave oss things.

What do you mean "might be safer"?  That it's really necessary to leave oss?
Or that you're not certain?

>if you're not sure, just build alsa-driver with 2.6 kernels as well as
>you did for 2.4 kernels.  it should be ok now.

William


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
