From: Florian <alsa@bome.com>
Subject: Re: crash/reboot with rawmidi on ice1712 dual opteron
Date: Wed, 25 Apr 2007 15:07:44 +0200
Message-ID: <462F52A0.4060708@bome.com>
References: <461FD727.8080400@bome.com>	<s5hfy6zcmtc.wl%tiwai@suse.de>	<4626361D.3080801@bome.com>	<s5hmz0y0w6m.wl%tiwai@suse.de>	<462E05BB.4000300@bome.com>	<s5h8xch28o2.wl%tiwai@suse.de>	<462E099A.7000702@bome.com>	<s5h7is1284n.wl%tiwai@suse.de>	<462E103A.3080601@bome.com>	<s5hzm4xzw8w.wl%tiwai@suse.de>	<462E19E0.6040206@bome.com>	<s5hps5tzue1.wl%tiwai@suse.de>	<462E43B6.7050401@bome.com>
	<462F1B8E.1040708@64studio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by alsa0.perex.cz (Postfix) with ESMTP id CB8C6249BF
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2007 15:07:47 +0200 (CEST)
In-Reply-To: <462F1B8E.1040708@64studio.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel James <daniel@64studio.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

it's the hg version from last Monday. In any case, just look for the
 string "MPU401_HW_TRID" - it only appears once in the file, then
add this condition:

     && mpu->hardware != MPU401_HW_ICE1712) {

One other thing: this fix does not fix MIDI output. Unfortunately I
can't test this now.

Florian


On 4/25/2007 11:12 AM, Daniel James wrote:
> Hi Florian,
> 
>> IT WORKED! I fixed it in this way:
>>
>> mpu401_uart.c:229
>>
>> if (mpu->hardware != MPU401_HW_TRID4DWAVE
>>     && mpu->hardware != MPU401_HW_ICE1712) {
>> 	mpu->write(mpu, 0x00, MPU401D(mpu));
>> 	/*snd_mpu401_uart_clear_rx(mpu);*/
>> }
>>
>> I don't know if this will work on non-AMD machines and if it will
>> work on all ice1712 machines...
> 
> I can test it here - which version is your patch against?
> 
> Cheers!
> 
> Daniel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 

-- 
Florian Bomers
bome.com

-------------------------------------------------------
Music Software, Development Tools:  http://www.bome.com
Java Sound extensions, plugins: http://www.tritonus.org
The Java Sound Resources:    http://www.jsresources.org
-------------------------------------------------------
Please quote this email in your reply. Thanks!
