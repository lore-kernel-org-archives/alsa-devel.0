From: Felix Homann <fexpop@web.de>
Subject: Re: M-Audio Fast Track Ultra (8r) mixer: How to verify
 dB	information?
Date: Fri, 10 Sep 2010 09:48:26 +0200
Message-ID: <4C89E2CA.2090206@web.de>
References: <4C89539E.8030701@web.de> <4C89DBC5.7070906@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203]) by alsa0.perex.cz (Postfix) with ESMTP id A5AFF244B6
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 09:48:29 +0200 (CEST)
In-Reply-To: <4C89DBC5.7070906@ladisch.de>
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
Cc: Felix Homann <fexpop@web.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,


Am 10.09.2010 09:18, schrieb Clemens Ladisch:
> I'm using the mixer_vol_tlv TLV
>> callback right now but I'm not sure it produces correct data.
>>      
> Try alsamixer.  Or just post the output of "amixer contents" here.
>
>    

Well, according to alsamixer the mixer values are mapped to a range from 
0 to -128 dB.

'amixer contents' show entries of the form

     numid=112,iface=MIXER,name='DIn8 - Out7 Playback Volume'
       ; type=INTEGER,access=rw---R--,values=1,min=0,max=32768,step=0
       : values=-32768
       | unk-4-0xffffce00,0x00000000,

(numid and name changing of xourse for each control ).

Here are some examples of setting values with amixer:

     :~$ amixer -c 2 cset numid=1 50%
     numid=1,iface=MIXER,name='AIn1 - Out1 Playback Volume'
       ; type=INTEGER,access=rw---R--,values=1,min=0,max=32768,step=0
       : values=16384
       | unk-4-0xffffce00,0x00000000,

     :~$ amixer -c 2 cset numid=1 80%
     numid=1,iface=MIXER,name='AIn1 - Out1 Playback Volume'
       ; type=INTEGER,access=rw---R--,values=1,min=0,max=32768,step=0
       : values=26215
       | unk-4-0xffffce00,0x00000000,


     :~$ amixer -c 2 cset numid=1 100%
     numid=1,iface=MIXER,name='AIn1 - Out1 Playback Volume'
       ; type=INTEGER,access=rw---R--,values=1,min=0,max=32768,step=0
       : values=32768
       | unk-4-0xffffce00,0x00000000,


cat /proc/asound/F8R/usbmixer gives lines like this:

   Unit: 5
     Control: name="DIn8 - Out7 Playback Volume", index=0
     Info: id=5, control=7, cmask=0x8000, channels=1, type="S16"
     Volume: min=-32768, max=0, dBmin=-12800, dBmax=0

How do I tell the controls value range is correctly mapped to the dB values?

Kind regards,

Felix
