From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Lost dB volumes on USB headset between 2.6.38 and
 3.0
Date: Tue, 09 Aug 2011 13:19:09 +0200
Message-ID: <4E4117AD.9030506@canonical.com>
References: <4E410361.7010808@canonical.com> <4E410E7D.8050903@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040005050504050406010409"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id CB16A103822
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 13:19:13 +0200 (CEST)
In-Reply-To: <4E410E7D.8050903@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Colin Guthrie <gmane@colin.guthr.ie>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040005050504050406010409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 2011-08-09 12:39, Clemens Ladisch wrote:
> David Henningsson wrote:
>> Hmm, I and Colin Guthrie have found a regression between kernels 2.6.38
>> and 3.0.
>>
>> When running "amixer -D hw:handset" for this device under 2.6.38, the
>> attached file is returned. Under 3.0, the dB information is missing.
>> This can't be intentional, can it?
>
> There are patches that might have introduced bugs, but these two patches
> do remove dB information intentionally:
>
> ALSA: usb-audio - Don't expose broken dB ranges:
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=59bb7f0eebe6
> ALSA: usb-audio - Add volume range check and warn if it too big:
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=80acefff3bc7
>
> Are there any messages in the system log when loading the driver?
> What are the controls' dB ranges (see "amixer contents")?

I'm attaching "amixer contents" from 2.6.38. Colin will attach some 
interesting dmesg output from 3.0 shortly.

-- 
David Henningsson
http://launchpad.net/~diwic

--------------040005050504050406010409
Content-Type: text/x-log;
 name="amixercontents.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="amixercontents.log"

numid=13,iface=MIXER,name='PCM Capture Source'
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'Mic'
  ; Item #1 'Line'
  ; Item #2 'IEC958 In'
  : values=0
numid=3,iface=MIXER,name='Line Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=4,iface=MIXER,name='Line Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=255,step=0
  : values=0,0
  | dBminmax-min=0.00dB,max=47.81dB
numid=10,iface=MIXER,name='Line Capture Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=11,iface=MIXER,name='Line Capture Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=128,step=0
  : values=1,1
  | dBminmax-min=0.18dB,max=23.81dB
numid=1,iface=MIXER,name='Mic Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=2,iface=MIXER,name='Mic Playback Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=255,step=0
  : values=191
  | dBminmax-min=0.00dB,max=47.81dB
numid=7,iface=MIXER,name='Mic Capture Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=8,iface=MIXER,name='Mic Capture Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=128,step=0
  : values=0
  | dBminmax-min=0.18dB,max=23.81dB
numid=12,iface=MIXER,name='IEC958 In Capture Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=9,iface=MIXER,name='Auto Gain Control'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=5,iface=MIXER,name='Speaker Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=6,iface=MIXER,name='Speaker Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=255,step=0
  : values=148,148
  | dBminmax-min=-47.87dB,max=0.06dB

--------------040005050504050406010409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040005050504050406010409--
