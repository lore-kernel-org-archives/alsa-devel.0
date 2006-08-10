From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ALSA problems with 2.6.18-rc3
Date: Wed, 09 Aug 2006 21:47:11 -0400
Message-ID: <200608092147.11457.gene.heskett@verizon.net>
References: <44D8F3E5.5020508@ukonline.co.uk>
	<200608091651.28077.gene.heskett@verizon.net>
	<1155157036.26338.200.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <1155157036.26338.200.camel@mindpipe>
Content-disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Benton <b3nt@ukonline.co.uk>, Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wednesday 09 August 2006 16:57, Lee Revell wrote:
>On Wed, 2006-08-09 at 16:51 -0400, Gene Heskett wrote:
>> On Wednesday 09 August 2006 16:41, Lee Revell wrote:
>> [...]
>>
>> >> >Takashi-san,
>> >> >
>> >> >Does this help at all?  Many users are reporting that sound broke
>> >> > with 2.6.18-rc*.
>> >> >
>> >> >Lee
>> >>
>> >> Takashi-san's suggestion earlier today of running an "alsactl -F
>> >> restore" seems to have fixed all those diffs right up, I now have
>> >> good sound with an emu10k1 using an audigy 2 as card-0, running
>> >> kernel-2.6.18-rc4.
>> >
>> >Distros should probably be using this as a default.  Otherwise, simply
>> >adding a new mixer control will cause restoring mixer settings to
>> > fail.
>> >
>> >Lee
>>
>> I already have the 'alsactl restore' in my rc.local.  Would there be
>> any harm in just adding the -F to that invocation, or will that just
>> restore it to a 'default' condition always.  Seems like it would,
>> canceling anything you have done & then did an 'alsactl store' to
>> save..
>
>That's what I was suggesting - just add -F to the alsactl restore in
>your init script.  It won't restore it to a default state - the only
>difference is that it will do a better job restoring your mixer state if
>new controls are added by a driver update.
>
>alsactl --help:
>
>  -F,--force      try to restore the matching controls as much as
>possible
>
>Lee

Great, Lee, thanks.  That also gave me a good excuse to expand the 
operating $PATH for rc.local, recent heyu changes seem to have killed my 
restoration of the config that existed after cron made the last change in 
config.


-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
