From: Jay Foster <jay@systech.com>
Subject: Re: Aplay Fails When Reading From stdin
Date: Fri, 4 May 2018 12:57:35 -0700
Message-ID: <399d9244-ae31-84c0-d587-bc62707a873f@systech.com>
References: <8c51a51a-cfa0-e1a7-0682-8f3c13ddc2a7@systech.com>
 <s5h7eojb3u4.wl-tiwai@suse.de>
Reply-To: jay@systech.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcloudmail.hostconnection.net (rcloudmail.hostconnection.net
 [38.96.19.98]) by alsa0.perex.cz (Postfix) with ESMTP id 221C3266F44
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 21:57:43 +0200 (CEST)
In-Reply-To: <s5h7eojb3u4.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 5/4/2018 12:47 PM, Takashi Iwai wrote:
> On Fri, 04 May 2018 19:51:05 +0200,
> Jay Foster wrote:
>> I recently updated may alsa from 1.1.4.1 to 1.1.6.  I now noticed that
>> aplay does not work properly (the same as 1.1.4.1) when reading the
>> sound file data from stdin.  This might have something to do with the
>> recent change with reading the sound file header.
>>
>> With the previous version of aplay, aplay would report:
>>
>> Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 22050 Hz, Mono
>>
>> With 1.1.6, aplay reports:
>>
>> Playing raw data 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
>>
>> This results in static/noise output.  If I explicitly add the '-f
>> S16_LE -r 22050' options to aplay, then it does play correctly.
>>
>> Is this a known bug and is there a fix?
> It works fine on my system.
>
> % aplay test.wav
> Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
>
> % aplay < ~/test/test.wav
> Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
>
> % aplay --version
> aplay: version 1.1.6 by Jaroslav Kysela <perex@perex.cz>
>
>
> Takashi
>
>
Well, it does not work for me:

cat bird-calls.wav | /usr/bin/aplay -Dplughw:0 --
Playing raw data 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
^CAborted by signal Interrupt...
aplay: pcm_write:2051: write error: Interrupted system call

aplay -Dplughw:0 bird-calls.wav
Playing WAVE 'bird-calls.wav' : Signed 16 bit Little Endian, Rate 44100 
Hz, Stereo

Looks like aplay may now have problems reading from stdin if stdin is a 
pipe.

Jay
