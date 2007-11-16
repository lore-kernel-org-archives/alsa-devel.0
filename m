From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: 1.0.15: volume levels drift on HDA with STAC92XX
 codec
Date: Fri, 16 Nov 2007 13:48:46 -0500
Message-ID: <473DE60E.1080607@redhat.com>
References: <472A113B.7030406@redhat.com>
	<200711012017.30376.maximlevitsky@gmail.com>
	<s5hk5oimdxi.wl%tiwai@suse.de>
	<200711161750.09647.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 84C05243D8
	for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2007 19:48:49 +0100 (CET)
In-Reply-To: <200711161750.09647.maximlevitsky@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/16/2007 10:50 AM, Maxim Levitsky wrote:
> On Friday 16 November 2007 17:02, Takashi Iwai wrote:
>> At Thu, 1 Nov 2007 20:17:30 +0200,
>>
>> Maxim Levitsky wrote:
>>> On Thursday 01 November 2007 19:47:39 Chuck Ebbert wrote:
>>>> We have two reports now of unstable volume levels:
>>>>
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=361051
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=354981
>>>>
>>>> This is with kernel 2.6.23 plus the two ALSA merge patches from
>>>> 2.6.23-rc1.
>>>> _______________________________________________
>>>> Alsa-devel mailing list
>>>> Alsa-devel@alsa-project.org
>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>> Probably this isn't a software bug.
>>> Probably this chip country to datasheet doesn't have usable "Master
>>> Volume" (volume knob) control.
>> I got a bug report that the same symptom appears also with STAC9221.
>>
>> 	http://bugzilla.kernel.org/show_bug.cgi?id=9374
>>
>> Maybe we need add whitelist / blacklist for this feature?
>>
>> On which codec/machine is this feature confirmed to work?
>>
>>
>> thanks,
>>
>> Takashi
> 
> Hi,
> 
> Yes, it seems that volume knob has troubles.
> 
> I have it with STAC9227. Obivosly it works
> 
> I know a user that first complained about some problems,
> but then he found that everything works ok, probably including the volknob.
> 
> He has STAC9274, and we had a long disscussion about new features I 
> intruduced,
> He said that everything is OK.
> I ask him explictly about that.
> 
> Now remember the report about conflict between my
> 'Master Volume' and already existing one?
> 
> This was a STAC922x, and the autor said that now
> his mulimedia keys can again control the volume
> (Probably this indicates that volumekknob is working)
> 
> 
> Thus we have 4 groups of STACS:
> 
> 1 - STAC9250 - lot of troubles - (I would be very happpy to hear from anybody 
> here that has it)
> 
> 2- STAC9221/2 - I thought that it works, but not anymore
> 3- STAC9227/8/9 - I have it, so I hope that it works
> 4- STAC927x - very simular to above, and one user that tells that it works.
> 
> 
> I suggest to wait a bit more to see the scale of this bug
> (After all it isn't that big bug, it is just a feature :-) that isn't working)
> 
> The datasheets mention briefly that an external volume control can be 
> connected to the chip. Maybe it affects the volumeknob.
> If this is the case, then probably we ether need to detect it, or drop the 
> whole thing.
> (Those external pins probably are just connected to the groung or somethibg 
> like that so no real external volumeknob is present, but they still mess the 
> internal VolumeKnob)
> 
> 
> Blacklist can help, but it is probably too much for that feature, since
> the VolumeKnob doesn't add anything very special, and can be emulated
> with SoftVol plugin, like it is done now.
> 
> There are several solutions:
> 
> 1) Rename it to say 'VolumeKnob", so the users that have it broken won't
> notice , but still driver will expose all controls of hardware.
> 2) Make a module param that will enable/disable it
> 3) Remove it completly, OK, but probably the #1 is better
> 
> All depends on whenever this is a specific stac model bug
> Like I thought STAC9205, or this is the 'external volume' problem.
> 
> If this is just STAC9205 and STAC9221 then we can make a module param,
> and make it enabled by default  for STAC9227/8/9 STAC927x, but make it 
> disabled  for STAC9205 and STAC9221
> 
> If not, then it is better  to remove it/remame to VolumeKnob
> 

I reverted the change in Fedora 8 and it fixed things:

http://cvs.fedora.redhat.com/viewcvs/*checkout*/rpms/kernel/F-8/linux-2.6-alsa-revert-hda-stac-volume.patch?root=extras
