From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Help with supporting Emu10k1x  and question
Date: Sun, 22 Feb 2004 01:06:17 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40380089.9040806@superbug.demon.co.uk>
References: <BAY10-F84ueolj8Jecd00000c83@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <BAY10-F84ueolj8Jecd00000c83@hotmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bastien Aracil <findbastien@hotmail.com>
Cc: fmoraes74@netzero.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Bastien Aracil wrote:
> At Mon, 16 Feb 2004 18:39:46 -0500,
> Francisco Moraes wrote:
> 
>> I am trying to get the Emu10k1x chip supported in alsa. Anyone willing 
>> to give me a hand, please > email me. I've got a few register dumps 
>> and I am trying to get it working.
> 
> 
> I'm will be pleased to help you. I got recently a SB Live 5.1! from DELL 
> and so have no sound with Linux. I'm not an expert of sound card driver 
> put I'm motivated to make mine working under linux.
> 
> Let me known what I can do
> 
> Bastien
> 

 From what I can see for the emu10k1x (aka. sb Live 5.1 from Dell) is 
almost exactly the same as the Audigy LS.

It is a very simple device, and the driver should be based more like the 
  snd-intel8x0 driver than the snd-emu10k1 driver.
It has no dsp, and no hardware mixing, and is a single open device. 
Very similar to the intel8x0 feature wise.

If someone will send me a sample sound card, I will get it working.

Cheers
James


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
