From: Florian <alsa@bome.com>
Subject: Re: crash/reboot with rawmidi on ice1712 dual opteron
Date: Wed, 25 Apr 2007 15:56:25 +0200
Message-ID: <462F5E09.3080002@bome.com>
References: <461FD727.8080400@bome.com>	<s5hfy6zcmtc.wl%tiwai@suse.de>	<4626361D.3080801@bome.com>	<s5hmz0y0w6m.wl%tiwai@suse.de>	<462E05BB.4000300@bome.com>	<s5h8xch28o2.wl%tiwai@suse.de>	<462E099A.7000702@bome.com>	<s5h7is1284n.wl%tiwai@suse.de>	<462E103A.3080601@bome.com>	<s5hzm4xzw8w.wl%tiwai@suse.de>	<462E19E0.6040206@bome.com>	<s5hps5tzue1.wl%tiwai@suse.de>	<462E43B6.7050401@bome.com>	<462F1B8E.1040708@64studio.com>	<462F52A0.4060708@bome.com>
	<s5hmz0wy4xg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 894A0249CC
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2007 15:56:27 +0200 (CEST)
In-Reply-To: <s5hmz0wy4xg.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Daniel James <daniel@64studio.com>
List-Id: alsa-devel@alsa-project.org

> I don't know of the MIDI output problem?  Descriptions?

it's the same symptom: MIDI input works, but opening MIDI output
will reboot immediately. I haven't found a similar line to exclude
for MIDI output...

Florian


On 4/25/2007 3:11 PM, Takashi Iwai wrote:
> At Wed, 25 Apr 2007 15:07:44 +0200,
> Florian wrote:
>> it's the hg version from last Monday. In any case, just look for the
>>  string "MPU401_HW_TRID" - it only appears once in the file, then
>> add this condition:
>>
>>      && mpu->hardware != MPU401_HW_ICE1712) {
>>
>> One other thing: this fix does not fix MIDI output.
> 
> I don't know of the MIDI output problem?  Descriptions?
> 
> 
> Takashi
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
