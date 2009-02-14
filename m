From: Guy Stalnaker <jstalnak@wisc.edu>
Subject: Applying Herton supplied patches ...
Date: Sat, 14 Feb 2009 16:08:43 -0600
Message-ID: <499740EB.6040600@wisc.edu>
References: <mailman.2735.1234638846.1965.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adsum.doit.wisc.edu (adsum.doit.wisc.edu [144.92.197.210])
	by alsa0.perex.cz (Postfix) with ESMTP id D73662443B
	for <alsa-devel@alsa-project.org>; Sat, 14 Feb 2009 23:08:45 +0100 (CET)
Received: from avs-daemon.smtpauth1.wiscmail.wisc.edu by
	smtpauth1.wiscmail.wisc.edu
	(Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008;
	32bit)) id <0KF200400TIKWW00@smtpauth1.wiscmail.wisc.edu> for
	alsa-devel@alsa-project.org; Sat, 14 Feb 2009 16:08:44 -0600 (CST)
Received: from [192.168.1.104]
	(24-196-90-60.dhcp.mdsn.wi.charter.com [24.196.90.60])
	by smtpauth1.wiscmail.wisc.edu
	(Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008;
	32bit))
	with ESMTPSA id <0KF200FISTIJ5P50@smtpauth1.wiscmail.wisc.edu> for
	alsa-devel@alsa-project.org; Sat, 14 Feb 2009 16:08:43 -0600 (CST)
In-reply-to: <mailman.2735.1234638846.1965.alsa-devel@alsa-project.org>
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

herton or Takashi,

How does one go about applying a patch like the ones attached to Message 
6?  And to which files are they applied?  I assume they are meant for 
the alsa-driver code, but that's as much as I know (well, I know how to 
run ./configure, make, and make sudo :).  I'd very much like to see if 
the patches work for my HP dv4 1225.

Regards,

Guy

> Message: 6
> Date: Sat, 14 Feb 2009 17:13:55 -0200
> From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> Subject: Re: [alsa-devel] [Fwd: HP DV4 1155 SE - No Sound through
> 	speakers...]
> To: alsa-devel@alsa-project.org
> Cc: Takashi Iwai <tiwai@suse.de>, Tim Barnette
> 	<tim.barnette@gmail.com>, Jean-Pierre Andr?
> 	<jean-pierre.andre@wanadoo.fr>
> Message-ID: <200902141713.55843.herton@mandriva.com.br>
> Content-Type: text/plain; charset="iso-8859-1"
> 
> On Saturday 14 February 2009 08:24:15 Takashi Iwai wrote:
>> > At Fri, 13 Feb 2009 14:22:00 -0500,
>> > Tim Barnette wrote:
>>> > > 
>>> > > ..And it worked!  I now have sound!  Can you tell me what I actually did here?
>> > 
>> > The problem was that your BIOS didn't set the correct default pin
>> > configuration.  The driver doesn't know which pin should be used for
>> > the speaker output, as a consequence, it's set as INPUT.
>> > Now you set it OUTPUT manually by hda-verb, and (fortunately) the
>> > route to that pin was alive even though it wasn't declared, you get
>> > the speaker output now.
>> > 
>> > The next step is to implement a proper pin-config to override by
>> > the driver.  This won't be much work, but hey, wait for a while.
>> > 
>> > (Or, did Herton already work on that?)
> 
> I had added before pin configs for which source came from *.ini files of IDT
> windows drivers provided by HP. But I don't know if they are at all necessary,
> may be just setting config of 0x0d pin should suffice for all hp-dv5 models,
> as all of them have speaker on 0x0d from all reports and also looking at the
> *.ini files.
> 
> I have three patches, you can choose one of them  :) , see attached. The first
> one is my previous pin configs work "let's set for all cases the pin configs
> based on *.ini files", the others are same smaller change/less intrusive that
> instead just deals with this hp dv4 case.
> 
>> > 
>> > 
>> > thanks,
>> > 
>> > Takashi
>> > 
>>> > > 
>>> > > On Fri, Feb 13, 2009 at 2:16 PM, Tim Barnette <tim.barnette@gmail.com> wrote:
>>> > > 
>>> > >     Takashi, I was able to build hda-verb and when I executed the command
>>> > >     below, it responded with:
>>> > >     nid=0xd, verb=0x707, param=0x40
>>> > >     value=0x0
>>> > > 
>>> > >     On Mon, Feb 2, 2009 at 10:25 AM, Takashi Iwai <tiwai@suse.de> wrote:
>>> > >    
>>> > >         At Mon, 2 Feb 2009 10:17:03 -0500,
>>> > >         Tim Barnette wrote:
>>> > >         >
>>> > >         > Thanks, Takashi. I made this change and rebooted.
>>> > >         >
>>> > >         > I noticed right away the mute light is no longer on... but still no
>>> > >         sound
>>> > >         > through speakers, only headphones..
>>> > >         >
>>> > >         > /sys/module/snd_hda_intel/parameters/model
>>> > >         > contains
>>> > >         > hp-dv5,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
>>> > >         >
>>> > >         > attached is the alsa-info.txt you requested..
>>> > >        
>>> > >         Did you try the latest alsa-driver snapshot?
>>> > >        
>>> > >         If it still doesn't work, I guess this is a BIOS problem.
>>> > >         The other HP dv laptops show the widget 0x0d as the speaker while
>>> > >         yours is unused.
>>> > >        
>>> > >         Try to run:
>>> > >                hda-verb /dev/snd/hwC0D0 0x0d SET_PIN_WID 0x40
>>> > > 
>>> > >         Takashi
> 
> --
> []'s
> Herton
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: patch1.patch
> Type: text/x-patch
> Size: 5653 bytes
> Desc: not available
> Url : http://mailman.alsa-project.org/pipermail/alsa-devel/attachments/20090214/1e371092/attachment.patch 
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: patch2.patch
> Type: text/x-patch
> Size: 2573 bytes
> Desc: not available
> Url : http://mailman.alsa-project.org/pipermail/alsa-devel/attachments/20090214/1e371092/attachment-0001.patch 
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: patch3.patch
> Type: text/x-patch
> Size: 1406 bytes
> Desc: not available
> Url : http://mailman.alsa-project.org/pipermail/alsa-devel/attachments/20090214/1e371092/attachment-0002.patch 
> 
> ------------------------------
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 
> End of Alsa-devel Digest, Vol 24, Issue 68
> ******************************************
