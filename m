From: "YongLi" <sdliyong@gmail.com>
Subject: Re: what is the differenct between the mixer simple
	control and control?
Date: Tue, 12 Dec 2006 17:37:08 +0800
Message-ID: <001c01c71dd1$19e6e080$9b01a8c0@LiYong>
References: <001701c71d91$29e119f0$9b01a8c0@LiYong>
	<ad2655cb0612120126vc228388i94440b66d1bbab19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 48F1F19E
	for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2006 10:37:15 +0100 (MET)
Received: by py-out-1112.google.com with SMTP id a25so1181001pyi
	for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2006 01:37:13 -0800 (PST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

----- Original Message ----- 
From: "James Courtier-Dutton" <james.dutton@gmail.com>
To: "YongLi" <sdliyong@gmail.com>
Cc: <alsa-devel@alsa-project.org>
Sent: Tuesday, December 12, 2006 5:26 PM
Subject: Re: [Alsa-devel] what is the differenct between the mixer simple control and control?


> On 12/12/06, YongLi <sdliyong@gmail.com> wrote:
>> Hello All,
>>
>> I am porting an sound chip driver to my ARM dev board.
>>
>> I do not know what is the difference between the mixer simple control and control.
>>
>> for my device driver, amixer contents output 9 controls:
>> numid=3,iface=MIXER,name='Headphone Balance'
>>   ; type=INTEGER,access=rw---,values=1,min=0,max=127,step=0
>>   : values=-1026030912
>> numid=1,iface=MIXER,name='Headphone Volume'
>>   ; type=INTEGER,access=rw---,values=1,min=0,max=127,step=0
>>   : values=0
>> numid=5,iface=MIXER,name='Mic Volume'
>>   ; type=INTEGER,access=rw---,values=1,min=0,max=127,step=0
>>   : values=-1026031332
>> numid=7,iface=MIXER,name='LINE-IN Volume'
>>   ; type=INTEGER,access=rw---,values=1,min=0,max=127,step=0
>>   : values=-1026028952
>> numid=6,iface=MIXER,name='Radio Volume'
>>   ; type=INTEGER,access=rw---,values=1,min=0,max=127,step=0
>>   : values=-1026031472
>> numid=8,iface=MIXER,name='Record Switch'
>>   ; type=INTEGER,access=rw---,values=1,min=0,max=3,step=0
>>   : values=-1026028812
>> numid=9,iface=MIXER,name='Sound Effect'
>>   ; type=INTEGER,access=rw---,values=1,min=0,max=3,step=0
>>   : values=-1026028672
>> numid=4,iface=MIXER,name='Speaker Balance'
>>   ; type=INTEGER,access=rw---,values=1,min=0,max=127,step=0
>>   : values=-1026031192
>> numid=2,iface=MIXER,name='Speaker Volume'
>>   ; type=INTEGER,access=rw---,values=1,min=0,max=127,step=0
>>   : values=-1026031052
>>
>> amixer scontrols output 8 controls:
>> Simple mixer control 'Headphone',0
>> Simple mixer control 'Headphone Balance',0
>> Simple mixer control 'Mic',0
>> Simple mixer control 'LINE-IN',0
>> Simple mixer control 'Radio',0
>> Simple mixer control 'Sound Effect',0
>> Simple mixer control 'Speaker',0
>> Simple mixer control 'Speaker Balance',0
>>
>> The Record Switch control is missing in the simple controls.
>>
>> However, in the device driver, all these controls are the same settings:
>> {
>>   .ctl  = &snd_tlv320aic23_ctl,
>>   .name  = "Record Switch",
>>   .index  = RecordSource,
>>   .reg  = TLV320AIC23_ANALOGPATH,
>>   .def  = 0,
>>   .shift  = 6,
>>   .mask  = TLV320AIC23_APATH_SIDETONE15dB,
>>   .min  = 0,
>>   .max  = 3,
>>  },
>>  {
>>   .ctl  = &snd_tlv320aic23_ctl,
>>   .name  = "Sound Effect",
>>   .index  = SoundEffect,
>>   .reg  = TLV320AIC23_ANALOGPATH,
>>   .def  = 1,
>>   .shift  = 4,
>>   .mask  = TLV320AIC23_APATH_DACEN,
>>   .min  = 0,
>>   .max  = 3,
>>  },
>>
>> How to change this setting to simple control?
>>
>> Thank you
>>
>> Tyler Li
>>
> 
> Can you please post your entire source code to a web site somewhere,
> and then put a link to it here in an email.
> It looks like several things are wrong, but having the source code
> will help us help you better.

Thank you for your help.

This tlv320aic23.c file is used for TI tlv32023 audio codec chip. I got this file from the below website and changed something:
http://www.fluff.org/ben/linux-26/audio9/s3c2410-audio9-codec.patch

However, I think the changed are not related to the mixer controls. If necessary, I can send the modified file through email.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
